/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
	Thread management routines.
*/

#ifndef _eif_threads_h_
#define _eif_threads_h_

#ifdef EIF_THREADS

#include "eif_cecil.h"		/* Needed for inclusion of predefined macros */

/*------------------------------------*/
/*----- Platform specific tuning -----*/
/*------------------------------------*/

#ifdef EIF_FSUTHREADS		/* Tuning for FSU POSIX Threads */
#define HASNT_SCHED_H
#define EIF_POSIX_THREADS
#define EIF_NONPOSIX_TSD
#define HASNT_SCHEDPARAM
#endif

#ifdef EIF_LINUXTHREADS		/* Tuning for POSIX LinuxThreads */
#define EIF_POSIX_THREADS
#ifndef EIF_DFL_SIGUSR
#define EIF_DFLT_SIGUSR
#endif
#endif

#ifdef EIF_PCTHREADS		/* Tuning for POSIX PCThreads */
#define HASNT_SCHED_H
#ifdef SIGVTARLARM
#define EIF_DFLT_SIGVTALARM
#endif
#define EIF_POSIX_THREADS
#define EIF_NONPOSIX_TSD
#endif

#ifdef __Lynx__				/* Tuning for LynxOS */
#define EIF_POSIX_THREADS
#define POSIX_10034A
#endif

#ifdef _CRAY				/* Tuning for Cray */
#define EIF_NO_SEM
#define EIF_NO_POSIX_SEM
#define HASNT_SCHED_H
#define HASNT_SCHEDPARAM
#endif

#ifdef SOLARIS_THREADS		/* Tuning for Solaris Threads */
#define HAS_SEMA
#define HAS_RWL
#endif

#ifdef VXWORKS				/* Tuning for VxWorks */
#define EIF_NO_CONDVAR
#define EIF_NO_POSIX_SEM 	/* This can change if VxWorks compiled with option POSIX_SEM */
#endif

#ifdef EIF_WIN32			/* Tuning for Windows */
#define EIF_NO_POSIX_SEM
#endif

#ifdef UNIXWARE_THREADS		/* Tuning for Unixware threads */
#ifndef EIF_DFLT_SIGWAITING
#define EIF_DFLT_SIGWAITING
#endif
#define SOLARIS_THREADS
#define NEED_SYNCH_H
#define HASNT_SCHED_H
#define HASNT_SEMAPHORE_H
#define HAS_SEMA
#endif

/*---------------------------*/
/*---- Header inclusion -----*/
/*---------------------------*/


#ifdef _CRAY
#include <unistd.h>		/* Avoid warning on C90 when also including <sched.h> */
#endif

#if defined(EIF_POSIX_THREADS) || defined(SOLARIS_THREADS)
#ifdef EIF_POSIX_THREADS
#include <pthread.h>
#else
#include <thread.h>
#endif
#ifndef HASNT_SCHED_H
#include <sched.h>
#endif
#ifdef NEED_SYNCH_H
#include <synch.h>
#endif

#elif defined EIF_WIN32
#include <windows.h>
#include <process.h>
#include "eif_cond_var.h"

#elif defined VXWORKS
#include <taskLib.h>        /* 'thread' operations */
#include <taskVarLib.h>     /* 'thread' 'specific data' */
#include <semLib.h>         /* 'mutexes' and semaphores */
#include <sched.h>          /* 'sched_yield' */

#endif

#ifndef EIF_NO_POSIX_SEM	/* Defaults for semaphore */
#ifndef HASNT_SEMAPHORE_H
#include <semaphore.h>
#endif
#endif

