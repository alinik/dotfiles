/* config.h.  Generated from config.h.in by configure.  */
/* config.h.in.  Generated from configure.ac by autoheader.  */

/***** begin user configuration section *****/

/* Define this to be the location of your password file */
#define PASSWD_FILE "/etc/passwd"

/* Define this to be the name of your NIS/YP password *
 * map (if applicable)                                */
#define PASSWD_MAP "passwd.byname"

/* Define to 1 if you want user names to be cached */
#define CACHE_USERNAMES 1

/* Define to 1 if system supports job control */
#define JOB_CONTROL 1

/* Define this if you use "suspended" instead of "stopped" */
#define USE_SUSPENDED 1
 
/* The default history buffer size in lines */
#define DEFAULT_HISTSIZE 30

/* The default editor for the fc builtin */
#define DEFAULT_FCEDIT "vi"

/* The default prefix for temporary files */
#define DEFAULT_TMPPREFIX "/tmp/zsh"

/***** end of user configuration section            *****/
/***** shouldn't have to change anything below here *****/



/* Define to 1 if you want to use dynamically loaded modules on AIX. */
/* #undef AIXDYNAMIC */

/* Define to 1 if the isprint() function is broken under UTF-8 locale. */
#define BROKEN_ISPRINT 1

/* Define to 1 if kill(pid, 0) doesn't return ESRCH, ie BeOS R4.51. */
#define BROKEN_KILL_ESRCH 1

/* Define to 1 if sigsuspend() is broken */
#define BROKEN_POSIX_SIGSUSPEND 1

/* Define to 1 if compiler incorrectly cast signed to unsigned. */
/* #undef BROKEN_SIGNED_TO_UNSIGNED_CASTING */

/* Define to 1 if tcsetpgrp() doesn't work, ie BeOS R4.51. */
#define BROKEN_TCSETPGRP 1

/* Define to 1 if you use BSD style signal handling (and can block signals).
   */
/* #undef BSD_SIGNALS */

/* Undefine if you don't want local features. By default this is defined. */
#define CONFIG_LOCALE 1

/* Define to one of `_getb67', `GETB67', `getb67' for Cray-2 and Cray-YMP
   systems. This function is required for `alloca.c' support on those systems.
   */
/* #undef CRAY_STACKSEG_END */

/* Define to a custom value for the ZSH_PATCHLEVEL parameter */
/* #undef CUSTOM_PATCHLEVEL */

/* Define to 1 if using `alloca.c'. */
/* #undef C_ALLOCA */

/* Define to 1 if you want to debug zsh. */
/* #undef DEBUG */

/* The default path; used when running commands with command -p */
#define DEFAULT_PATH "/usr/bin:/bin:/usr/sbin:/sbin"

/* Define default pager used by readnullcmd */
#define DEFAULT_READNULLCMD "more"

/* Define to 1 if you want to avoid calling functions that will require
   dynamic NSS modules. */
/* #undef DISABLE_DYNAMIC_NSS */

/* Define to 1 if an underscore has to be prepended to dlsym() argument. */
/* #undef DLSYM_NEEDS_UNDERSCORE */

/* The extension used for dynamically loaded modules. */
#define DL_EXT "bundle"

/* Define to 1 if you want to use dynamically loaded modules. */
/* #undef DYNAMIC */

/* Define to 1 if multiple modules defining the same symbol are OK. */
/* #undef DYNAMIC_NAME_CLASH_OK */

/* Define to 1 if you want use unicode9 character widths. */
/* #undef ENABLE_UNICODE9 */

/* Define to 1 if getcwd() calls malloc to allocate memory. */
#define GETCWD_CALLS_MALLOC 1

/* Define to 1 if the `getpgrp' function requires zero arguments. */
#define GETPGRP_VOID 1

/* Define to 1 if getpwnam() is faked, ie BeOS R4.51. */
#define GETPWNAM_FAKED 1

/* The global file to source whenever zsh is run as a login shell; if
   undefined, don't source anything */
#define GLOBAL_ZLOGIN "/etc/zlogin"

/* The global file to source whenever zsh was run as a login shell. This is
   sourced right before exiting. If undefined, don't source anything. */
#define GLOBAL_ZLOGOUT "/etc/zlogout"

/* The global file to source whenever zsh is run as a login shell, before
   zshrc is read; if undefined, don't source anything. */
#define GLOBAL_ZPROFILE "/etc/zprofile"

/* The global file to source absolutely first whenever zsh is run; if
   undefined, don't source anything. */
#define GLOBAL_ZSHENV "/etc/zshenv"

/* The global file to source whenever zsh is run; if undefined, don't source
   anything */
#define GLOBAL_ZSHRC "/etc/zshrc"

/* Define if TIOCGWINSZ is defined in sys/ioctl.h but not in termios.h. */
/* #undef GWINSZ_IN_SYS_IOCTL */

/* Define to 1 if you have `alloca', as a function or macro. */
#define HAVE_ALLOCA 1

/* Define to 1 if you have <alloca.h> and it should be used (not on Ultrix).
   */
#define HAVE_ALLOCA_H 1

/* Define to 1 if you have the <bind/netdb.h> header file. */
/* #undef HAVE_BIND_NETDB_H */

/* Define if you have the termcap boolcodes symbol. */
#define HAVE_BOOLCODES 1

/* Define if you have the terminfo boolnames symbol. */
#define HAVE_BOOLNAMES 1

/* Define to 1 if you have the `brk' function. */
#define HAVE_BRK 1

