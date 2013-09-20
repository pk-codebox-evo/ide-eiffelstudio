#!/bin/sh
#--|----------------------------------------------------------------
#--| Eiffel runtime configuration
#--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
#--| Duplication and distribution prohibited.  May be used only with
#--| ISE Eiffel, under terms of user license.
#--| Contact Eiffel Software for any other use.
#--|
#--| Interactive Software Engineering Inc.
#--| dba Eiffel Software
#--| 356 Storke Road, Goleta, CA 93117 USA
#--| Telephone 805-685-1006, Fax 805-685-6869
#--| Contact us at: http://www.eiffel.com/general/email.html
#--| Customer support: http://support.eiffel.com
#--| For latest info on our award winning products, visit:
#--|     http://www.eiffel.com
#--|----------------------------------------------------------------

#Computation/sizes
byteorder='1234'
pagesize='4096'
alignbytes='8'
doublesize='8'
intsize='4'
integer_64_size='8'
floatsize='4'
ptrsize='8'
longsize='8'
integer_32_size='4'
integer_16_size='2'
charsize='1'
bitpbyte='8'
lngpad_2='LNGPAD(2)'

#Formatting
#Check value for next 4
inttypes_include=''
eif_integer_64_display='"lld"'
eif_natural_64_display='"llu"'
eif_pointer_display='"lX"'
eif_integer_64_constant='CAT2(x,LL)'
eif_natural_64_constant='CAT2(x,ULL)'
d_uint64_to_real='define'

#File system
nofile='1024'
groupstype='gid_t'
uidtype='uid_t'
d_chown='define'
d_dup2='define'
d_dirnamlen='define'
#Check value for next 1 on 64 bits platform.
d_eofpipe='define'
d_fcntl='define'
d_geteuid='define'
d_getgrgid='define'
d_getgrps='define'
d_getpwuid='define'
d_link='define'
d_lstat='define'
d_mkdir='define'
d_readdir='define'
d_rewinddir='define'
d_rename='define'
d_rmdir='define'
d_unlink='define'
i_dirent='define'
i_fcntl='undef'
i_grp='define'
i_limits='define'
i_pwd='define'
i_sysdir='define'
i_sysfile='define'
i_sysndir='undef'

#Network
selecttype='fd_set *'
d_keepalive='undef'
i_fd_setsyss='undef'
i_niin='define'
i_sysin='undef'
i_syssock='define'
i_sysun='define'

#Time
timetype='time_t'
d_ftime='undef'
d_gettimeod='define'
d_rusage='define'
d_time='define'
d_times='define'
d_utime='define'
i_sysresrc='define'
i_systimeb='define'
i_systimes='define'
i_time='undef'
i_systime='define'
i_systimek='undef'
i_utime='define'
#Check value for next 1
i_sysutime='undef'
i_tmvlsyss='undef'

#Signals
abortsig='SIGABRT'
signal_t='void'
d_bsdjmp='define'
#Check value for next 1
d_bsdsig='undef'
d_keepsig='define'
d_sigaction='define'
d_sigaltstack='define'
d_siglist='define'
d_sigsetmk='define'
d_sigvec='define'
d_sigvectr='undef'

#System
malloctype='void *'
pidtype='pid_t'
prototype='define'
d_gethid='define'
d_maypanic='undef'
d_nanosleep='define'
d_pidcheck='define'
d_sbrk='define'
d_sbrksmart='undef'
d_smartmmap='undef'
d_strerror='define'
d_syserrlst='define'
d_sysernlst='undef'
d_strerrm='strerror(e)'
d_usleep='define'
i_stdarg='define'
i_varargs='undef'

#Shell
eunicefix=':'
rm='/bin/rm'
sed='/usr/bin/sed'
spitshell='cat'

#Compiler/Preprocessor
if [ -n "$ISE_VERSION" ]; then
	rt_version=$ISE_VERSION
else
	rt_version=''
fi
if [ -n "$ISE_EIFFEL" ]; then
	rt_include=$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/include
	rt_lib=$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/lib
	rt_templates=$ISE_EIFFEL/studio/config/$ISE_PLATFORM/templates
	x2c=$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin/x2c
else
	rt_include=$ISE_PREFIX/include/eiffelstudio-$rt_version
	rt_lib=$ISE_PREFIX/$ISE_LIB_NAME/eiffelstudio-$rt_version
	rt_templates=$ISE_PREFIX/share/eiffelstudio-$rt_version/studio/config/$ISE_PLATFORM/templates
	x2c=$ISE_PREFIX/$ISE_LIB_NAME/eiffelstudio-$rt_version/studio/x2c
fi
add_log='undef'
if [ -n "$CC" ]; then
	cc=$CC
else
	cc='gcc'
fi
if [ -n "$CFLAGS" ]; then
	ccflags=$CFLAGS
else
	ccflags='-arch x86_64 -pipe -no-cpp-precomp -fno-common -fPIC'
fi
ccldflags='-arch x86_64'
if [ -n "$CPP" ]; then
	cpp=$CPP
else
	cpp='g++'
fi
if [ -n "$CPPFLAGS" ]; then
	cppflags=$CPPFLAGS
else
	cppflags="$ccflags"
fi
cpp_stuff='42'
defvoidused='15'
#Check value for next 4
eif_sgi='undef'
eif_solaris='undef'
eif_windows='undef'
eif_64_bits='define'
eif_os='EIF_OS_DARWIN'
eif_arch='EIF_ARCH_X86_64'
Mcc='Mcc'
d_tls='undef'
#Check value for next 2
mtccflags="$ccflags -DEIF_THREADS -DEIF_POSIX_THREADS"
mtcppflags="$cppflags -DEIF_THREADS -DEIF_POSIX_THREADS"
optimize="-O3"
voidflags='15'
#Check value for next 1
warning_level='-Wall'
wkoptimize="-O0"

#Makefiles
ar='ar'
boehmgclib='gc'
command_makefile='make -f'
concurrent_prefix='c'
cp='/bin/cp'
eiflib='finalized'
ld='ld'
ldflags='-arch x86_64'
ldsharedflags="$ldflags -dynamiclib -flat_namespace -undefined suppress -o"
libs='-lm'
ln='/bin/ln'
if [ -n "$MAKE" ]; then
	make=$MAKE
else
	make='make'
fi
mkdep='\$(EIFFEL_SRC)/C/mkdep'
mkdir='mkdir'
mtldflags="$ldflags"
mtldsharedflags="$ldsharedflags"
mtlibs="$libs -lpthread"
mt_prefix='mt'
mv='/bin/mv'
prefix='lib'
ranlib='ar ts'
shared_prefix='lib'
shared_suffix='.dylib'
shared_rt_suffix='.dylib'
sharedlibs='-lm -lpthread'
sharedlibversion='.5.6'
sharedlink='gcc'
suffix='.a'
wkeiflib='wkbench'

#testing
start_test='if [ ! -f finished ] ; then'
end_test='; fi'
create_test='touch finished'

CONFIG=true
