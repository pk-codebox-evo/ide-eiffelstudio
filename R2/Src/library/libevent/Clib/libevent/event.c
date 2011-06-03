/*
 * Copyright (c) 2000-2007 Niels Provos <provos@citi.umich.edu>
 * Copyright (c) 2007-2009 Niels Provos and Nick Mathewson
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
#include "event-config.h"

#ifdef WIN32
#include <winsock2.h>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#undef WIN32_LEAN_AND_MEAN
#endif
#include <sys/types.h>
#if !defined(WIN32) && defined(_EVENT_HAVE_SYS_TIME_H)
#include <sys/time.h>
#endif
#include <sys/queue.h>
#ifdef _EVENT_HAVE_SYS_SOCKET_H
#include <sys/socket.h>
#endif
#include <stdio.h>
#include <stdlib.h>
#ifdef _EVENT_HAVE_UNISTD_H
#include <unistd.h>
#endif
#ifdef _EVENT_HAVE_SYS_EVENTFD_H
#include <sys/eventfd.h>
#endif
#include <ctype.h>
#include <errno.h>
#include <signal.h>
#include <string.h>
#include <time.h>

#include "event2/event.h"
#include "event2/event_struct.h"
#include "event2/event_compat.h"
#include "event-internal.h"
#include "defer-internal.h"
#include "evthread-internal.h"
#include "event2/thread.h"
#include "event2/util.h"
#include "log-internal.h"
#include "evmap-internal.h"
#include "iocp-internal.h"

#ifdef _EVENT_HAVE_EVENT_PORTS
extern const struct eventop evportops;
#endif
#ifdef _EVENT_HAVE_SELECT
extern const struct eventop selectops;
#endif
#ifdef _EVENT_HAVE_POLL
extern const struct eventop pollops;
#endif
#ifdef _EVENT_HAVE_EPOLL
extern const struct eventop epollops;
#endif
#ifdef _EVENT_HAVE_WORKING_KQUEUE
extern const struct eventop kqops;
#endif
#ifdef _EVENT_HAVE_DEVPOLL
extern const struct eventop devpollops;
#endif
#ifdef WIN32
extern const struct eventop win32ops;
#endif

/* In order of preference */
static const struct eventop *eventops[] = {
#ifdef _EVENT_HAVE_EVENT_PORTS
	&evportops,
#endif
#ifdef _EVENT_HAVE_WORKING_KQUEUE
	&kqops,
#endif
#ifdef _EVENT_HAVE_EPOLL
	&epollops,
#endif
#ifdef _EVENT_HAVE_DEVPOLL
	&devpollops,
#endif
#ifdef _EVENT_HAVE_POLL
	&pollops,
#endif
#ifdef _EVENT_HAVE_SELECT
	&selectops,
#endif
#ifdef WIN32
	&win32ops,
#endif
	NULL
};

/* Global state */
struct event_base *current_base = NULL;
extern struct event_base *evsig_base;
static int use_monotonic;

/* Prototypes */
static inline int event_add_internal(struct event *ev,
    const struct timeval *tv, int tv_is_absolute);
static inline int event_del_internal(struct event *ev);

static void	event_queue_insert(struct event_base *, struct event *, int);
static void	event_queue_remove(struct event_base *, struct event *, int);
static int	event_haveevents(struct event_base *);

static void	event_process_active(struct event_base *);

static int	timeout_next(struct event_base *, struct timeval **);
static void	timeout_process(struct event_base *);
static void	timeout_correct(struct event_base *, struct timeval *);

static inline void	event_signal_closure(struct event_base *, struct event *ev);
static inline void	event_persist_closure(struct event_base *, struct event *ev);

static int	evthread_notify_base(struct event_base *base);

static void
detect_monotonic(void)
{
#if defined(_EVENT_HAVE_CLOCK_GETTIME) && defined(CLOCK_MONOTONIC)
	struct timespec	ts;
	static int use_monotonic_initialized = 0;

	if (use_monotonic_initialized)
		return;

	if (clock_gettime(CLOCK_MONOTONIC, &ts) == 0)
		use_monotonic = 1;

	use_monotonic_initialized = 1;
#endif
}

static int
gettime(struct event_base *base, struct timeval *tp)
{
	if (base->tv_cache.tv_sec) {
		*tp = base->tv_cache;
		return (0);
	}

#if defined(_EVENT_HAVE_CLOCK_GETTIME) && defined(CLOCK_MONOTONIC)
	if (use_monotonic) {
		struct timespec	ts;

		if (clock_gettime(CLOCK_MONOTONIC, &ts) == -1)
			return (-1);

		tp->tv_sec = ts.tv_sec;
		tp->tv_usec = ts.tv_nsec / 1000;
		return (0);
	}
#endif

	return (evutil_gettimeofday(tp, NULL));
}

static inline void
clear_time_cache(struct event_base *base)
{
	base->tv_cache.tv_sec = 0;
}

static inline void
update_time_cache(struct event_base *base)
{
	base->tv_cache.tv_sec = 0;
	if (!(base->flags & EVENT_BASE_FLAG_NO_CACHE_TIME))
	    gettime(base, &base->tv_cache);
}

struct event_base *
event_init(void)
{
	struct event_base *base = event_base_new_with_config(NULL);

	if (base == NULL)
		event_errx(1, "%s: Unable to construct event_base", __func__);

	current_base = base;

	return (base);
}

struct event_base *
event_base_new(void)
{
	struct event_base *base = NULL;
	struct event_config *cfg = event_config_new();
	if (cfg) {
		base = event_base_new_with_config(cfg);
		event_config_free(cfg);
	}
	return base;
}

static int
event_config_is_avoided_method(struct event_config *cfg, const char *method)
{
	struct event_config_entry *entry;

	TAILQ_FOREACH(entry, &cfg->entries, next) {
		if (entry->avoid_method != NULL &&
		    strcmp(entry->avoid_method, method) == 0)
			return (1);
	}

	return (0);
}

static int
event_is_method_disabled(const char *name)
{
	char environment[64];
	int i;

	evutil_snprintf(environment, sizeof(environment), "EVENT_NO%s", name);
	for (i = 8; environment[i] != '\0'; ++i)
		environment[i] = toupper(environment[i]);
	return (evutil_getenv(environment) != NULL);
}

int
event_base_get_features(struct event_base *base)
{
	return base->evsel->features;
}

void
event_deferred_cb_queue_init(struct deferred_cb_queue *cb)
{
	memset(cb, 0, sizeof(struct deferred_cb_queue));
	TAILQ_INIT(&cb->deferred_cb_list);
}

static void
notify_base_cbq_callback(struct deferred_cb_queue *cb, void *baseptr)
{
	struct event_base *base = baseptr;
	if (!EVBASE_IN_THREAD(base))
	    evthread_notify_base(base);
}

struct deferred_cb_queue *
event_base_get_deferred_cb_queue(struct event_base *base)
{
	return base ? &base->defer_queue : NULL;
}