/* Define to 1 if there is a prototype defined for brk() on your system. */
#define HAVE_BRK_PROTO 1

/* Define to 1 if you have the `canonicalize_file_name' function. */
/* #undef HAVE_CANONICALIZE_FILE_NAME */

/* Define to 1 if you have the `cap_get_proc' function. */
/* #undef HAVE_CAP_GET_PROC */

/* Define to 1 if you have the `clock_gettime' function. */
#define HAVE_CLOCK_GETTIME 1

/* Define to 1 if you have the <curses.h> header file. */
#define HAVE_CURSES_H 1

/* Define to 1 if you have the `cygwin_conv_path' function. */
/* #undef HAVE_CYGWIN_CONV_PATH */

/* Define to 1 if you have the `difftime' function. */
#define HAVE_DIFFTIME 1

/* Define to 1 if you have the <dirent.h> header file, and it defines `DIR'.
   */
#define HAVE_DIRENT_H 1

/* Define to 1 if you have the `dlclose' function. */
#define HAVE_DLCLOSE 1

/* Define to 1 if you have the `dlerror' function. */
#define HAVE_DLERROR 1

/* Define to 1 if you have the <dlfcn.h> header file. */
#define HAVE_DLFCN_H 1

/* Define to 1 if you have the `dlopen' function. */
#define HAVE_DLOPEN 1

/* Define to 1 if you have the `dlsym' function. */
#define HAVE_DLSYM 1

/* Define to 1 if you have the <dl.h> header file. */
/* #undef HAVE_DL_H */

/* Define to 1 if you have the `endutxent' function. */
#define HAVE_ENDUTXENT 1

/* Define to 1 if you have the `erand48' function. */
#define HAVE_ERAND48 1

/* Define to 1 if you have the <errno.h> header file. */
#define HAVE_ERRNO_H 1

/* Define to 1 if you have the `faccessx' function. */
/* #undef HAVE_FACCESSX */

/* Define to 1 if you have the `fchdir' function. */
#define HAVE_FCHDIR 1

/* Define to 1 if you have the `fchmod' function. */
#define HAVE_FCHMOD 1

/* Define to 1 if you have the `fchown' function. */
#define HAVE_FCHOWN 1

/* Define to 1 if you have the <fcntl.h> header file. */
#define HAVE_FCNTL_H 1

/* Define to 1 if system has working FIFOs. */
/* #undef HAVE_FIFOS */

/* Define to 1 if you have the `fseeko' function. */
#define HAVE_FSEEKO 1

/* Define to 1 if you have the `fstat' function. */
#define HAVE_FSTAT 1

/* Define to 1 if you have the `ftello' function. */
#define HAVE_FTELLO 1

/* Define to 1 if you have the `ftruncate' function. */
#define HAVE_FTRUNCATE 1

/* Define to 1 if you have the <gdbm.h> header file. */
/* #undef HAVE_GDBM_H */

/* Define to 1 if you have the `gdbm_open' function. */
/* #undef HAVE_GDBM_OPEN */

/* Define to 1 if you have the `getcchar' function. */
#define HAVE_GETCCHAR 1

/* Define to 1 if you have the `getcwd' function. */
#define HAVE_GETCWD 1

/* Define to 1 if you have the `getenv' function. */
#define HAVE_GETENV 1

/* Define to 1 if you have the `getgrgid' function. */
#define HAVE_GETGRGID 1

/* Define to 1 if you have the `getgrnam' function. */
#define HAVE_GETGRNAM 1

/* Define to 1 if you have the `gethostbyname2' function. */
#define HAVE_GETHOSTBYNAME2 1

/* Define to 1 if you have the `gethostname' function. */
#define HAVE_GETHOSTNAME 1

/* Define to 1 if you have the `getipnodebyname' function. */
#define HAVE_GETIPNODEBYNAME 1

/* Define to 1 if you have the `getline' function. */
#define HAVE_GETLINE 1

/* Define to 1 if you have the `getlogin' function. */
#define HAVE_GETLOGIN 1

/* Define to 1 if you have the `getpagesize' function. */
#define HAVE_GETPAGESIZE 1

/* Define to 1 if you have the `getpwent' function. */
#define HAVE_GETPWENT 1

/* Define to 1 if you have the `getpwnam' function. */
#define HAVE_GETPWNAM 1

/* Define to 1 if you have the `getpwuid' function. */
#define HAVE_GETPWUID 1

/* Define to 1 if you have the `getrlimit' function. */
#define HAVE_GETRLIMIT 1

/* Define to 1 if you have the `getrusage' function. */
#define HAVE_GETRUSAGE 1

/* Define to 1 if you have the `gettimeofday' function. */
#define HAVE_GETTIMEOFDAY 1

/* Define to 1 if you have the `getutent' function. */
/* #undef HAVE_GETUTENT */

/* Define to 1 if you have the `getutxent' function. */
#define HAVE_GETUTXENT 1

/* Define to 1 if you have the `getxattr' function. */
#define HAVE_GETXATTR 1

/* Define to 1 if you have the `grantpt' function. */
#define HAVE_GRANTPT 1

/* Define to 1 if you have the <grp.h> header file. */
#define HAVE_GRP_H 1

/* Define to 1 if you have the `htons' function. */
#define HAVE_HTONS 1

/* Define to 1 if you have the `iconv' function. */
#define HAVE_ICONV 1

/* Define to 1 if you have the <iconv.h> header file. */
#define HAVE_ICONV_H 1

