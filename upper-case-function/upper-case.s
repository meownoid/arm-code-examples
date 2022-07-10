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

strlen:
    ; find the length of the string (up to 256)
    ; X0 - pointer to string
    ;
    ; X1 is an index, X2 is a current byte
    eor X1, X1, X1
    len_loop:
        cmp X1, #256
        b.eq len_loop_end
        ldrb W2, [X0, X1]
        add X1, X1, #1
        cmp W2, #0
        b.ne len_loop
    len_loop_end:
    sub X1, X1, #1
    mov X0, X1
    ret

toupper:
    ; convert string to upper case ignoring characters outside of a-z range
    ; X0 - pointer to string
    ; X1 – string length
    ;
    ; X2 is an index, X3 is a current byte
    eor X2, X2, X2
    upper_loop:
        ldrb W3, [X0, X2]
        cmp W3, 'a'
        b.cc skip
        cmp W3, '{'
        b.cs skip
        sub W3, W3, #('a' - 'A')
        strb W3, [X0, X2]
        skip:
        add X2, X2, #1
        cmp X2, X1
        b.ne upper_loop
    ret

.data
buff: .fill 256, 1, 0