struct event_base *
event_base_new_with_config(struct event_config *cfg)
{
	int i;
	struct event_base *base;
	int should_check_environment;

	if ((base = mm_calloc(1, sizeof(struct event_base))) == NULL) {
		event_warn("%s: calloc", __func__);
		return NULL;
	}

	detect_monotonic();
	gettime(base, &base->event_tv);

	min_heap_ctor(&base->timeheap);
	TAILQ_INIT(&base->eventqueue);
	base->sig.ev_signal_pair[0] = -1;
	base->sig.ev_signal_pair[1] = -1;

	event_deferred_cb_queue_init(&base->defer_queue);
	base->defer_queue.notify_fn = notify_base_cbq_callback;
	base->defer_queue.notify_arg = base;
	if (cfg)
		base->flags = cfg->flags;

	evmap_io_initmap(&base->io);
	evmap_signal_initmap(&base->sigmap);

	base->evbase = NULL;

	should_check_environment =
	    !(cfg && (cfg->flags & EVENT_BASE_FLAG_IGNORE_ENV));

	for (i = 0; eventops[i] && !base->evbase; i++) {
		if (cfg != NULL) {
			/* determine if this backend should be avoided */
			if (event_config_is_avoided_method(cfg,
				eventops[i]->name))
				continue;
			if ((eventops[i]->features & cfg->require_features)
			    != cfg->require_features)
				continue;
		}

		/* also obey the environment variables */
		if (should_check_environment &&
		    event_is_method_disabled(eventops[i]->name))
			continue;

		base->evsel = eventops[i];

		base->evbase = base->evsel->init(base);
	}

	if (base->evbase == NULL) {
		event_warnx("%s: no event mechanism available",
		    __func__);
		event_base_free(base);
		return NULL;
	}

	if (evutil_getenv("EVENT_SHOW_METHOD"))
		event_msgx("libevent using: %s", base->evsel->name);

	/* allocate a single active event queue */
	if (event_base_priority_init(base, 1) < 0) {
		event_base_free(base);
		return NULL;
	}

	/* prepare for threading */
	base->th_notify_fd[0] = -1;
	base->th_notify_fd[1] = -1;

#ifndef _EVENT_DISABLE_THREAD_SUPPORT
	if (!cfg || !(cfg->flags & EVENT_BASE_FLAG_NOLOCK)) {
		int r;
		EVTHREAD_ALLOC_LOCK(base->th_base_lock);
		base->defer_queue.lock = base->th_base_lock;
		EVTHREAD_ALLOC_LOCK(base->current_event_lock);
		r = evthread_make_base_notifiable(base);
		if (r<0) {
			event_base_free(base);
			return NULL;
		}
	}
#endif

#ifdef WIN32
	if (cfg && (cfg->flags & EVENT_BASE_FLAG_STARTUP_IOCP))
		event_base_start_iocp(base);
#endif

	return (base);
}

int
event_base_start_iocp(struct event_base *base)
{
#ifdef WIN32
	if (base->iocp)
		return 0;
	base->iocp = event_iocp_port_launch();
	if (!base->iocp) {
		event_warnx("%s: Couldn't launch IOCP", __func__);
		return -1;
	}
	return 0;
#else
	return -1;
#endif
}

void
event_base_free(struct event_base *base)
{
	int i, n_deleted=0;
	struct event *ev;
	/* XXXX grab the lock? If there is contention when one thread frees
	 * the base, then the contending thread will be very sad soon. */

	if (base == NULL && current_base)
		base = current_base;
	if (base == current_base)
		current_base = NULL;

	/* XXX(niels) - check for internal events first */
	EVUTIL_ASSERT(base);

	/* threading fds if we have them */
	if (base->th_notify_fd[0] != -1) {
		event_del(&base->th_notify);
		EVUTIL_CLOSESOCKET(base->th_notify_fd[0]);
		EVUTIL_CLOSESOCKET(base->th_notify_fd[1]);
		base->th_notify_fd[0] = -1;
		base->th_notify_fd[1] = -1;
	}

	/* Delete all non-internal events. */
	for (ev = TAILQ_FIRST(&base->eventqueue); ev; ) {
		struct event *next = TAILQ_NEXT(ev, ev_next);
		if (!(ev->ev_flags & EVLIST_INTERNAL)) {
			event_del(ev);
			++n_deleted;
		}
		ev = next;
	}
	while ((ev = min_heap_top(&base->timeheap)) != NULL) {
		event_del(ev);
		++n_deleted;
	}
	for (i = 0; i < base->n_common_timeouts; ++i) {
		struct common_timeout_list *ctl =
		    base->common_timeout_queues[i];
		event_del(&ctl->timeout_event); /* Internal; doesn't count */
		for (ev = TAILQ_FIRST(&ctl->events); ev; ) {
			struct event *next = TAILQ_NEXT(ev,
			    ev_timeout_pos.ev_next_with_common_timeout);
			if (!(ev->ev_flags & EVLIST_INTERNAL)) {
				event_del(ev);
				++n_deleted;
			}
			ev = next;
		}
		mm_free(ctl);
	}
	if (base->common_timeout_queues)
		mm_free(base->common_timeout_queues);

	for (i = 0; i < base->nactivequeues; ++i) {
		for (ev = TAILQ_FIRST(&base->activequeues[i]); ev; ) {
			struct event *next = TAILQ_NEXT(ev, ev_active_next);
			if (!(ev->ev_flags & EVLIST_INTERNAL)) {
				event_del(ev);
				++n_deleted;
			}
			ev = next;
		}
	}

	if (n_deleted)
		event_debug(("%s: %d events were still set in base",
			__func__, n_deleted));

	if (base->evsel != NULL && base->evsel->dealloc != NULL)
		base->evsel->dealloc(base);

	for (i = 0; i < base->nactivequeues; ++i)
		EVUTIL_ASSERT(TAILQ_EMPTY(&base->activequeues[i]));

	EVUTIL_ASSERT(min_heap_empty(&base->timeheap));
	min_heap_dtor(&base->timeheap);

	mm_free(base->activequeues);

	EVUTIL_ASSERT(TAILQ_EMPTY(&base->eventqueue));

	evmap_io_clear(&base->io);
	evmap_signal_clear(&base->sigmap);

	EVTHREAD_FREE_LOCK(base->th_base_lock);
	EVTHREAD_FREE_LOCK(base->current_event_lock);

	mm_free(base);
}

/* reinitialize the event base after a fork */
int
event_reinit(struct event_base *base)
{
	/* XXXX Do we need to grab a lock here? */
	const struct eventop *evsel = base->evsel;
	int res = 0;
	struct event *ev;

	/* check if this event mechanism requires reinit */
	if (!evsel->need_reinit)
		return (0);

	/* prevent internal delete */
	if (base->sig.ev_signal_added) {
		/* we cannot call event_del here because the base has
		 * not been reinitialized yet. */
		event_queue_remove(base, &base->sig.ev_signal,
		    EVLIST_INSERTED);
		if (base->sig.ev_signal.ev_flags & EVLIST_ACTIVE)
			event_queue_remove(base, &base->sig.ev_signal,
			    EVLIST_ACTIVE);
		base->sig.ev_signal_added = 0;
	}

	if (base->evsel->dealloc != NULL)
		base->evsel->dealloc(base);
	base->evbase = evsel->init(base);
	if (base->evbase == NULL)
		event_errx(1, "%s: could not reinitialize event mechanism",
		    __func__);

	evmap_io_clear(&base->io);
	evmap_signal_clear(&base->sigmap);

	TAILQ_FOREACH(ev, &base->eventqueue, ev_next) {
		if (ev->ev_events & (EV_READ|EV_WRITE)) {
			if (evmap_io_add(base, ev->ev_fd, ev) == -1)
				res = -1;
		} else if (ev->ev_events & EV_SIGNAL) {
			if (evmap_signal_add(base, ev->ev_fd, ev) == -1)
				res = -1;
		}
	}

	return (res);
}

const char **
event_get_supported_methods(void)
{
	static const char **methods = NULL;
	const struct eventop **method;
	const char **tmp;
	int i = 0, k;

	/* count all methods */
	for (method = &eventops[0]; *method != NULL; ++method) {
		++i;
	}

	/* allocate one more than we need for the NULL pointer */
	tmp = mm_calloc((i + 1), sizeof(char *));
	if (tmp == NULL)
		return (NULL);

	/* populate the array with the supported methods */
	for (k = 0, i = 0; eventops[k] != NULL; ++k) {
		tmp[i++] = eventops[k]->name;
	}
	tmp[i] = NULL;

	if (methods != NULL)
		mm_free((char**)methods);

	methods = tmp;

	return (methods);
}

struct event_config *
event_config_new(void)
{
	struct event_config *cfg = mm_calloc(1, sizeof(*cfg));

	if (cfg == NULL)
		return (NULL);

	TAILQ_INIT(&cfg->entries);

	return (cfg);
}

static void
event_config_entry_free(struct event_config_entry *entry)
{
	if (entry->avoid_method != NULL)
		mm_free((char *)entry->avoid_method);
	mm_free(entry);
}

void
event_config_free(struct event_config *cfg)
{
	struct event_config_entry *entry;

	while ((entry = TAILQ_FIRST(&cfg->entries)) != NULL) {
		TAILQ_REMOVE(&cfg->entries, entry, next);
		event_config_entry_free(entry);
	}
	mm_free(cfg);
}


int
event_config_set_flag(struct event_config *cfg, int flag)
{
	if (!cfg)
		return -1;
	cfg->flags |= flag;
	return 0;
}