/* Define to 1 if you have the `inet_aton' function. */
#define HAVE_INET_ATON 1

/* Define to 1 if you have the `inet_ntop' function. */
#define HAVE_INET_NTOP 1

/* Define to 1 if you have the `inet_pton' function. */
#define HAVE_INET_PTON 1

/* Define to 1 if you have the `initgroups' function. */
#define HAVE_INITGROUPS 1

/* Define to 1 if you have the `initscr' function. */
#define HAVE_INITSCR 1

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define to 1 if there is a prototype defined for ioctl() on your system. */
#define HAVE_IOCTL_PROTO 1

/* Define to 1 if you have the `isblank' function. */
#define HAVE_ISBLANK 1

/* Define to 1 if you have the `isinf' function. */
#define HAVE_ISINF 1

/* Define to 1 if you have the `isnan' function. */
#define HAVE_ISNAN 1

/* Define to 1 if you have the `iswblank' function. */
#define HAVE_ISWBLANK 1

/* Define to 1 if you have the `killpg' function. */
#define HAVE_KILLPG 1

/* Define to 1 if you have the <langinfo.h> header file. */
#define HAVE_LANGINFO_H 1

/* Define to 1 if you have the `lchown' function. */
#define HAVE_LCHOWN 1

/* Define to 1 if you have the `cap' library (-lcap). */
/* #undef HAVE_LIBCAP */

/* Define to 1 if you have the <libc.h> header file. */
#define HAVE_LIBC_H 1

/* Define to 1 if you have the `dl' library (-ldl). */
#define HAVE_LIBDL 1

/* Define to 1 if you have the `gdbm' library (-lgdbm). */
/* #undef HAVE_LIBGDBM */

/* Define to 1 if you have the `m' library (-lm). */
#define HAVE_LIBM 1

/* Define to 1 if you have the `rt' library (-lrt). */
/* #undef HAVE_LIBRT */

/* Define to 1 if you have the `socket' library (-lsocket). */
/* #undef HAVE_LIBSOCKET */

/* Define to 1 if you have the <limits.h> header file. */
#define HAVE_LIMITS_H 1

/* Define to 1 if system has working link(). */
/* #undef HAVE_LINK */

/* Define to 1 if you have the `load' function. */
/* #undef HAVE_LOAD */

/* Define to 1 if you have the `loadbind' function. */
/* #undef HAVE_LOADBIND */

/* Define to 1 if you have the `loadquery' function. */
/* #undef HAVE_LOADQUERY */

/* Define to 1 if you have the <locale.h> header file. */
#define HAVE_LOCALE_H 1

/* Define to 1 if you have the `log2' function. */
#define HAVE_LOG2 1

/* Define to 1 if you have the `lstat' function. */
#define HAVE_LSTAT 1

/* Define to 1 if you have the `memcpy' function. */
#define HAVE_MEMCPY 1

/* Define to 1 if you have the `memmove' function. */
#define HAVE_MEMMOVE 1

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* Define to 1 if you have the `mkfifo' function. */
#define HAVE_MKFIFO 1

/* Define to 1 if there is a prototype defined for mknod() on your system. */
#define HAVE_MKNOD_PROTO 1

/* Define to 1 if you have the `mkstemp' function. */
#define HAVE_MKSTEMP 1

/* Define to 1 if you have the `mktime' function. */
#define HAVE_MKTIME 1

/* Define to 1 if you have a working `mmap' system call. */
#define HAVE_MMAP 1

/* Define to 1 if you have the `msync' function. */
#define HAVE_MSYNC 1

/* Define to 1 if you have the `munmap' function. */
#define HAVE_MUNMAP 1

/* Define to 1 if you have the `nanosleep' function. */
#define HAVE_NANOSLEEP 1

/* Define to 1 if you have the <ncursesw/ncurses.h> header file. */
/* #undef HAVE_NCURSESW_NCURSES_H */

/* Define to 1 if you have the <ncursesw/term.h> header file. */
/* #undef HAVE_NCURSESW_TERM_H */

/* Define to 1 if you have the <ncurses.h> header file. */
#define HAVE_NCURSES_H 1

/* Define to 1 if you have the <ncurses/ncurses.h> header file. */
/* #undef HAVE_NCURSES_NCURSES_H */

/* Define to 1 if you have the <ncurses/term.h> header file. */
/* #undef HAVE_NCURSES_TERM_H */

/* Define to 1 if you have the <ndir.h> header file, and it defines `DIR'. */
/* #undef HAVE_NDIR_H */

/* Define to 1 if you have the <netinet/in_systm.h> header file. */
#define HAVE_NETINET_IN_SYSTM_H 1

/* Define to 1 if you have the `nice' function. */
#define HAVE_NICE 1

/* Define to 1 if you have NIS. */
/* #undef HAVE_NIS */

/* Define to 1 if you have the `nis_list' function. */
/* #undef HAVE_NIS_LIST */

/* Define to 1 if you have NISPLUS. */
/* #undef HAVE_NIS_PLUS */

/* Define to 1 if you have the `nl_langinfo' function. */
#define HAVE_NL_LANGINFO 1

/* Define to 1 if you have the `ntohs' function. */
#define HAVE_NTOHS 1

/* Define if you have the termcap numcodes symbol. */
#define HAVE_NUMCODES 1

/* Define if you have the terminfo numnames symbol. */
#define HAVE_NUMNAMES 1

/* Define to 1 if you have the `open_memstream' function. */
#define HAVE_OPEN_MEMSTREAM 1

