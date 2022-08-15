#include <sys/syscall.h>

.equ	O_RDONLY, 0x0000      ; open for reading only
.equ	O_WRONLY, 0x0001      ; open for writing only
.equ	O_CREAT,  0x00000200  ; create if nonexistant
.equ	AT_FDCWD, -2          ; descriptor value for the current working directory

.macro open_file   name, flags
    mov X0, #AT_FDCWD
    adrp X1, \name@PAGE
	add X1, X1, \name@PAGEOFF
    mov X2, #\flags
	mov X3, #0666
    mov X16, #SYS_openat
    svc #0x80
.endm

.macro read_file   fd, buffer, length
    mov X0, \fd
    adrp X1, \buffer@PAGE
    add X1, X1, \buffer@PAGEOFF
    mov X2, #\length
    mov X16, #SYS_read
    svc #0x80
.endm

.macro write_file   fd, buffer, length
    mov X0, \fd
    adrp X1, \buffer@PAGE
    add X1, X1, \buffer@PAGEOFF
    mov X2, \length
    mov X16, #SYS_write
    svc #0x80
.endm

.macro flush_close   fd
    mov X0, \fd
    mov X16, #SYS_fsync
    svc #0x80

    mov X0, \fd
    mov X16, #SYS_close
    svc #0x80
.endm