int
event_config_avoid_method(struct event_config *cfg, const char *method)
{
	struct event_config_entry *entry = mm_malloc(sizeof(*entry));
	if (entry == NULL)
		return (-1);

	if ((entry->avoid_method = mm_strdup(method)) == NULL) {
		mm_free(entry);
		return (-1);
	}

	TAILQ_INSERT_TAIL(&cfg->entries, entry, next);

	return (0);
}

int
event_config_require_features(struct event_config *cfg,
                              int features)
{
	if (!cfg)
		return (-1);
	cfg->require_features = features;
	return (0);
}

int
event_priority_init(int npriorities)
{
  return event_base_priority_init(current_base, npriorities);
}

int
event_base_priority_init(struct event_base *base, int npriorities)
{
	int i;

	if (N_ACTIVE_CALLBACKS(base) || npriorities < 1
	    || npriorities >= EVENT_MAX_PRIORITIES)
		return (-1);

	if (npriorities == base->nactivequeues)
		return (0);

	if (base->nactivequeues) {
		mm_free(base->activequeues);
		base->nactivequeues = 0;
	}

	/* Allocate our priority queues */
	base->activequeues = (struct event_list *)
	  mm_calloc(npriorities, sizeof(struct event_list));
	if (base->activequeues == NULL) {
		event_warn("%s: calloc", __func__);
		return (-1);
	}
	base->nactivequeues = npriorities;
				
	for (i = 0; i < base->nactivequeues; ++i) {
		TAILQ_INIT(&base->activequeues[i]);
	}

	return (0);
}

static int
event_haveevents(struct event_base *base)
{
	/* Caller must hold th_base_lock */
	return (base->event_count > 0);
}

static inline void
event_signal_closure(struct event_base *base, struct event *ev)
{
	short ncalls;

	/* Allows deletes to work */
	ncalls = ev->ev_ncalls;
	ev->ev_pncalls = &ncalls;
	while (ncalls) {
		ncalls--;
		ev->ev_ncalls = ncalls;
		(*ev->ev_callback)((int)ev->ev_fd, ev->ev_res, ev->ev_arg);
		if (base->event_break)
			return;
	}
}

#define MICROSECONDS_MASK       0x000fffff
#define COMMON_TIMEOUT_IDX_MASK 0x0ff00000
#define COMMON_TIMEOUT_IDX_SHIFT 20
#define COMMON_TIMEOUT_MASK     0xf0000000
#define COMMON_TIMEOUT_MAGIC    0x50000000

#define COMMON_TIMEOUT_IDX(tv) \
	(((tv)->tv_usec & COMMON_TIMEOUT_IDX_MASK)>>COMMON_TIMEOUT_IDX_SHIFT)

static inline int
is_common_timeout(const struct timeval *tv,
    const struct event_base *base)
{
	int idx;
	if ((tv->tv_usec & COMMON_TIMEOUT_MASK) != COMMON_TIMEOUT_MAGIC)
		return 0;
	idx = COMMON_TIMEOUT_IDX(tv);
	return idx < base->n_common_timeouts;
}

/* True iff tv1 and tv2 have the same common-timeout index, or if neither
 * one is a common timeout. */
static inline int
is_same_common_timeout(const struct timeval *tv1, const struct timeval *tv2)
{
	return (tv1->tv_usec & ~MICROSECONDS_MASK) ==
	    (tv2->tv_usec & ~MICROSECONDS_MASK);
}

static inline struct common_timeout_list *
get_common_timeout_list(struct event_base *base, const struct timeval *tv)
{
	return base->common_timeout_queues[COMMON_TIMEOUT_IDX(tv)];
}

static inline int
common_timeout_ok(const struct timeval *tv,
    struct event_base *base)
{
	const struct timeval *expect =
	    &get_common_timeout_list(base, tv)->duration;
	return tv->tv_sec == expect->tv_sec &&
	    tv->tv_usec == expect->tv_usec;
}

static void
common_timeout_schedule(struct common_timeout_list *ctl,
    const struct timeval *now, struct event *head)
{
	struct timeval timeout = head->ev_timeout;
	timeout.tv_usec &= MICROSECONDS_MASK;
	event_add_internal(&ctl->timeout_event, &timeout, 1);
}

static void
common_timeout_callback(evutil_socket_t fd, short what, void *arg)
{
	struct timeval now;
	struct common_timeout_list *ctl = arg;
	struct event_base *base = ctl->base;
	struct event *ev = NULL;
	EVBASE_ACQUIRE_LOCK(base, EVTHREAD_WRITE, th_base_lock);
	gettime(base, &now);
	while (1) {
		ev = TAILQ_FIRST(&ctl->events);
		if (!ev || ev->ev_timeout.tv_sec > now.tv_sec ||
		    (ev->ev_timeout.tv_sec == now.tv_sec &&
			(ev->ev_timeout.tv_usec&MICROSECONDS_MASK) > now.tv_usec))
			break;
		event_del_internal(ev);
		event_active_nolock(ev, EV_TIMEOUT, 1);
	}
	if (ev)
		common_timeout_schedule(ctl, &now, ev);
	EVBASE_RELEASE_LOCK(base, EVTHREAD_WRITE, th_base_lock);
}

#define MAX_COMMON_TIMEOUTS 256

const struct timeval *
event_base_init_common_timeout(struct event_base *base,
    const struct timeval *duration)
{
	int i;
	struct timeval tv;
	const struct timeval *result=NULL;
	struct common_timeout_list *new_ctl;

	EVBASE_ACQUIRE_LOCK(base, EVTHREAD_WRITE, th_base_lock);
	if (duration->tv_usec > 1000000) {
		memcpy(&tv, duration, sizeof(struct timeval));
		if (is_common_timeout(duration, base))
			tv.tv_usec &= MICROSECONDS_MASK;
		tv.tv_sec += tv.tv_usec / 1000000;
		tv.tv_usec %= 1000000;
		duration = &tv;
	}
	for (i = 0; i < base->n_common_timeouts; ++i) {
		const struct common_timeout_list *ctl =
		    base->common_timeout_queues[i];
		if (duration->tv_sec == ctl->duration.tv_sec &&
		    duration->tv_usec ==
		    (ctl->duration.tv_usec & MICROSECONDS_MASK)) {
			EVUTIL_ASSERT(is_common_timeout(&ctl->duration, base));
			result = &ctl->duration;
			goto done;
		}
	}
	if (base->n_common_timeouts == MAX_COMMON_TIMEOUTS) {
		event_warn("%s: Too many common timeouts already in use; "
		    "we only support %d per event_base", __func__,
		    MAX_COMMON_TIMEOUTS);
		goto done;
	}
	if (base->n_common_timeouts_allocated == base->n_common_timeouts) {
		int n = base->n_common_timeouts < 16 ? 16 :
		    base->n_common_timeouts*2;
		struct common_timeout_list **newqueues =
		    mm_realloc(base->common_timeout_queues,
			n*sizeof(struct common_timeout_queue *));
		if (!newqueues) {
			event_warn("%s: realloc",__func__);
			goto done;
		}
		base->n_common_timeouts_allocated = n;
		base->common_timeout_queues = newqueues;
	}
	new_ctl = mm_calloc(1, sizeof(struct common_timeout_list));
	if (!new_ctl) {
		event_warn("%s: calloc",__func__);
		goto done;
	}
	TAILQ_INIT(&new_ctl->events);
	new_ctl->duration.tv_sec = duration->tv_sec;
	new_ctl->duration.tv_usec =
	    duration->tv_usec | COMMON_TIMEOUT_MAGIC |
	    (base->n_common_timeouts << COMMON_TIMEOUT_IDX_SHIFT);
	evtimer_assign(&new_ctl->timeout_event, base,
	    common_timeout_callback, new_ctl);
	new_ctl->timeout_event.ev_flags |= EVLIST_INTERNAL;
	event_priority_set(&new_ctl->timeout_event, 0);
	new_ctl->base = base;
	base->common_timeout_queues[base->n_common_timeouts++] = new_ctl;
	result = &new_ctl->duration;

done:
	if (result)
		EVUTIL_ASSERT(is_common_timeout(result, base));

	EVBASE_RELEASE_LOCK(base, EVTHREAD_WRITE, th_base_lock);
	return result;
}