/* Define to 1 if your termcap library has the ospeed variable */
#define HAVE_OSPEED 1

/* Define to 1 if you have the `pathconf' function. */
#define HAVE_PATHCONF 1

/* Define to 1 if you have the `poll' function. */
#define HAVE_POLL 1

/* Define to 1 if you have the <poll.h> header file. */
#define HAVE_POLL_H 1

/* Define to 1 if you have the `posix_openpt' function. */
#define HAVE_POSIX_OPENPT 1

/* Define to 1 if you have the `ptsname' function. */
#define HAVE_PTSNAME 1

/* Define to 1 if you have the `putenv' function. */
#define HAVE_PUTENV 1

/* Define to 1 if you have the <pwd.h> header file. */
#define HAVE_PWD_H 1

/* Define to 1 if you have the `readlink' function. */
#define HAVE_READLINK 1

/* Define to 1 if you have the `realpath' function. */
#define HAVE_REALPATH 1

/* Define to 1 if you have the `regcomp' function. */
#define HAVE_REGCOMP 1

/* Define to 1 if you have the `regerror' function. */
#define HAVE_REGERROR 1

/* Define to 1 if you have the `regexec' function. */
#define HAVE_REGEXEC 1

/* Define to 1 if you have the `regfree' function. */
#define HAVE_REGFREE 1

/* Define to 1 if you have the `resize_term' function. */
#define HAVE_RESIZE_TERM 1

/* Define to 1 if RLIMIT_AIO_MEM is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_AIO_MEM */

/* Define to 1 if RLIMIT_AIO_OPS is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_AIO_OPS */

/* Define to 1 if RLIMIT_AS is present (whether or not as a macro). */
#define HAVE_RLIMIT_AS 1

/* Define to 1 if RLIMIT_KQUEUES is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_KQUEUES */

/* Define to 1 if RLIMIT_LOCKS is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_LOCKS */

/* Define to 1 if RLIMIT_MEMLOCK is present (whether or not as a macro). */
#define HAVE_RLIMIT_MEMLOCK 1

/* Define to 1 if RLIMIT_MSGQUEUE is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_MSGQUEUE */

/* Define to 1 if RLIMIT_NICE is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_NICE */

/* Define to 1 if RLIMIT_NOFILE is present (whether or not as a macro). */
#define HAVE_RLIMIT_NOFILE 1

/* Define to 1 if RLIMIT_NPROC is present (whether or not as a macro). */
#define HAVE_RLIMIT_NPROC 1

/* Define to 1 if RLIMIT_NPTS is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_NPTS */

/* Define to 1 if RLIMIT_NTHR is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_NTHR */

/* Define to 1 if RLIMIT_POSIXLOCKS is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_POSIXLOCKS */

/* Define to 1 if RLIMIT_PTHREAD is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_PTHREAD */

/* Define to 1 if RLIMIT_RSS is present (whether or not as a macro). */
#define HAVE_RLIMIT_RSS 1

/* Define to 1 if RLIMIT_RTPRIO is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_RTPRIO */

/* Define to 1 if RLIMIT_SBSIZE is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_SBSIZE */

/* Define to 1 if RLIMIT_SIGPENDING is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_SIGPENDING */

/* Define to 1 if RLIMIT_SWAP is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_SWAP */

/* Define to 1 if RLIMIT_TCACHE is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_TCACHE */

/* Define to 1 if RLIMIT_VMEM is present (whether or not as a macro). */
/* #undef HAVE_RLIMIT_VMEM */

/* Define to 1 if you have the `sbrk' function. */
#define HAVE_SBRK 1

/* Define to 1 if there is a prototype defined for sbrk() on your system. */
#define HAVE_SBRK_PROTO 1

/* Define to 1 if you have the `scalbn' function. */
#define HAVE_SCALBN 1

/* Define to 1 if you have the `select' function. */
#define HAVE_SELECT 1

/* Define to 1 if you have the `setcchar' function. */
#define HAVE_SETCCHAR 1

/* Define to 1 if you have the `setenv' function. */
#define HAVE_SETENV 1

/* Define to 1 if you have the `seteuid' function. */
#define HAVE_SETEUID 1

/* Define to 1 if you have the `setlocale' function. */
#define HAVE_SETLOCALE 1

/* Define to 1 if you have the `setpgid' function. */
#define HAVE_SETPGID 1

/* Define to 1 if you have the `setpgrp' function. */
#define HAVE_SETPGRP 1

/* Define to 1 if the system supports `setproctitle' to change process name */
/* #undef HAVE_SETPROCTITLE */

/* Define to 1 if you have the `setresuid' function. */
/* #undef HAVE_SETRESUID */

/* Define to 1 if you have the `setreuid' function. */
#define HAVE_SETREUID 1

/* Define to 1 if you have the `setsid' function. */
#define HAVE_SETSID 1

/* Define to 1 if you have the `setuid' function. */
#define HAVE_SETUID 1

/* Define to 1 if you have the `setupterm' function. */
#define HAVE_SETUPTERM 1

/* Define to 1 if you have the `setutxent' function. */
#define HAVE_SETUTXENT 1

/* Define to 1 if you have the `shl_findsym' function. */
/* #undef HAVE_SHL_FINDSYM */

/* Define to 1 if you have the `shl_load' function. */
/* #undef HAVE_SHL_LOAD */

/* Define to 1 if you have the `shl_unload' function. */
/* #undef HAVE_SHL_UNLOAD */

