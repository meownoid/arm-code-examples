.global _start
.align 2

_start:
; read
mov X0, #0                ; stdin
adrp X1, buff@PAGE
add X1, X1, buff@PAGEOFF  ; string to read
mov X2, #256              ; length
mov X16, #3               ; user_ssize_t read(int fd, user_addr_t cbuf, user_size_t nbyte);
svc #0x80

adrp X0, buff@PAGE
add X0, X0, buff@PAGEOFF  ; pointer to string
bl strlen

mov X1, X0                ; string length
adrp X0, buff@PAGE
add X0, X0, buff@PAGEOFF  ; pointer to string
bl toupper

; write
mov X0, #1                ; stdout
adrp X1, buff@PAGE
add X1, X1, buff@PAGEOFF  ; string to write
mov X2, X2                ; length
mov X16, #4               ; user_ssize_t write(int fd, user_addr_t cbuf, user_size_t nbyte);
svc #0x80

; exit
mov X0, #0
mov X16, #1
svc #0x80

.data
buff: .fill 256, 1, 0
