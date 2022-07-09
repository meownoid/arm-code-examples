.global toupper
.align 2

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