/* Define to 1 if you have the `sigaction' function. */
#define HAVE_SIGACTION 1

/* Define to 1 if you have the `sigblock' function. */
#define HAVE_SIGBLOCK 1

/* Define to 1 if you have the `sighold' function. */
#define HAVE_SIGHOLD 1

/* Define to 1 if you have the `signgam' function. */
#define HAVE_SIGNGAM 1

/* Define to 1 if you have the `sigprocmask' function. */
#define HAVE_SIGPROCMASK 1

/* Define to 1 if you have the `sigrelse' function. */
#define HAVE_SIGRELSE 1

/* Define to 1 if you have the `sigsetmask' function. */
#define HAVE_SIGSETMASK 1

/* Define to 1 if you have the `srand_deterministic' function. */
/* #undef HAVE_SRAND_DETERMINISTIC */

/* Define to 1 if you have the <stdarg.h> header file. */
#define HAVE_STDARG_H 1

/* Define to 1 if you have the <stddef.h> header file. */
#define HAVE_STDDEF_H 1

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define to 1 if you have the <stdio.h> header file. */
#define HAVE_STDIO_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define if you have the termcap strcodes symbol. */
#define HAVE_STRCODES 1

/* Define to 1 if you have the `strcoll' function and it is properly defined.
   */
#define HAVE_STRCOLL 1

/* Define to 1 if you have the `strerror' function. */
#define HAVE_STRERROR 1

/* Define to 1 if you have the `strftime' function. */
#define HAVE_STRFTIME 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define if you have the terminfo strnames symbol. */
#define HAVE_STRNAMES 1

/* Define to 1 if you have the `strptime' function. */
#define HAVE_STRPTIME 1

/* Define to 1 if you have the `strstr' function. */
#define HAVE_STRSTR 1

/* Define to 1 if you have the `strtoul' function. */
#define HAVE_STRTOUL 1

/* Define if your system's struct direct has a member named d_ino. */
/* #undef HAVE_STRUCT_DIRECT_D_INO */

/* Define if your system's struct direct has a member named d_stat. */
/* #undef HAVE_STRUCT_DIRECT_D_STAT */

/* Define if your system's struct dirent has a member named d_ino. */
#define HAVE_STRUCT_DIRENT_D_INO 1

/* Define if your system's struct dirent has a member named d_stat. */
/* #undef HAVE_STRUCT_DIRENT_D_STAT */

/* Define to 1 if `ru_idrss' is a member of `struct rusage'. */
#define HAVE_STRUCT_RUSAGE_RU_IDRSS 1

/* Define to 1 if `ru_inblock' is a member of `struct rusage'. */
#define HAVE_STRUCT_RUSAGE_RU_INBLOCK 1

/* Define to 1 if `ru_isrss' is a member of `struct rusage'. */
#define HAVE_STRUCT_RUSAGE_RU_ISRSS 1

/* Define to 1 if `ru_ixrss' is a member of `struct rusage'. */
#define HAVE_STRUCT_RUSAGE_RU_IXRSS 1

/* Define to 1 if `ru_majflt' is a member of `struct rusage'. */
#define HAVE_STRUCT_RUSAGE_RU_MAJFLT 1

/* Define to 1 if `ru_maxrss' is a member of `struct rusage'. */
#define HAVE_STRUCT_RUSAGE_RU_MAXRSS 1

/* Define to 1 if `ru_minflt' is a member of `struct rusage'. */
#define HAVE_STRUCT_RUSAGE_RU_MINFLT 1

/* Define to 1 if `ru_msgrcv' is a member of `struct rusage'. */
#define HAVE_STRUCT_RUSAGE_RU_MSGRCV 1

/* Define to 1 if `ru_msgsnd' is a member of `struct rusage'. */
#define HAVE_STRUCT_RUSAGE_RU_MSGSND 1

/* Define to 1 if `ru_nivcsw' is a member of `struct rusage'. */
#define HAVE_STRUCT_RUSAGE_RU_NIVCSW 1

/* Define to 1 if `ru_nsignals' is a member of `struct rusage'. */
#define HAVE_STRUCT_RUSAGE_RU_NSIGNALS 1

/* Define to 1 if `ru_nswap' is a member of `struct rusage'. */
#define HAVE_STRUCT_RUSAGE_RU_NSWAP 1

/* Define to 1 if `ru_nvcsw' is a member of `struct rusage'. */
#define HAVE_STRUCT_RUSAGE_RU_NVCSW 1

/* Define to 1 if `ru_oublock' is a member of `struct rusage'. */
#define HAVE_STRUCT_RUSAGE_RU_OUBLOCK 1

/* Define if your system's struct sockaddr_in6 has a member named
   sin6_scope_id. */
#define HAVE_STRUCT_SOCKADDR_IN6_SIN6_SCOPE_ID 1

/* Define to 1 if `st_atimensec' is a member of `struct stat'. */
/* #undef HAVE_STRUCT_STAT_ST_ATIMENSEC */

/* Define to 1 if `st_atimespec.tv_nsec' is a member of `struct stat'. */
#define HAVE_STRUCT_STAT_ST_ATIMESPEC_TV_NSEC 1

/* Define to 1 if `st_atim.tv_nsec' is a member of `struct stat'. */
/* #undef HAVE_STRUCT_STAT_ST_ATIM_TV_NSEC */

/* Define to 1 if `st_ctimensec' is a member of `struct stat'. */
/* #undef HAVE_STRUCT_STAT_ST_CTIMENSEC */

