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

; find the length of the string and store it in X2
adrp X1, buff@PAGE
add X1, X1, buff@PAGEOFF
; X2 is an index, X3 is a current byte
eor X2, X2, X2
len_loop:
    cmp X2, #256
    b.eq len_loop_end
    ldrb W3, [X1, X2]
    add X2, X2, #1
    cmp W3, #0
    b.ne len_loop
len_loop_end:
sub X2, X2, #1

; to upper
; X4 - current char
; for X3 in 0 .. X2
eor X3, X3, X3
upper_loop:
    ldrb W4, [X1, X3]
    cmp W4, 'a'
    b.cc skip
    cmp W4, '{'
    b.cs skip
    sub W4, W4, #('a' - 'A')
    strb W4, [X1, X3]
    skip:
    add X3, X3, #1
    cmp X3, X2
    b.ne upper_loop

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
