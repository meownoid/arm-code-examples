.global _asm_toupper_inplace
.align 2

_asm_toupper_inplace:
    ; convert string to upper case ignoring characters outside of a-z range
    ; X0 - pointer to string
    ;
    ; find the length of the string (up to 256)
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
    ; transform string to upper case in place
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
