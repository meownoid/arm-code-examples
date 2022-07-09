.global _start
.align 2

_start:
    adr X1, arr
    mov X2, #0
    eor X3, X3, X3
loop:
    ldrb W3, [X1, X2]
    add X2, X2, #1
    cmp X2, #8
    B.NE loop

    mov X0, #0
    mov X16, #1
    svc #0x80

arr: .byte 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08
