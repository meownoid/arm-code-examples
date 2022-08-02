.global _start
.align 2

_start:
    mov X0, #754
    bl itoa

    mov X2, X1
    mov X1, X0
    mov X0, #1
    mov X16, #4
    svc #0x80

    mov X0, #0
    mov X16, #1
    svc #0x80

; Converts integer to string
; Arguments:
;   X0 - value
; Returns:
;   X0 - buffer address
;   X1 - buffer length
itoa:
    ; save sign
    lsr X7, X0, #63
    cmp X7, #0
    b.eq skip_negate

    sub X0, XZR, X0

    skip_negate:

    ; convert
    mov X2, X0
    adrp X0, buffer@PAGE
    add X0, X0, buffer@PAGEOFF
    mov X1, #0
    convert_loop:
        mov X3, #10
        udiv X4, X2, X3
        msub X5, X4, X3, X2
        ; X4 - div, X5 - mod
        add X5, X5, '0'
        strb W5, [X0, X1]
        mov X2, X4
        cmp X2, #0
        add X1, X1, #1
        b.ne convert_loop

    cmp X7, #0
    b.eq skip_minus

    mov W2, '-'
    strb W2, [X0, X1]
    add X1, X1, #1

    skip_minus:

    ; reverse
    sub X6, X1, #1
    mov X2, #0
    reverse_loop:
        sub X3, X6, X2
        cmp X2, X3
        b.hs end
        ldrb W4, [X0, X2]
        ldrb W5, [X0, X3]
        strb W4, [X0, X3]
        strb W5, [X0, X2]
        add X2, X2, #1
        b reverse_loop

    end:

    strb WZR, [X0, X1]

    ret

.data
buffer: .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
