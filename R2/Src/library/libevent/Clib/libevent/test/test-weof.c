/*
 * Compile with:
 * cc -I/usr/local/include -o time-test time-test.c -L/usr/local/lib -levent
 */
#include "event-config.h"

#ifdef WIN32
#include <winsock2.h>
#else
#include <unistd.h>
#endif
#include <sys/types.h>
#include <sys/stat.h>
#ifdef _EVENT_HAVE_SYS_TIME_H
#include <sys/time.h>
#endif
#ifdef _EVENT_HAVE_SYS_SOCKET_H
#include <sys/socket.h>
#endif
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <errno.h>

#include <event2/event.h>
#include <event2/event_struct.h>
#include <event2/event_compat.h>
#include <event2/util.h>

#ifdef _EVENT___func__
#define __func__ _EVENT___func__
#endif

int pair[2];
int test_okay = 1;
int called = 0;

static void
write_cb(int fd, short event, void *arg)
{
	const char *test = "test string";
	int len;

	len = send(fd, test, strlen(test) + 1, 0);

	printf("%s: write %d%s\n", __func__,
	    len, len ? "" : " - means EOF");

	if (len > 0) {
		if (!called)
			event_add(arg, NULL);
		EVUTIL_CLOSESOCKET(pair[0]);
	} else if (called == 1)
		test_okay = 0;

	called++;
}

int
main (int argc, char **argv)
{
	struct event ev;

#ifndef WIN32
	if (signal(SIGPIPE, SIG_IGN) == SIG_ERR)
		return (1);
#endif

	if (evutil_socketpair(AF_UNIX, SOCK_STREAM, 0, pair) == -1)
		return (1);

	/* Initalize the event library */
	event_init();

	/* Initalize one event */
	event_set(&ev, pair[1], EV_WRITE, write_cb, &ev);

	event_add(&ev, NULL);

	event_dispatch();

	return (test_okay);
}