static inline void
event_persist_closure(struct event_base *base, struct event *ev)
{
	/* reschedule the persistent event if we have a timeout. */
	if (ev->ev_io_timeout.tv_sec || ev->ev_io_timeout.tv_usec) {
		/* We want it to run at an interval of ev_io_timeout after the
		 * last time it was _scheduled_ for, not ev_io_timeout after
		 * _now_. */
		struct timeval run_at;
		EVUTIL_ASSERT(is_same_common_timeout(&ev->ev_timeout,
			&ev->ev_io_timeout));
		if (is_common_timeout(&ev->ev_timeout, base)) {
			ev_uint32_t usec_mask;
			struct timeval delay, last_at;
			last_at = ev->ev_timeout;
			delay = ev->ev_io_timeout;
			usec_mask = delay.tv_usec & ~MICROSECONDS_MASK;
			last_at.tv_usec &= MICROSECONDS_MASK;
			delay.tv_usec &= MICROSECONDS_MASK;
			evutil_timeradd(&last_at, &delay, &run_at);
			run_at.tv_usec |= usec_mask;
		} else {
			evutil_timeradd(&ev->ev_io_timeout, &ev->ev_timeout,
			    &run_at);
		}
		event_add_internal(ev, &run_at, 1);
	}
	(*ev->ev_callback)((int)ev->ev_fd, ev->ev_res, ev->ev_arg);
}

/*
  Helper for event_process_active to process all the events in a single queue,
  releasing the lock as we go.  This function requires that the lock be held
  when it's invoked.  Returns -1 if we get a signal or an event_break that
  means we should stop processing any active events now.  Otherwise returns
  the number of non-internal events that we processed.
*/
static int
event_process_active_single_queue(struct event_base *base,
    struct event_list *activeq)
{
	struct event *ev;
	int count = 0;

	EVUTIL_ASSERT(activeq != NULL);

	for (ev = TAILQ_FIRST(activeq); ev; ev = TAILQ_FIRST(activeq)) {
		if (ev->ev_events & EV_PERSIST)
			event_queue_remove(base, ev, EVLIST_ACTIVE);
		else
			event_del_internal(ev);
		if (!(ev->ev_flags & EVLIST_INTERNAL))
			++count;

		event_debug((
			 "event_process_active: event: %p, %s%scall %p",
			ev,
			ev->ev_res & EV_READ ? "EV_READ " : " ",
			ev->ev_res & EV_WRITE ? "EV_WRITE " : " ",
			ev->ev_callback));

		base->current_event = ev;

		EVBASE_ACQUIRE_LOCK(base, EVTHREAD_WRITE, current_event_lock);

		EVBASE_RELEASE_LOCK(base,
		    EVTHREAD_WRITE, th_base_lock);

		switch (ev->ev_closure) {
		case EV_CLOSURE_SIGNAL:
			event_signal_closure(base, ev);
			break;
		case EV_CLOSURE_PERSIST:
			event_persist_closure(base, ev);
			break;
		default:
		case EV_CLOSURE_NONE:
			(*ev->ev_callback)(
				(int)ev->ev_fd, ev->ev_res, ev->ev_arg);
			break;
		}

		EVBASE_RELEASE_LOCK(base, EVTHREAD_WRITE, current_event_lock);
		EVBASE_ACQUIRE_LOCK(base, EVTHREAD_WRITE, th_base_lock);
		base->current_event = NULL;

		if (base->event_break)
			return -1;
	}
	return count;
}

static int
event_process_deferred_callbacks(struct deferred_cb_queue *queue, int *breakptr)
{
	int count = 0;
	struct deferred_cb *cb;

	while ((cb = TAILQ_FIRST(&queue->deferred_cb_list))) {
		cb->queued = 0;
		TAILQ_REMOVE(&queue->deferred_cb_list, cb, cb_next);
		--queue->active_count;
		UNLOCK_DEFERRED_QUEUE(queue);

		cb->cb(cb, cb->arg);
		++count;
		if (*breakptr)
			return -1;

		LOCK_DEFERRED_QUEUE(queue);
	}
	return count;
}

/*
 * Active events are stored in priority queues.  Lower priorities are always
 * process before higher priorities.  Low priority events can starve high
 * priority ones.
 */

static void
event_process_active(struct event_base *base)
{
	/* Caller must hold th_base_lock */
	struct event_list *activeq = NULL;
	int i, c;

	for (i = 0; i < base->nactivequeues; ++i) {
		if (TAILQ_FIRST(&base->activequeues[i]) != NULL) {
			activeq = &base->activequeues[i];
			c = event_process_active_single_queue(base, activeq);
			if (c < 0)
				return;
			else if (c > 0)
				break; /* Processed a real event; do not
					* consider lower-priority events */
			/* If we get here, all of the events we processed
			 * were internal.  Continue. */
		}
	}

	event_process_deferred_callbacks(&base->defer_queue,&base->event_break);
}

/*
 * Wait continuously for events.  We exit only if no events are left.
 */

int
event_dispatch(void)
{
	return (event_loop(0));
}

int
event_base_dispatch(struct event_base *event_base)
{
  return (event_base_loop(event_base, 0));
}

const char *
event_base_get_method(struct event_base *base)
{
	EVUTIL_ASSERT(base);
	return (base->evsel->name);
}

static void
event_loopexit_cb(evutil_socket_t fd, short what, void *arg)
{
	struct event_base *base = arg;
	base->event_gotterm = 1;
}

/* not thread safe */
int
event_loopexit(const struct timeval *tv)
{
	return (event_once(-1, EV_TIMEOUT, event_loopexit_cb,
		    current_base, tv));
}

int
event_base_loopexit(struct event_base *event_base, const struct timeval *tv)
{
	return (event_base_once(event_base, -1, EV_TIMEOUT, event_loopexit_cb,
		    event_base, tv));
}

int
event_loopbreak(void)
{
	return (event_base_loopbreak(current_base));
}

int
event_base_loopbreak(struct event_base *event_base)
{
	if (event_base == NULL)
		return (-1);

	EVBASE_ACQUIRE_LOCK(event_base, EVTHREAD_WRITE, th_base_lock);
	event_base->event_break = 1;
	EVBASE_RELEASE_LOCK(event_base, EVTHREAD_WRITE, th_base_lock);

	if (!EVBASE_IN_THREAD(event_base)) {
		return evthread_notify_base(event_base);
	} else {
		return (0);
	}
}

int
event_base_got_break(struct event_base *event_base)
{
	int res;
	EVBASE_ACQUIRE_LOCK(event_base, EVTHREAD_READ, th_base_lock);
	res = event_base->event_break;
	EVBASE_RELEASE_LOCK(event_base, EVTHREAD_READ, th_base_lock);
	return res;
}

int
event_base_got_exit(struct event_base *event_base)
{
	int res;
	EVBASE_ACQUIRE_LOCK(event_base, EVTHREAD_READ, th_base_lock);
	res = event_base->event_gotterm;
	EVBASE_RELEASE_LOCK(event_base, EVTHREAD_READ, th_base_lock);
	return res;
}

/* not thread safe */

int
event_loop(int flags)
{
	return event_base_loop(current_base, flags);
}