/* Define to 1 if `st_ctimespec.tv_nsec' is a member of `struct stat'. */
#define HAVE_STRUCT_STAT_ST_CTIMESPEC_TV_NSEC 1

/* Define to 1 if `st_ctim.tv_nsec' is a member of `struct stat'. */
/* #undef HAVE_STRUCT_STAT_ST_CTIM_TV_NSEC */

/* Define to 1 if `st_mtimensec' is a member of `struct stat'. */
/* #undef HAVE_STRUCT_STAT_ST_MTIMENSEC */

/* Define to 1 if `st_mtimespec.tv_nsec' is a member of `struct stat'. */
#define HAVE_STRUCT_STAT_ST_MTIMESPEC_TV_NSEC 1

/* Define to 1 if `st_mtim.tv_nsec' is a member of `struct stat'. */
/* #undef HAVE_STRUCT_STAT_ST_MTIM_TV_NSEC */

/* Define to 1 if struct timespec is defined by a system header */
#define HAVE_STRUCT_TIMESPEC 1

/* Define to 1 if struct timezone is defined by a system header */
#define HAVE_STRUCT_TIMEZONE 1

/* Define to 1 if struct utmp is defined by a system header */
#define HAVE_STRUCT_UTMP 1

/* Define to 1 if struct utmpx is defined by a system header */
#define HAVE_STRUCT_UTMPX 1

/* Define if your system's struct utmpx has a member named ut_host. */
#define HAVE_STRUCT_UTMPX_UT_HOST 1

/* Define if your system's struct utmpx has a member named ut_tv. */
#define HAVE_STRUCT_UTMPX_UT_TV 1

/* Define if your system's struct utmpx has a member named ut_xtime. */
/* #undef HAVE_STRUCT_UTMPX_UT_XTIME */

/* Define if your system's struct utmp has a member named ut_host. */
#define HAVE_STRUCT_UTMP_UT_HOST 1

/* Define to 1 if you have RFS superroot directory. */
/* #undef HAVE_SUPERROOT */

/* Define to 1 if you have the `symlink' function. */
#define HAVE_SYMLINK 1

/* Define to 1 if you have the `sysconf' function. */
#define HAVE_SYSCONF 1

/* Define to 1 if you have the <sys/capability.h> header file. */
/* #undef HAVE_SYS_CAPABILITY_H */

/* Define to 1 if you have the <sys/dir.h> header file, and it defines `DIR'.
   */
/* #undef HAVE_SYS_DIR_H */

/* Define to 1 if you have the <sys/filio.h> header file. */
#define HAVE_SYS_FILIO_H 1

/* Define to 1 if you have the <sys/mman.h> header file. */
#define HAVE_SYS_MMAN_H 1

/* Define to 1 if you have the <sys/ndir.h> header file, and it defines `DIR'.
   */
/* #undef HAVE_SYS_NDIR_H */

/* Define to 1 if you have the <sys/param.h> header file. */
#define HAVE_SYS_PARAM_H 1

/* Define to 1 if you have the <sys/resource.h> header file. */
#define HAVE_SYS_RESOURCE_H 1

/* Define to 1 if you have the <sys/select.h> header file. */
#define HAVE_SYS_SELECT_H 1

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/stropts.h> header file. */
/* #undef HAVE_SYS_STROPTS_H */

/* Define to 1 if you have the <sys/times.h> header file. */
#define HAVE_SYS_TIMES_H 1

/* Define to 1 if you have the <sys/time.h> header file. */
#define HAVE_SYS_TIME_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <sys/utsname.h> header file. */
#define HAVE_SYS_UTSNAME_H 1

/* Define to 1 if you have <sys/wait.h> that is POSIX.1 compatible. */
#define HAVE_SYS_WAIT_H 1

/* Define to 1 if you have the <sys/xattr.h> header file. */
#define HAVE_SYS_XATTR_H 1

/* Define to 1 if you have the `tcgetattr' function. */
#define HAVE_TCGETATTR 1

/* Define to 1 if you have the `tcsetpgrp' function. */
#define HAVE_TCSETPGRP 1

/* Define to 1 if you have the <termcap.h> header file. */
#define HAVE_TERMCAP_H 1

/* Define to 1 if you have the <termios.h> header file. */
#define HAVE_TERMIOS_H 1

/* Define to 1 if you have the <termio.h> header file. */
/* #undef HAVE_TERMIO_H */

/* Define to 1 if you have the <term.h> header file. */
#define HAVE_TERM_H 1

/* Define to 1 if you have the `tgamma' function. */
#define HAVE_TGAMMA 1

/* Define to 1 if you have the `tgetent' function. */
#define HAVE_TGETENT 1

/* Define to 1 if you have the `tigetflag' function. */
#define HAVE_TIGETFLAG 1

/* Define to 1 if you have the `tigetnum' function. */
#define HAVE_TIGETNUM 1

/* Define to 1 if you have the `tigetstr' function. */
#define HAVE_TIGETSTR 1

/* Define to 1 if you have the `timelocal' function. */
#define HAVE_TIMELOCAL 1

/* Define to 1 if you have the `uname' function. */
#define HAVE_UNAME 1

/* Define to 1 if the compiler can initialise a union. */
#define HAVE_UNION_INIT 1

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Define to 1 if you have the `unload' function. */
/* #undef HAVE_UNLOAD */

/* Define to 1 if you have the `unlockpt' function. */
#define HAVE_UNLOCKPT 1