#ifdef __cplusplus
extern "C" {
#endif

/*------------------------------*/
/*-----  Type definitions  -----*/
/*------------------------------*/

#ifdef EIF_POSIX_THREADS
#define EIF_THR_ENTRY_TYPE      void *
#define EIF_THR_ENTRY_ARG_TYPE  void *
#define EIF_THR_ATTR_TYPE       pthread_attr_t
#define EIF_TSD_VAL_TYPE        void *
#define EIF_THR_TYPE            pthread_t
#define EIF_MUTEX_TYPE          pthread_mutex_t
#define EIF_TSD_TYPE            pthread_key_t

#elif defined(EIF_WIN32)
#define EIF_THR_ENTRY_TYPE      void
#define EIF_THR_ENTRY_ARG_TYPE  void *
#define EIF_THR_ATTR_TYPE       unsigned char
#define EIF_TSD_VAL_TYPE        LPVOID
#define EIF_SEM_TYPE            HANDLE
#define EIF_THR_TYPE            unsigned long
#define EIF_MUTEX_TYPE          HANDLE
#define EIF_TSD_TYPE            DWORD

#elif defined SOLARIS_THREADS
rt_public typedef struct {
  int prio;
  int pol;
} eif_thr_attr_t;

#define EIF_THR_ENTRY_TYPE      void
#define EIF_THR_ENTRY_ARG_TYPE  void *
#define EIF_THR_ATTR_TYPE       eif_thr_attr_t
#define EIF_TSD_VAL_TYPE        void *
#define EIF_THR_TYPE            thread_t
#define EIF_MUTEX_TYPE          mutex_t
#define EIF_TSD_TYPE            thread_key_t
#ifndef EIF_NO_CONDVAR
#define pthread_cond_t			cond_t
#endif

#elif defined VXWORKS
#define EIF_THR_ENTRY_TYPE      void
#define EIF_THR_ENTRY_ARG_TYPE  int
#define EIF_THR_ATTR_TYPE       int
#define EIF_THR_TYPE            int
#define EIF_THR_ATTR_TYPE       int
#define EIF_TSD_TYPE            eif_global_context_t *

/* For consistency with the other platforms, EIF_MUTEX_TYPE shouldn't
   be a pointer, that's why we use struct semaphore instead of SEM_ID
   because SEM_ID is equivalent to (struct semaphore *)
   */
#define EIF_MUTEX_TYPE			struct semaphore
#define EIF_TSD_VAL_TYPE        eif_global_context_t * 

#ifdef EIF_NO_POSIX_SEM
#define EIF_SEM_TYPE            struct semaphore
#endif

#endif

#ifdef EIF_NO_CONDVAR
#define EIF_COND_TYPE		unsigned char
#define EIF_COND_ATTR_TYPE  unsigned char
#else
#define EIF_COND_TYPE		pthread_cond_t
#define EIF_COND_ATTR_TYPE	pthread_condattr_t
#endif

#ifndef EIF_NO_POSIX_SEM
#define EIF_SEM_TYPE    sem_t
#endif

/*------------------------------*/
/*---- Feature definitions -----*/
/*------------------------------*/

RT_LNK void eif_thr_panic(char *);

#ifndef EIF_WINDOWS
/* Forking, only support on Unix platform on which `fork' is supported. */
RT_LNK pid_t eif_thread_fork(void);
#endif


/* Exported functions */
RT_LNK void eif_thr_init_root(void);
RT_LNK void eif_thr_register(void);
RT_LNK unsigned int eif_thr_is_initialized(void);
RT_LNK EIF_BOOLEAN eif_thr_is_root(void);
RT_LNK void eif_thr_create(EIF_OBJECT, EIF_POINTER);
RT_LNK void eif_thr_exit(void);
RT_LNK void eif_thr_sleep(EIF_INTEGER_64);
RT_LNK void eif_thr_yield(void);
RT_LNK void eif_thr_join_all(void);
RT_LNK void eif_thr_join(EIF_POINTER);
RT_LNK void eif_thr_wait(EIF_OBJECT);
RT_LNK void eif_thr_create_with_args(EIF_OBJECT, EIF_POINTER, EIF_INTEGER, EIF_INTEGER, EIF_BOOLEAN);
RT_LNK EIF_INTEGER eif_thr_default_priority(void);
RT_LNK EIF_INTEGER eif_thr_min_priority(void);
RT_LNK EIF_INTEGER eif_thr_max_priority(void);
RT_LNK EIF_POINTER eif_thr_thread_id(void);
RT_LNK EIF_POINTER eif_thr_last_thread(void);

/* Constants common to all platforms */

#define EIF_SCHED_DEFAULT 0
#define EIF_SCHED_OTHER   1
#define EIF_SCHED_FIFO    2  /* FIFO scheduling        */
#define EIF_SCHED_RR      3  /* Round-robin scheduling */


/*--------------------------*/
/*---  Mutex operations  ---*/
/*--------------------------*/

RT_LNK EIF_POINTER eif_thr_mutex_create(void);
RT_LNK void eif_thr_mutex_lock(EIF_POINTER mutex_pointer);
RT_LNK void eif_thr_mutex_unlock(EIF_POINTER mutex_pointer);
RT_LNK EIF_BOOLEAN eif_thr_mutex_trylock(EIF_POINTER mutex_pointer);
RT_LNK void eif_thr_mutex_destroy(EIF_POINTER mutex_pointer);

/*------------------------------*/
/*---  Semaphore operations  ---*/
/*------------------------------*/

RT_LNK EIF_POINTER eif_thr_sem_create (EIF_INTEGER count);
RT_LNK void eif_thr_sem_wait (EIF_POINTER sem);
RT_LNK void eif_thr_sem_post (EIF_POINTER sem);
RT_LNK EIF_BOOLEAN eif_thr_sem_trywait (EIF_POINTER sem);
RT_LNK void eif_thr_sem_destroy (EIF_POINTER sem);

/*---------------------------------------*/
/*---  Condition variable operations  ---*/
/*---------------------------------------*/

RT_LNK EIF_POINTER eif_thr_cond_create (void);
RT_LNK void eif_thr_cond_broadcast (EIF_POINTER cond);
RT_LNK void eif_thr_cond_signal (EIF_POINTER cond);
RT_LNK void eif_thr_cond_wait (EIF_POINTER cond, EIF_POINTER mutex);
RT_LNK EIF_INTEGER eif_thr_cond_wait_with_timeout (EIF_POINTER cond, EIF_POINTER mutex, EIF_INTEGER a_timeout);
RT_LNK void eif_thr_cond_destroy (EIF_POINTER cond);

/*------------------------------------*/
/*---  Read/Write lock operations  ---*/
/*------------------------------------*/

RT_LNK EIF_POINTER eif_thr_rwl_create (void);
RT_LNK void eif_thr_rwl_rdlock (EIF_POINTER rwlp);
RT_LNK void eif_thr_rwl_wrlock (EIF_POINTER rwlp);
RT_LNK void eif_thr_rwl_unlock (EIF_POINTER rwlp);
RT_LNK void eif_thr_rwl_destroy (EIF_POINTER rwlp);

/*------------------------*/
/*---  Memory barriers ---*/
/*------------------------*/

#if defined(_WIN32) && defined(_MSC_VER)
#	if (_MSC_VER >= 1400)
		void _ReadBarrier(void);
		void _ReadWriteBarrier();
		void _WriteBarrier(void);
#		pragma intrinsic(_ReadBarrier)
#		pragma intrinsic(_ReadWriteBarrier)
#		pragma intrinsic(_WriteBarrier)
#		define EIF_MEMORY_READ_BARRIER _ReadBarrier
#		define EIF_MEMORY_BARRIER _ReadWriteBarrier
#		define EIF_MEMORY_WRITE_BARRIER _WriteBarrier
#	elif (_MSC_VER >= 1300)
		void _ReadWriteBarrier();
#		pragma intrinsic(_ReadWriteBarrier)
#		define EIF_MEMORY_BARRIER _ReadWriteBarrier
#	elif defined(MemoryBarrier)
#		define EIF_MEMORY_BARRIER MemoryBarrier
#	endif
#endif

#ifdef EIF_MEMORY_BARRIER
#	define EIF_HAS_MEMORY_BARRIER
#endif

#ifdef EIF_HAS_MEMORY_BARRIER
#	ifndef EIF_MEMORY_READ_BARRIER
#		define EIF_MEMORY_READ_BARRIER EIF_MEMORY_BARRIER
#	endif // EIF_MEMORY_READ_BARRIER
#	ifndef EIF_MEMORY_WRITE_BARRIER
#		define EIF_MEMORY_WRITE_BARRIER EIF_MEMORY_BARRIER
#	endif // EIF_MEMORY_WRITE_BARRIER
#endif

#ifdef __cplusplus
}
#endif

#endif /* EIF_THREADS */


#ifdef __cplusplus
extern "C" {
#endif

#define MTOG(result_type,item,result)	(result = result_type item)
#define MTOS(item,val)					item = (EIF_REFERENCE ) val

#ifdef __cplusplus
}
#endif

#endif	/* _eif_threads_h_ */