int
event_base_loop(struct event_base *base, int flags)
{
	const struct eventop *evsel = base->evsel;
	struct timeval tv;
	struct timeval *tv_p;
	int res, done;

	/* Grab the lock.  We will release it inside evsel.dispatch, and again
	 * as we invoke user callbacks. */
	EVBASE_ACQUIRE_LOCK(base, EVTHREAD_WRITE, th_base_lock);

	clear_time_cache(base);

	if (base->sig.ev_signal_added)
		evsig_base = base;
	done = 0;

#ifndef _EVENT_DISABLE_THREAD_SUPPORT
	base->th_owner_id = EVTHREAD_GET_ID();
#endif

	base->event_gotterm = base->event_break = 0;

	while (!done) {
		/* Terminate the loop if we have been asked to */
		if (base->event_gotterm) {
			break;
		}

		if (base->event_break) {
			break;
		}

		timeout_correct(base, &tv);

		tv_p = &tv;
		if (!N_ACTIVE_CALLBACKS(base) && !(flags & EVLOOP_NONBLOCK)) {
			timeout_next(base, &tv_p);
		} else {
			/*
			 * if we have active events, we just poll new events
			 * without waiting.
			 */
			evutil_timerclear(&tv);
		}

		/* If we have no events, we just exit */
		if (!event_haveevents(base) && !N_ACTIVE_CALLBACKS(base)) {
			event_debug(("%s: no events registered.", __func__));
			return (1);
		}

		/* update last old time */
		gettime(base, &base->event_tv);

		clear_time_cache(base);

		res = evsel->dispatch(base, tv_p);

		if (res == -1)
			return (-1);

		update_time_cache(base);

		timeout_process(base);

		if (N_ACTIVE_CALLBACKS(base)) {
			event_process_active(base);
			if (!base->event_count_active && (flags & EVLOOP_ONCE))
				done = 1;
		} else if (flags & EVLOOP_NONBLOCK)
			done = 1;
	}

	clear_time_cache(base);

	EVBASE_RELEASE_LOCK(base, EVTHREAD_WRITE, th_base_lock);

	event_debug(("%s: asked to terminate loop.", __func__));
	return (0);
}

/* Sets up an event for processing once */

struct event_once {
	struct event ev;

	void (*cb)(evutil_socket_t, short, void *);
	void *arg;
};

/* One-time callback, it deletes itself */

static void
event_once_cb(evutil_socket_t fd, short events, void *arg)
{
	struct event_once *eonce = arg;

	(*eonce->cb)(fd, events, eonce->arg);
	mm_free(eonce);
}

/* not threadsafe, event scheduled once. */
int
event_once(evutil_socket_t fd, short events,
    void (*callback)(evutil_socket_t, short, void *),
	void *arg, const struct timeval *tv)
{
	return event_base_once(current_base, fd, events, callback, arg, tv);
}

/* Schedules an event once */
int
event_base_once(struct event_base *base, evutil_socket_t fd, short events,
    void (*callback)(evutil_socket_t, short, void *),
	void *arg, const struct timeval *tv)
{
	struct event_once *eonce;
	struct timeval etv;
	int res = 0;

	/* We cannot support signals that just fire once, or persistent
	 * events. */
	if (events & (EV_SIGNAL|EV_PERSIST))
		return (-1);

	if ((eonce = mm_calloc(1, sizeof(struct event_once))) == NULL)
		return (-1);

	eonce->cb = callback;
	eonce->arg = arg;

	if (events == EV_TIMEOUT) {
		if (tv == NULL) {
			evutil_timerclear(&etv);
			tv = &etv;
		}

		evtimer_assign(&eonce->ev, base, event_once_cb, eonce);
	} else if (events & (EV_READ|EV_WRITE)) {
		events &= EV_READ|EV_WRITE;

		event_assign(&eonce->ev, base, fd, events, event_once_cb, eonce);
	} else {
		/* Bad event combination */
		mm_free(eonce);
		return (-1);
	}

	if (res == 0)
		res = event_add(&eonce->ev, tv);
	if (res != 0) {
		mm_free(eonce);
		return (res);
	}

	return (0);
}

int
event_assign(struct event *ev, struct event_base *base, evutil_socket_t fd, short events, void (*callback)(evutil_socket_t, short, void *), void *arg)
{
	if (!base)
		base = current_base;
	ev->ev_base = base;

	ev->ev_callback = callback;
	ev->ev_arg = arg;
	ev->ev_fd = fd;
	ev->ev_events = events;
	ev->ev_res = 0;
	ev->ev_flags = EVLIST_INIT;
	ev->ev_ncalls = 0;
	ev->ev_pncalls = NULL;

	if (events & EV_SIGNAL) {
		if ((events & (EV_READ|EV_WRITE)) != 0) {
			event_warnx("%s: EV_SIGNAL is not compatible with "
			    "EV_READ or EV_WRITE", __func__);
			return -1;
		}
		ev->ev_closure = EV_CLOSURE_SIGNAL;
	} else {
		if (events & EV_PERSIST) {
			evutil_timerclear(&ev->ev_io_timeout);
			ev->ev_closure = EV_CLOSURE_PERSIST;
		} else {
			ev->ev_closure = EV_CLOSURE_NONE;
		}
	}

	min_heap_elem_init(ev);

	if (base != NULL) {
		/* by default, we put new events into the middle priority */
		ev->ev_pri = base->nactivequeues / 2;
	}
	return 0;
}

int
event_base_set(struct event_base *base, struct event *ev)
{
	/* Only innocent events may be assigned to a different base */
	if (ev->ev_flags != EVLIST_INIT)
		return (-1);

	ev->ev_base = base;
	ev->ev_pri = base->nactivequeues/2;

	return (0);
}

void
event_set(struct event *ev, evutil_socket_t fd, short events,
	  void (*callback)(evutil_socket_t, short, void *), void *arg)
{
	int r;
	r = event_assign(ev, current_base, fd, events, callback, arg);
       	EVUTIL_ASSERT(r == 0);
}

struct event *
event_new(struct event_base *base, evutil_socket_t fd, short events, void (*cb)(evutil_socket_t, short, void *), void *arg)
{
	struct event *ev;
	ev = mm_malloc(sizeof(struct event));
	if (ev == NULL)
		return (NULL);
	if (event_assign(ev, base, fd, events, cb, arg) < 0) {
		mm_free(ev);
		return (NULL);
	}

	return (ev);
}

void
event_free(struct event *ev)
{
	/* make sure that this event won't be coming back to haunt us. */
	event_del(ev);
	mm_free(ev);
}

/*
 * Set's the priority of an event - if an event is already scheduled
 * changing the priority is going to fail.
 */

int
event_priority_set(struct event *ev, int pri)
{
	if (ev->ev_flags & EVLIST_ACTIVE)
		return (-1);
	if (pri < 0 || pri >= ev->ev_base->nactivequeues)
		return (-1);

	ev->ev_pri = pri;

	return (0);
}

/*
 * Checks if a specific event is pending or scheduled.
 */

int
event_pending(struct event *ev, short event, struct timeval *tv)
{
	struct timeval	now, res;
	int flags = 0;

	if (ev->ev_flags & EVLIST_INSERTED)
		flags |= (ev->ev_events & (EV_READ|EV_WRITE|EV_SIGNAL));
	if (ev->ev_flags & EVLIST_ACTIVE)
		flags |= ev->ev_res;
	if (ev->ev_flags & EVLIST_TIMEOUT)
		flags |= EV_TIMEOUT;

	event &= (EV_TIMEOUT|EV_READ|EV_WRITE|EV_SIGNAL);

	/* See if there is a timeout that we should report */
	if (tv != NULL && (flags & event & EV_TIMEOUT)) {
		struct timeval tmp = ev->ev_timeout;
		gettime(ev->ev_base, &now);
		tmp.tv_usec &= MICROSECONDS_MASK;
		evutil_timersub(&tmp, &now, &res);
		/* correctly remap to real time */
		evutil_gettimeofday(&now, NULL);
		evutil_timeradd(&now, &res, tv);
	}

	return (flags & event);
}

int
_event_initialized(struct event *ev, int need_fd)
{
	if (!(ev->ev_flags & EVLIST_INIT))
		return 0;
#ifdef WIN32
	/* XXX Is this actually a sensible thing to check? -NM */
	if (need_fd && (ev)->ev_fd == (evutil_socket_t)INVALID_HANDLE_VALUE)
		return 0;
#endif
	return 1;
}

evutil_socket_t
event_get_fd(struct event *ev)
{
	return ev->ev_fd;
}

struct event_base *
event_get_base(struct event *ev)
{
	return ev->ev_base;
}

int
event_add(struct event *ev, const struct timeval *tv)
{
	int res;

	EVBASE_ACQUIRE_LOCK(ev->ev_base, EVTHREAD_WRITE, th_base_lock);

	res = event_add_internal(ev, tv, 0);

	EVBASE_RELEASE_LOCK(ev->ev_base, EVTHREAD_WRITE, th_base_lock);

	return (res);
}

