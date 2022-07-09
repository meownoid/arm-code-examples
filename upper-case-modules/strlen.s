.global strlen
.align 2

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
