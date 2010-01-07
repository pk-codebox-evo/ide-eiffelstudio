/*
 * Copyright (c) 2009 Niels Provos and Nick Mathewson
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/**
   @file buffer_iocp.c

   This module implements overlapped read and write functions for evbuffer
   objects on Windows.
*/

#include "event2/buffer.h"
#include "event2/buffer_compat.h"
#include "event2/util.h"
#include "event2/thread.h"
#include "event-config.h"
#include "util-internal.h"
#include "evthread-internal.h"
#include "evbuffer-internal.h"
#include "iocp-internal.h"
#include "mm-internal.h"

#include <winsock2.h>
#include <windows.h>
#include <stdio.h>

#define MAX_WSABUFS 16

/** An evbuffer that can handle overlapped IO. */
struct evbuffer_overlapped {
	struct evbuffer buffer;
	/** The socket that we're doing overlapped IO on. */
	evutil_socket_t fd;

	/** pending I/O type */
	unsigned read_in_progress : 1;
	unsigned write_in_progress : 1;

	/** The first pinned chain in the buffer. */
	struct evbuffer_chain *first_pinned;

	/** How many chains are pinned; how many of the fields in buffers
	 * are we using. */
	int n_buffers;
	WSABUF buffers[MAX_WSABUFS];
};

/** Given an evbuffer, return the correponding evbuffer structure, or NULL if
 * the evbuffer isn't overlapped. */
static inline struct evbuffer_overlapped *
upcast_evbuffer(struct evbuffer *buf)
{
	if (!buf || !buf->is_overlapped)
		return NULL;
	return EVUTIL_UPCAST(buf, struct evbuffer_overlapped, buffer);
}

/** Unpin all the chains noted as pinned in 'eo'. */
static void
pin_release(struct evbuffer_overlapped *eo, unsigned flag)
{
	int i;
	struct evbuffer_chain *chain = eo->first_pinned;

	for (i = 0; i < eo->n_buffers; ++i) {
		EVUTIL_ASSERT(chain);
		_evbuffer_chain_unpin(chain, flag);
		chain = chain->next;
	}
}

void
evbuffer_commit_read(struct evbuffer *evbuf, ev_ssize_t nBytes)
{
	struct evbuffer_overlapped *buf = upcast_evbuffer(evbuf);
	struct evbuffer_iovec iov[2];
	int n_vec;

	EVBUFFER_LOCK(evbuf, EVTHREAD_WRITE);
	EVUTIL_ASSERT(buf->read_in_progress && !buf->write_in_progress);
	EVUTIL_ASSERT(nBytes >= 0); // XXXX Can this be false?

	evbuffer_unfreeze(evbuf, 0);

	iov[0].iov_base = buf->buffers[0].buf;
	if ((size_t)nBytes <= buf->buffers[0].len) {
		iov[0].iov_len = nBytes;
		n_vec = 1;
	} else {
		iov[0].iov_len = buf->buffers[0].len;
		iov[1].iov_base = buf->buffers[1].buf;
		iov[1].iov_len = nBytes - iov[0].iov_len;
		n_vec = 2;
	}

	if (evbuffer_commit_space(evbuf, iov, n_vec) < 0)
		EVUTIL_ASSERT(0); /* XXXX fail nicer. */

	pin_release(buf, EVBUFFER_MEM_PINNED_R);

	buf->read_in_progress = 0;

	_evbuffer_decref_and_unlock(evbuf);
}

void
evbuffer_commit_write(struct evbuffer *evbuf, ev_ssize_t nBytes)
{
	struct evbuffer_overlapped *buf = upcast_evbuffer(evbuf);

	EVBUFFER_LOCK(evbuf, EVTHREAD_WRITE);
	EVUTIL_ASSERT(buf->write_in_progress && !buf->read_in_progress);
	evbuffer_unfreeze(evbuf, 1);
	evbuffer_drain(evbuf, nBytes);
	pin_release(buf,EVBUFFER_MEM_PINNED_W);
	buf->write_in_progress = 0;
	_evbuffer_decref_and_unlock(evbuf);
}

struct evbuffer *
evbuffer_overlapped_new(evutil_socket_t fd)
{
	struct evbuffer_overlapped *evo;

	evo = mm_calloc(1, sizeof(struct evbuffer_overlapped));

	TAILQ_INIT(&evo->buffer.callbacks);
	evo->buffer.refcnt = 1;

	evo->buffer.is_overlapped = 1;
	evo->fd = fd;

	return &evo->buffer;
}

int
evbuffer_launch_write(struct evbuffer *buf, ev_ssize_t at_most,
		struct event_overlapped *ol)
{
	struct evbuffer_overlapped *buf_o = upcast_evbuffer(buf);
	int r = -1;
	int i;
	struct evbuffer_chain *chain;
	DWORD bytesSent;

	if (!buf) {
		/* No buffer, or it isn't overlapped */
		return -1;
	}