/* Define to 1 if you have the `unsetenv' function. */
#define HAVE_UNSETENV 1

/* Define to 1 if you have the `use_default_colors' function. */
#define HAVE_USE_DEFAULT_COLORS 1

/* Define to 1 if you have the <utmpx.h> header file. */
#define HAVE_UTMPX_H 1

/* Define to 1 if you have the <utmp.h> header file. */
#define HAVE_UTMP_H 1

/* Define to 1 if you have the <varargs.h> header file. */
/* #undef HAVE_VARARGS_H */

/* Define to 1 if compiler supports variable-length arrays */
#define HAVE_VARIABLE_LENGTH_ARRAYS 1

/* Define to 1 if you have the `waddwstr' function. */
#define HAVE_WADDWSTR 1

/* Define to 1 if you have the `wait3' function. */
#define HAVE_WAIT3 1

/* Define to 1 if you have the `waitpid' function. */
#define HAVE_WAITPID 1

/* Define to 1 if you have the <wchar.h> header file. */
#define HAVE_WCHAR_H 1

/* Define to 1 if you have the `wctomb' function. */
#define HAVE_WCTOMB 1

/* Define to 1 if you have the `wget_wch' function. */
#define HAVE_WGET_WCH 1

/* Define to 1 if you have the `win_wch' function. */
#define HAVE_WIN_WCH 1

/* Define to 1 if you have the `xw' function. */
/* #undef HAVE_XW */

/* Define to 1 if you have the `_mktemp' function. */
#define HAVE__MKTEMP 1

/* Define to 1 if you want to use dynamically loaded modules on HPUX 10. */
/* #undef HPUX10DYNAMIC */

/* Define as const if the declaration of iconv() needs const. */
#define ICONV_CONST 

/* Define to 1 if iconv() is linked from libiconv */
#define ICONV_FROM_LIBICONV 1

/* Define to 1 if ino_t is 64 bit (for large file support). */
/* #undef INO_T_IS_64_BIT */

/* Define to 1 if we must include <sys/ioctl.h> to get a prototype for
   ioctl(). */
#define IOCTL_IN_SYS_IOCTL 1

/* Define to 1 if musl is being used as the C library */
/* #undef LIBC_MUSL */

/* Definitions used when a long is less than eight byte, to try to provide
   some support for eight byte operations. Note that ZSH_64_BIT_TYPE,
   OFF_T_IS_64_BIT, INO_T_IS_64_BIT do *not* get defined if long is already 64
   bits, since in that case no special handling is required. Define to 1 if
   long is 64 bits */
#define LONG_IS_64_BIT 1

/* Define to be the machine type (microprocessor class or machine model). */
#define MACHTYPE "arm"

/* Define for Maildir support */
/* #undef MAILDIR_SUPPORT */

/* Define for function depth limits */
#define MAX_FUNCTION_DEPTH 500

/* Define to 1 if you want support for multibyte character sets. */
#define MULTIBYTE_SUPPORT 1

/* Define to 1 if you have ospeed, but it is not defined in termcap.h */
/* #undef MUST_DEFINE_OSPEED */

/* Define to 1 if you have no signal blocking at all (bummer). */
/* #undef NO_SIGNAL_BLOCKING */

/* Define to 1 if off_t is 64 bit (for large file support) */
/* #undef OFF_T_IS_64_BIT */

/* Define to be the name of the operating system. */
#define OSTYPE "darwin23.4.0"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT ""

/* Define to the full name of this package. */
#define PACKAGE_NAME ""

/* Define to the full name and version of this package. */
#define PACKAGE_STRING ""

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME ""

/* Define to the home page for this package. */
#define PACKAGE_URL ""

/* Define to the version of this package. */
#define PACKAGE_VERSION ""

/* Define to the path of the /dev/fd filesystem. */
#define PATH_DEV_FD "/dev/fd"

/* Define to be location of utmpx file. */
#define PATH_UTMPX_FILE "/var/run/utmpx"

/* Define to be location of utmp file. */
/* #undef PATH_UTMP_FILE */

/* Define to be location of wtmpx file. */
/* #undef PATH_WTMPX_FILE */

/* Define to be location of wtmp file. */
/* #undef PATH_WTMP_FILE */

/* Define to 1 if you use POSIX style signal handling. */
#define POSIX_SIGNALS 1

/* Define to 1 if printf and sprintf support %lld for long long. */
#define PRINTF_HAS_LLD 1

/* Define to 1 if ANSI function prototypes are usable. */
#define PROTOTYPES 1

/* Define if realpath() accepts NULL as its second argument. */
#define REALPATH_ACCEPTS_NULL 1

/* Undefine this if you don't want to get a restricted shell when zsh is
   exec'd with basename that starts with r. By default this is defined. */
#define RESTRICTED_R 1

/* Define to 1 if RLIMIT_RSS and RLIMIT_AS both exist and are equal. */
#define RLIMIT_RSS_IS_AS 1

/* Define to 1 if RLIMIT_VMEM and RLIMIT_AS both exist and are equal. */
/* #undef RLIMIT_VMEM_IS_AS */

/* Define to 1 if RLIMIT_VMEM and RLIMIT_RSS both exist and are equal. */
/* #undef RLIMIT_VMEM_IS_RSS */

/* Define to 1 if struct rlimit uses long long */
/* #undef RLIM_T_IS_LONG_LONG */

/* Define to 1 if struct rlimit uses quad_t. */
/* #undef RLIM_T_IS_QUAD_T */