static int
evthread_notify_base_default(struct event_base *base)
{
	char buf[1];
	int r;
	buf[0] = (char) 0;
#ifdef WIN32
	r = send(base->th_notify_fd[1], buf, 1, 0);
#else
	r = write(base->th_notify_fd[1], buf, 1);
#endif
	return (r < 0) ? -1 : 0;
}

#if defined(_EVENT_HAVE_EVENTFD) && defined(_EVENT_HAVE_SYS_EVENTFD_H)
static int
evthread_notify_base_eventfd(struct event_base *base)
{
	ev_uint64_t msg = 1;
	int r;
	do {
		r = write(base->th_notify_fd[0], (void*) &msg, sizeof(msg));
	} while (r < 0 && errno == EAGAIN);

	return (r < 0) ? -1 : 0;
}
#endif

static int
evthread_notify_base(struct event_base *base)
{
	if (!base->th_notify_fn)
		return -1;
	return base->th_notify_fn(base);
}

static inline int
event_add_internal(struct event *ev, const struct timeval *tv,
    int tv_is_absolute)
{
	struct event_base *base = ev->ev_base;
	int res = 0;
	int notify = 0;

	event_debug((
		 "event_add: event: %p, %s%s%scall %p",
		 ev,
		 ev->ev_events & EV_READ ? "EV_READ " : " ",
		 ev->ev_events & EV_WRITE ? "EV_WRITE " : " ",
		 tv ? "EV_TIMEOUT " : " ",
		 ev->ev_callback));

	EVUTIL_ASSERT(!(ev->ev_flags & ~EVLIST_ALL));

	/*
	 * prepare for timeout insertion further below, if we get a
	 * failure on any step, we should not change any state.
	 */
	if (tv != NULL && !(ev->ev_flags & EVLIST_TIMEOUT)) {
		if (min_heap_reserve(&base->timeheap,
			1 + min_heap_size(&base->timeheap)) == -1)
			return (-1);  /* ENOMEM == errno */
	}

	if ((ev->ev_events & (EV_READ|EV_WRITE|EV_SIGNAL)) &&
	    !(ev->ev_flags & (EVLIST_INSERTED|EVLIST_ACTIVE))) {
		if (ev->ev_events & (EV_READ|EV_WRITE))
			res = evmap_io_add(base, ev->ev_fd, ev);
		else if (ev->ev_events & EV_SIGNAL)
			res = evmap_signal_add(base, ev->ev_fd, ev);
		if (res != -1)
			event_queue_insert(base, ev, EVLIST_INSERTED);
		if (res == 1) {
			/* evmap says we need to notify the main thread. */
			notify = 1;
			res = 0;
		}
	}

	/*
	 * we should change the timeout state only if the previous event
	 * addition succeeded.
	 */
	if (res != -1 && tv != NULL) {
		struct timeval now;
		int common_timeout;

		/*
		 * for persistent timeout events, we remember the
		 * timeout value and re-add the event.
		 *
		 * If tv_is_absolute, this was already set.
		 */
		if (ev->ev_closure == EV_CLOSURE_PERSIST && !tv_is_absolute)
			ev->ev_io_timeout = *tv;

		/*
		 * we already reserved memory above for the case where we
		 * are not replacing an existing timeout.
		 */
		if (ev->ev_flags & EVLIST_TIMEOUT) {
			/* XXX I believe this is needless. */
			if (min_heap_elt_is_top(ev))
				notify = 1;
			event_queue_remove(base, ev, EVLIST_TIMEOUT);
		}

		/* Check if it is active due to a timeout.  Rescheduling
		 * this timeout before the callback can be executed
		 * removes it from the active list. */
		if ((ev->ev_flags & EVLIST_ACTIVE) &&
		    (ev->ev_res & EV_TIMEOUT)) {
			if (ev->ev_events & EV_SIGNAL) {
				/* See if we are just active executing
				 * this event in a loop
				 */
				if (ev->ev_ncalls && ev->ev_pncalls) {
					/* Abort loop */
					*ev->ev_pncalls = 0;
				}
			}

			event_queue_remove(base, ev, EVLIST_ACTIVE);
		}

		gettime(base, &now);


		common_timeout = is_common_timeout(tv, base);
		if (tv_is_absolute) {
			ev->ev_timeout = *tv;
		} else if (common_timeout) {
			struct timeval tmp = *tv;
			tmp.tv_usec &= MICROSECONDS_MASK;
			evutil_timeradd(&now, &tmp, &ev->ev_timeout);
			ev->ev_timeout.tv_usec |=
			    (tv->tv_usec & ~MICROSECONDS_MASK);
		} else {
			evutil_timeradd(&now, tv, &ev->ev_timeout);
		}

		event_debug((
			 "event_add: timeout in %d seconds, call %p",
			 (int)tv->tv_sec, ev->ev_callback));

		event_queue_insert(base, ev, EVLIST_TIMEOUT);
		if (common_timeout) {
			struct common_timeout_list *ctl =
			    get_common_timeout_list(base, &ev->ev_timeout);
			if (ev == TAILQ_FIRST(&ctl->events)) {
				common_timeout_schedule(ctl, &now, ev);
			}
		} else {
			/* See if the earliest timeout is now earlier than it
			 * was before: if so, we will need to tell the main
			 * thread to wake up earlier than it would
			 * otherwise. */
			if (min_heap_elt_is_top(ev))
				notify = 1;
		}
	}

	/* if we are not in the right thread, we need to wake up the loop */
	if (res != -1 && notify && !EVBASE_IN_THREAD(base))
		evthread_notify_base(base);

	return (res);
}

int
event_del(struct event *ev)
{
	int res;

	EVBASE_ACQUIRE_LOCK(ev->ev_base, EVTHREAD_WRITE, th_base_lock);

	res = event_del_internal(ev);

	EVBASE_RELEASE_LOCK(ev->ev_base, EVTHREAD_WRITE, th_base_lock);

	return (res);
}

/* Helper for event_del: always called with th_base_lock held. */
static inline int
event_del_internal(struct event *ev)
{
	struct event_base *base;
	int res = 0, notify = 0;
	int need_cur_lock;

	event_debug(("event_del: %p, callback %p",
		 ev, ev->ev_callback));

	/* An event without a base has not been added */
	if (ev->ev_base == NULL)
		return (-1);

	/* If the main thread is currently executing this event's callback,
	 * and we are not the main thread, then we want to wait until the
	 * callback is done before we start removing the event.  That way,
	 * when this function returns, it will be safe to free the
	 * user-supplied argument. */
	base = ev->ev_base;
	need_cur_lock = (base->current_event == ev);
	if (need_cur_lock)
		EVBASE_ACQUIRE_LOCK(base, EVTHREAD_WRITE, current_event_lock);

	EVUTIL_ASSERT(!(ev->ev_flags & ~EVLIST_ALL));

	/* See if we are just active executing this event in a loop */
	if (ev->ev_events & EV_SIGNAL) {
		if (ev->ev_ncalls && ev->ev_pncalls) {
			/* Abort loop */
			*ev->ev_pncalls = 0;
		}
	}

	if (ev->ev_flags & EVLIST_TIMEOUT) {
		/* NOTE: We never need to notify the main thread because of a
		 * deleted timeout event: all that could happen if we don't is
		 * that the dispatch loop might wake up too early.  But the
		 * point of notifying the main thread _is_ to wake up the
		 * dispatch loop early anyway, so we wouldn't gain anything by
		 * doing it.
		 */
		event_queue_remove(base, ev, EVLIST_TIMEOUT);
	}

	if (ev->ev_flags & EVLIST_ACTIVE)
		event_queue_remove(base, ev, EVLIST_ACTIVE);

	if (ev->ev_flags & EVLIST_INSERTED) {
		event_queue_remove(base, ev, EVLIST_INSERTED);
		if (ev->ev_events & (EV_READ|EV_WRITE))
			res = evmap_io_del(base, ev->ev_fd, ev);
		else
			res = evmap_signal_del(base, ev->ev_fd, ev);
		if (res == 1) {
			/* evmap says we need to notify the main thread. */
			notify = 1;
			res = 0;
		}
	}

	/* if we are not in the right thread, we need to wake up the loop */
	if (res != -1 && notify && !EVBASE_IN_THREAD(base))
		evthread_notify_base(base);

	if (need_cur_lock)
		EVBASE_RELEASE_LOCK(base, EVTHREAD_WRITE, current_event_lock);

	return (res);
}