	EVBUFFER_LOCK(buf, EVTHREAD_WRITE);
	EVUTIL_ASSERT(!buf_o->read_in_progress);
	if (buf->freeze_start || buf_o->write_in_progress)
		goto done;
	if (!buf->total_len) {
		/* Nothing to write */
		r = 0;
		goto done;
	} else if (at_most < 0 || (size_t)at_most > buf->total_len) {
		at_most = buf->total_len;
	}
	evbuffer_freeze(buf, 1);

	buf_o->first_pinned = 0;
	buf_o->n_buffers = 0;
	memset(buf_o->buffers, 0, sizeof(buf_o->buffers));

	chain = buf_o->first_pinned = buf->first;

	for (i=0; i < MAX_WSABUFS && chain; ++i, chain=chain->next) {
		WSABUF *b = &buf_o->buffers[i];
		b->buf = chain->buffer + chain->misalign;
		_evbuffer_chain_pin(chain, EVBUFFER_MEM_PINNED_W);

		if ((size_t)at_most > chain->off) {
			b->len = chain->off;
			at_most -= chain->off;
		} else {
			b->len = at_most;
			++i;
			break;
		}
	}

	buf_o->n_buffers = i;
	_evbuffer_incref(buf);
	if (WSASend(buf_o->fd, buf_o->buffers, i, &bytesSent, 0,
		&ol->overlapped, NULL)) {
		int error = WSAGetLastError();
		if (error != WSA_IO_PENDING) {
			/* An actual error. */
			pin_release(buf_o, EVBUFFER_MEM_PINNED_W);
			evbuffer_unfreeze(buf, 1);
			evbuffer_free(buf); /* decref */
			goto done;
		}
	}

	buf_o->write_in_progress = 1;
	r = 0;
done:
	EVBUFFER_UNLOCK(buf, EVTHREAD_WRITE);
	return r;
}

int
evbuffer_launch_read(struct evbuffer *buf, size_t at_most,
		struct event_overlapped *ol)
{
	struct evbuffer_overlapped *buf_o = upcast_evbuffer(buf);
	int r = -1, i;
	int nvecs;
	int npin=0;
	struct evbuffer_chain *chain=NULL;
	DWORD bytesRead;
	DWORD flags = 0;
	struct evbuffer_iovec vecs[MAX_WSABUFS];

	if (!buf_o)
		return -1;
	EVBUFFER_LOCK(buf, EVTHREAD_WRITE);
	EVUTIL_ASSERT(!buf_o->write_in_progress);
	if (buf->freeze_end || buf_o->read_in_progress)
		goto done;

	buf_o->first_pinned = 0;
	buf_o->n_buffers = 0;
	memset(buf_o->buffers, 0, sizeof(buf_o->buffers));

	if (_evbuffer_expand_fast(buf, at_most) == -1)
		goto done;
	evbuffer_freeze(buf, 0);

	nvecs = _evbuffer_read_setup_vecs(buf, at_most,
	    vecs, &chain, 1);
	for (i=0;i<nvecs;++i) {
		WSABUF_FROM_EVBUFFER_IOV(
			&buf_o->buffers[i],
			&vecs[i]);
	}

	buf_o->n_buffers = nvecs;
	buf_o->first_pinned = chain;
	npin=0;
	for ( ; chain; chain = chain->next) {
		_evbuffer_chain_pin(chain, EVBUFFER_MEM_PINNED_R);
		++npin;
	}
	EVUTIL_ASSERT(npin == nvecs);

	_evbuffer_incref(buf);
	if (WSARecv(buf_o->fd, buf_o->buffers, nvecs, &bytesRead, &flags,
	            &ol->overlapped, NULL)) {
		int error = WSAGetLastError();
		if (error != WSA_IO_PENDING) {
			/* An actual error. */
			pin_release(buf_o, EVBUFFER_MEM_PINNED_R);
			evbuffer_unfreeze(buf, 0);
			evbuffer_free(buf); /* decref */
			goto done;
		}
	}

	buf_o->read_in_progress = 1;
	r = 0;
done:
	EVBUFFER_UNLOCK(buf, EVTHREAD_WRITE);
	return r;
}

evutil_socket_t
_evbuffer_overlapped_get_fd(struct evbuffer *buf)
{
	struct evbuffer_overlapped *buf_o = upcast_evbuffer(buf);
	return buf_o ? buf_o->fd : -1;
}

void
_evbuffer_overlapped_set_fd(struct evbuffer *buf, evutil_socket_t fd)
{
	struct evbuffer_overlapped *buf_o = upcast_evbuffer(buf);
	EVBUFFER_LOCK(buf, EVTHREAD_WRITE);
	/* XXX is this right?, should it cancel current I/O operations? */
	if (buf_o)
		buf_o->fd = fd;
	EVBUFFER_UNLOCK(buf, EVTHREAD_WRITE);
}