/* Define to 1 if struct rlimit uses unsigned. */
/* #undef RLIM_T_IS_UNSIGNED */

/* Define to 1 if select() is defined in <sys/socket.h>, ie BeOS R4.51 */
/* #undef SELECT_IN_SYS_SOCKET_H */

/* If using the C implementation of alloca, define if you know the
   direction of stack growth for your system; otherwise it will be
   automatically deduced at runtime.
	STACK_DIRECTION > 0 => grows toward higher addresses
	STACK_DIRECTION < 0 => grows toward lower addresses
	STACK_DIRECTION = 0 => direction of growth unknown */
/* #undef STACK_DIRECTION */

/* Define to 1 if the `S_IS*' macros in <sys/stat.h> do not work properly. */
/* #undef STAT_MACROS_BROKEN */

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* Define to 1 if you use SYS style signal handling (and can block signals).
   */
/* #undef SYSV_SIGNALS */

/* Define to 1 if tgetent() accepts NULL as a buffer. */
/* #undef TGETENT_ACCEPTS_NULL */

/* Define to what tgetent() returns on success (0 on HP-UX X/Open curses). */
#define TGETENT_SUCCESS 1

/* Define if there is no prototype for the tgoto() terminal function. */
/* #undef TGOTO_PROTO_MISSING */

/* Define if sys/time.h and sys/select.h cannot be both included. */
/* #undef TIME_H_SELECT_H_CONFLICTS */

/* Define to 1 if you can safely include both <sys/time.h> and <time.h>. */
#define TIME_WITH_SYS_TIME 1

/* Define to 1 if all the kit for using /dev/ptmx for ptys is available. */
#define USE_DEV_PTMX 1

/* Define to 1 if you need to use the native getcwd. */
/* #undef USE_GETCWD */

/* Define to 1 if h_errno is not defined by the system. */
/* #undef USE_LOCAL_H_ERRNO */

/* Define to 1 if you want to allocate stack memory e.g. with `alloca'. */
/* #undef USE_STACK_ALLOCATION */

/* Define to be a string corresponding the vendor of the machine. */
#define VENDOR "apple"

/* Define if your should include sys/stream.h and sys/ptem.h. */
/* #undef WINSIZE_IN_PTEM */

/* Define if getxattr() etc. require additional MacOS-style arguments */
#define XATTR_EXTRA_ARGS 1

/* Define to 1 if the zlong type uses 64-bit long int. */
/* #undef ZLONG_IS_LONG_64 */

/* Define to 1 if the zlong type uses long long int. */
/* #undef ZLONG_IS_LONG_LONG */

/* Define to a 64 bit integer type if there is one, but long is shorter. */
/* #undef ZSH_64_BIT_TYPE */

/* Define to an unsigned variant of ZSH_64_BIT_TYPE if that is defined. */
/* #undef ZSH_64_BIT_UTYPE */

/* Define to 1 if you want to get debugging information on internal hash
   tables. This turns on the `hashinfo' builtin. */
/* #undef ZSH_HASH_DEBUG */

/* Define to 1 if some variant of a curses header can be included */
#define ZSH_HAVE_CURSES_H 1

/* Define to 1 if some variant of term.h can be included */
#define ZSH_HAVE_TERM_H 1

/* Define to 1 if you want to turn on error checking for heap allocation. */
/* #undef ZSH_HEAP_DEBUG */

/* Define to 1 if you want to use zsh's own memory allocation routines */
/* #undef ZSH_MEM */

/* Define to 1 if you want to debug zsh memory allocation routines. */
/* #undef ZSH_MEM_DEBUG */

/* Define to 1 if you want to turn on warnings of memory allocation errors */
/* #undef ZSH_MEM_WARNING */

/* Define if _XOPEN_SOURCE_EXTENDED should not be defined to avoid clashes */
/* #undef ZSH_NO_XOPEN */

/* Define to 1 if you want to turn on memory checking for free(). */
/* #undef ZSH_SECURE_FREE */

/* Define to 1 if you want to add code for valgrind to debug heap memory. */
/* #undef ZSH_VALGRIND */

/* Define to the base type of the third argument of accept */
#define ZSOCKLEN_T socklen_t

/* Enable large inode numbers on Mac OS X 10.5.  */
#ifndef _DARWIN_USE_64_BIT_INODE
# define _DARWIN_USE_64_BIT_INODE 1
#endif

/* Number of bits in a file offset, on hosts where this is settable. */
/* #undef _FILE_OFFSET_BITS */

/* Define for large files, on AIX-style hosts. */
/* #undef _LARGE_FILES */

/* Define to empty if `const' does not conform to ANSI C. */
/* #undef const */

/* Define to `int' if <sys/types.h> doesn't define. */
/* #undef gid_t */

/* Define to `unsigned long' if <sys/types.h> doesn't define. */
/* #undef ino_t */

/* Define to `int' if <sys/types.h> does not define. */
/* #undef mode_t */

/* Define to `long int' if <sys/types.h> does not define. */
/* #undef off_t */

/* Define to `int' if <sys/types.h> does not define. */
/* #undef pid_t */

/* Define to the type used in struct rlimit. */
/* #undef rlim_t */

/* Define to `unsigned int' if <sys/types.h> or <signal.h> doesn't define */
/* #undef sigset_t */

/* Define to `unsigned int' if <sys/types.h> does not define. */
/* #undef size_t */

/* Define to `int' if <sys/types.h> doesn't define. */
/* #undef uid_t */