void
event_active(struct event *ev, int res, short ncalls)
{
	EVBASE_ACQUIRE_LOCK(ev->ev_base, EVTHREAD_WRITE, th_base_lock);

	event_active_nolock(ev, res, ncalls);

	EVBASE_RELEASE_LOCK(ev->ev_base, EVTHREAD_WRITE, th_base_lock);
}


void
event_active_nolock(struct event *ev, int res, short ncalls)
{
	struct event_base *base;

	/* We get different kinds of events, add them together */
	if (ev->ev_flags & EVLIST_ACTIVE) {
		ev->ev_res |= res;
		return;
	}

	base = ev->ev_base;

	ev->ev_res = res;

	if (ev->ev_events & EV_SIGNAL) {
		ev->ev_ncalls = ncalls;
		ev->ev_pncalls = NULL;
	}

	event_queue_insert(base, ev, EVLIST_ACTIVE);
}

void
event_deferred_cb_init(struct deferred_cb *cb, deferred_cb_fn fn, void *arg)
{
	memset(cb, 0, sizeof(struct deferred_cb));
	cb->cb = fn;
	cb->arg = arg;
}

void
event_deferred_cb_cancel(struct deferred_cb_queue *queue,
    struct deferred_cb *cb)
{
	if (!queue) {
		if (current_base)
			queue = &current_base->defer_queue;
		else
			return;
	}

	LOCK_DEFERRED_QUEUE(queue);
	if (cb->queued) {
		TAILQ_REMOVE(&queue->deferred_cb_list, cb, cb_next);
		--queue->active_count;
		cb->queued = 0;
	}
	UNLOCK_DEFERRED_QUEUE(queue);
}

void
event_deferred_cb_schedule(struct deferred_cb_queue *queue,
    struct deferred_cb *cb)
{
	if (!queue) {
		if (current_base)
			queue = &current_base->defer_queue;
		else
			return;
	}

	LOCK_DEFERRED_QUEUE(queue);
	if (!cb->queued) {
		cb->queued = 1;
		TAILQ_INSERT_TAIL(&queue->deferred_cb_list, cb, cb_next);
		++queue->active_count;
		if (queue->notify_fn)
			queue->notify_fn(queue, queue->notify_arg);
	}
	UNLOCK_DEFERRED_QUEUE(queue);
}

static int
timeout_next(struct event_base *base, struct timeval **tv_p)
{
	/* Caller must hold th_base_lock */
	struct timeval now;
	struct event *ev;
	struct timeval *tv = *tv_p;
	int res = 0;

	ev = min_heap_top(&base->timeheap);

	if (ev == NULL) {
		/* if no time-based events are active wait for I/O */
		*tv_p = NULL;
		goto out;
	}

	if (gettime(base, &now) == -1) {
		res = -1;
		goto out;
	}

	if (evutil_timercmp(&ev->ev_timeout, &now, <=)) {
		evutil_timerclear(tv);
		goto out;
	}

	evutil_timersub(&ev->ev_timeout, &now, tv);

	EVUTIL_ASSERT(tv->tv_sec >= 0);
	EVUTIL_ASSERT(tv->tv_usec >= 0);
	event_debug(("timeout_next: in %d seconds", (int)tv->tv_sec));

out:
	return (res);
}

/*
 * Determines if the time is running backwards by comparing the current
 * time against the last time we checked.  Not needed when using clock
 * monotonic.
 */

static void
timeout_correct(struct event_base *base, struct timeval *tv)
{
	/* Caller must hold th_base_lock. */
	struct event **pev;
	unsigned int size;
	struct timeval off;
	int i;

	if (use_monotonic)
		return;

	/* Check if time is running backwards */
	gettime(base, tv);

	if (evutil_timercmp(tv, &base->event_tv, >=)) {
		base->event_tv = *tv;
		return;
	}

	event_debug(("%s: time is running backwards, corrected",
		    __func__));
	evutil_timersub(&base->event_tv, tv, &off);

	/*
	 * We can modify the key element of the node without destroying
	 * the key, because we apply it to all in the right order.
	 */
	pev = base->timeheap.p;
	size = base->timeheap.n;
	for (; size-- > 0; ++pev) {
		struct timeval *ev_tv = &(**pev).ev_timeout;
		evutil_timersub(ev_tv, &off, ev_tv);
	}
	for (i=0; i<base->n_common_timeouts; ++i) {
		struct event *ev;
		struct common_timeout_list *ctl =
		    base->common_timeout_queues[i];
		TAILQ_FOREACH(ev, &ctl->events,
		    ev_timeout_pos.ev_next_with_common_timeout) {
			struct timeval *ev_tv = &ev->ev_timeout;
			ev_tv->tv_usec &= MICROSECONDS_MASK;
			evutil_timersub(ev_tv, &off, ev_tv);
			ev_tv->tv_usec |= COMMON_TIMEOUT_MAGIC |
			    (i<<COMMON_TIMEOUT_IDX_SHIFT);
		}
	}

	/* Now remember what the new time turned out to be. */
	base->event_tv = *tv;
}

static void
timeout_process(struct event_base *base)
{
	/* Caller must hold lock. */
	struct timeval now;
	struct event *ev;

	if (min_heap_empty(&base->timeheap)) {
		return;
	}

	gettime(base, &now);

	while ((ev = min_heap_top(&base->timeheap))) {
		if (evutil_timercmp(&ev->ev_timeout, &now, >))
			break;

		/* delete this event from the I/O queues */
		event_del_internal(ev);

		event_debug(("timeout_process: call %p",
			 ev->ev_callback));
		event_active_nolock(ev, EV_TIMEOUT, 1);
	}
}

static void
event_queue_remove(struct event_base *base, struct event *ev, int queue)
{
	if (!(ev->ev_flags & queue))
		event_errx(1, "%s: %p(fd %d) not on queue %x", __func__,
			   ev, ev->ev_fd, queue);

	if (~ev->ev_flags & EVLIST_INTERNAL)
		base->event_count--;

	ev->ev_flags &= ~queue;
	switch (queue) {
	case EVLIST_INSERTED:
		TAILQ_REMOVE(&base->eventqueue, ev, ev_next);
		break;
	case EVLIST_ACTIVE:
		base->event_count_active--;
		TAILQ_REMOVE(&base->activequeues[ev->ev_pri],
		    ev, ev_active_next);
		break;
	case EVLIST_TIMEOUT:
		if (is_common_timeout(&ev->ev_timeout, base)) {
			struct common_timeout_list *ctl =
			    get_common_timeout_list(base, &ev->ev_timeout);
			TAILQ_REMOVE(&ctl->events, ev,
			    ev_timeout_pos.ev_next_with_common_timeout);
		} else {
			min_heap_erase(&base->timeheap, ev);
		}
		break;
	default:
		event_errx(1, "%s: unknown queue %x", __func__, queue);
	}
}

static void
insert_common_timeout_inorder(struct common_timeout_list *ctl,
    struct event *ev)
{
	struct event *e;
	TAILQ_FOREACH_REVERSE(e, &ctl->events,
	    ev_timeout_pos.ev_next_with_common_timeout, event_list) {
		/* This timercmp is a little sneaky, since both ev and e have
		 * magic values in tv_usec.  Fortunately, they ought to have
		 * the _same_ magic values in tv_usec.  Let's assert for that.
		 */
		EVUTIL_ASSERT(
			is_same_common_timeout(&e->ev_timeout, &ev->ev_timeout));
		if (evutil_timercmp(&ev->ev_timeout, &e->ev_timeout, >=)) {
			TAILQ_INSERT_AFTER(&ctl->events, e, ev,
			    ev_timeout_pos.ev_next_with_common_timeout);
			return;
		}
	}
	TAILQ_INSERT_HEAD(&ctl->events, ev,
	    ev_timeout_pos.ev_next_with_common_timeout);
}

