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
d_dirnamlen='undef'
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
i_time='define'
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
sed='/bin/sed'
spitshell='cat'

#Compiler/Preprocessor
add_log='undef'
binary_format=''
cc='gcc'
ccflags='-pipe -fPIC'
cpp='g++'
cppflags='-pipe -fPIC'
cpp_stuff='42'
defvoidused='15'
#Check value for next 4
eif_sgi='undef'
eif_solaris='undef'
eif_windows='undef'
eif_64_bits='define'
Mcc='Mcc'
d_tls='undef'
#Check value for next 2
mtccflags="$ccflags -DEIF_THREADS -DEIF_LINUXTHREADS"
mtcppflags="$cppflags -DEIF_THREADS -DEIF_LINUXTHREADS"
optimize="-O3 $binary_format $platform_arch"
platform_arch=''
voidflags='15'
#Check value for next 1
warning_level='-Wall -pedantic -std=gnu99'
wkoptimize="-O0 $binary_format $platform_arch"

#Makefiles
ar='ar'
command_makefile='make -f'
concurrent_prefix='c'
cp='/bin/cp'
eiflib='finalized'
ld='ld'
ldflags=" $binary_format $platform_arch"
ldsharedflags="$ldflags -shared -o"
libs='-lm'
ln='/bin/ln'
make='make'
mkdep='/home/manus/local/56dev/C/mkdep'
mkdir='mkdir'
mtldflags="$ldflags"
mtldsharedflags="$ldsharedflags"
mtlibs="$libs -lpthread"
mt_prefix='mt'
mv='/bin/mv'
prefix='lib'
ranlib=':'
shared_prefix='lib'
shared_suffix='.so'
shared_rt_suffix='.so'
sharedlibs='-lm'
sharedlibversion='.5.6'
sharedlink='ld'
suffix='.a'
wkeiflib='wkbench'

#testing
start_test='if [ ! -f finished ] ; then'
end_test='; fi'
create_test='touch finished'

CONFIG=true