static void
event_queue_insert(struct event_base *base, struct event *ev, int queue)
{
	if (ev->ev_flags & queue) {
		/* Double insertion is possible for active events */
		if (queue & EVLIST_ACTIVE)
			return;

		event_errx(1, "%s: %p(fd %d) already on queue %x", __func__,
			   ev, ev->ev_fd, queue);
	}

	if (~ev->ev_flags & EVLIST_INTERNAL)
		base->event_count++;

	ev->ev_flags |= queue;
	switch (queue) {
	case EVLIST_INSERTED:
		TAILQ_INSERT_TAIL(&base->eventqueue, ev, ev_next);
		break;
	case EVLIST_ACTIVE:
		base->event_count_active++;
		TAILQ_INSERT_TAIL(&base->activequeues[ev->ev_pri],
		    ev,ev_active_next);
		break;
	case EVLIST_TIMEOUT: {
		if (is_common_timeout(&ev->ev_timeout, base)) {
			struct common_timeout_list *ctl =
			    get_common_timeout_list(base, &ev->ev_timeout);
			insert_common_timeout_inorder(ctl, ev);
		} else
			min_heap_push(&base->timeheap, ev);
		break;
	}
	default:
		event_errx(1, "%s: unknown queue %x", __func__, queue);
	}
}

/* Functions for debugging */

const char *
event_get_version(void)
{
	return (_EVENT_VERSION);
}

ev_uint32_t
event_get_version_number(void)
{
	return (_EVENT_NUMERIC_VERSION);
}

/*
 * No thread-safe interface needed - the information should be the same
 * for all threads.
 */

const char *
event_get_method(void)
{
	return (current_base->evsel->name);
}

#ifndef _EVENT_DISABLE_MM_REPLACEMENT
static void *(*_mm_malloc_fn)(size_t sz) = NULL;
static void *(*_mm_realloc_fn)(void *p, size_t sz) = NULL;
static void (*_mm_free_fn)(void *p) = NULL;

void *
mm_malloc(size_t sz)
{
	if (_mm_malloc_fn)
		return _mm_malloc_fn(sz);
	else
		return malloc(sz);
}

void *
mm_calloc(size_t count, size_t size)
{
	if (_mm_malloc_fn) {
		size_t sz = count * size;
		void *p = _mm_malloc_fn(sz);
		if (p)
			memset(p, 0, sz);
		return p;
	} else
		return calloc(count, size);
}

char *
mm_strdup(const char *str)
{
	if (_mm_malloc_fn) {
		size_t ln = strlen(str);
		void *p = _mm_malloc_fn(ln+1);
		if (p)
			memcpy(p, str, ln+1);
		return p;
	} else
#ifdef WIN32
		return _strdup(str);
#else
		return strdup(str);
#endif
}

void *
mm_realloc(void *ptr, size_t sz)
{
	if (_mm_realloc_fn)
		return _mm_realloc_fn(ptr, sz);
	else
		return realloc(ptr, sz);
}

void
mm_free(void *ptr)
{
	if (_mm_free_fn)
		_mm_free_fn(ptr);
	else
		free(ptr);
}

void
event_set_mem_functions(void *(*malloc_fn)(size_t sz),
			void *(*realloc_fn)(void *ptr, size_t sz),
			void (*free_fn)(void *ptr))
{
	_mm_malloc_fn = malloc_fn;
	_mm_realloc_fn = realloc_fn;
	_mm_free_fn = free_fn;
}
#endif

#ifndef _EVENT_DISABLE_THREAD_SUPPORT
/* support for threading */
void (*_evthread_locking_fn)(int mode, void *lock) = NULL;
unsigned long (*_evthread_id_fn)(void) = NULL;
void *(*_evthread_lock_alloc_fn)(void) = NULL;
void (*_evthread_lock_free_fn)(void *) = NULL;

void
evthread_set_locking_callback(void (*locking_fn)(int mode, void *lock))
{
	_evthread_locking_fn = locking_fn;
}
#endif

#if defined(_EVENT_HAVE_EVENTFD) && defined(_EVENT_HAVE_SYS_EVENTFD_H)
static void
evthread_notify_drain_eventfd(int fd, short what, void *arg)
{
	ev_uint64_t msg;

	read(fd, (void*) &msg, sizeof(msg));
}
#endif

static void
evthread_notify_drain_default(evutil_socket_t fd, short what, void *arg)
{
	unsigned char buf[128];
#ifdef WIN32
	while (recv(fd, (char*)buf, sizeof(buf), 0) > 0)
		;
#else
	while (read(fd, (char*)buf, sizeof(buf)) > 0)
		;
#endif
}

#ifndef _EVENT_DISABLE_THREAD_SUPPORT
void
evthread_set_id_callback(unsigned long (*id_fn)(void))
{
	_evthread_id_fn = id_fn;
}
#endif

int
evthread_make_base_notifiable(struct event_base *base)
{
	void (*cb)(evutil_socket_t, short, void *) = evthread_notify_drain_default;
	int (*notify)(struct event_base *) = evthread_notify_base_default;

	/* XXXX grab the lock here? */
	if (!base)
		return -1;

	if (base->th_notify_fd[0] >= 0)
		return 0;

#if defined(_EVENT_HAVE_EVENTFD) && defined(_EVENT_HAVE_SYS_EVENTFD_H)
	base->th_notify_fd[0] = eventfd(0, 0);
	if (base->th_notify_fd[0] >= 0) {
		notify = evthread_notify_base_eventfd;
		cb = evthread_notify_drain_eventfd;
	} else
#endif
#if defined(_EVENT_HAVE_PIPE)
	{
		if ((base->evsel->features & EV_FEATURE_FDS)) {
			if (pipe(base->th_notify_fd) < 0)
				event_warn("%s: pipe", __func__);
		}
	}
	if (base->th_notify_fd[0] < 0)
#endif

#ifdef WIN32
#define LOCAL_SOCKETPAIR_AF AF_INET
#else
#define LOCAL_SOCKETPAIR_AF AF_UNIX
#endif
	{
		if (evutil_socketpair(LOCAL_SOCKETPAIR_AF, SOCK_STREAM, 0,
			base->th_notify_fd) == -1) {
			event_sock_warn(-1, "%s: socketpair", __func__);
			return (-1);
		}
	}

	evutil_make_socket_nonblocking(base->th_notify_fd[0]);

	base->th_notify_fn = notify;

	/*
	  This can't be right, can it?  We want writes to this socket to
	  just succeed.
	  evutil_make_socket_nonblocking(base->th_notify_fd[1]);
	*/

	/* prepare an event that we can use for wakeup */
	event_assign(&base->th_notify, base, base->th_notify_fd[0],
				 EV_READ|EV_PERSIST, cb, base);

	/* we need to mark this as internal event */
	base->th_notify.ev_flags |= EVLIST_INTERNAL;

	return event_add(&base->th_notify, NULL);
}

#ifndef _EVENT_DISABLE_THREAD_SUPPORT
void
evthread_set_lock_create_callbacks(void *(*alloc_fn)(void),
    void (*free_fn)(void *))
{
	_evthread_lock_alloc_fn = alloc_fn;
	_evthread_lock_free_fn = free_fn;
}
#endif

void
event_base_dump_events(struct event_base *base, FILE *output)
{
	struct event *e;
	int i;
	fprintf(output, "Inserted events:\n");
	TAILQ_FOREACH(e, &base->eventqueue, ev_next) {
		fprintf(output, "  %p [fd %ld]%s%s%s%s%s\n",
				(void*)e, (long)e->ev_fd,
				(e->ev_events&EV_READ)?" Read":"",
				(e->ev_events&EV_WRITE)?" Write":"",
				(e->ev_events&EV_SIGNAL)?" Signal":"",
				(e->ev_events&EV_TIMEOUT)?" Timeout":"",
				(e->ev_events&EV_PERSIST)?" Persist":"");

	}
	for (i = 0; i < base->nactivequeues; ++i) {
		if (TAILQ_EMPTY(&base->activequeues[i]))
			continue;
		fprintf(output, "Active events [priority %d]:\n", i);
		TAILQ_FOREACH(e, &base->eventqueue, ev_next) {
			fprintf(output, "  %p [fd %ld]%s%s%s%s\n",
					(void*)e, (long)e->ev_fd,
					(e->ev_res&EV_READ)?" Read active":"",
					(e->ev_res&EV_WRITE)?" Write active":"",
					(e->ev_res&EV_SIGNAL)?" Signal active":"",
					(e->ev_res&EV_TIMEOUT)?" Timeout active":"");
		}
	}
}
