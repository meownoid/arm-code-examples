.macro   printRegister   reg
    stp X0, X1, [SP, #-16]!
    stp X2, X3, [SP, #-16]!
    stp X4, X5, [SP, #-16]!
    stp X6, X7, [SP, #-16]!
    stp X8, X9, [SP, #-16]!
    stp X10, X11, [SP, #-16]!
    stp X12, X13, [SP, #-16]!
    stp X14, X15, [SP, #-16]!
    stp X16, X17, [SP, #-16]!
    stp XZR, LR, [SP, #-16]!

    sub SP, SP, #32

    mov X0, X\reg
    mov X1, X\reg
    stp X0, X1, [SP, #8]
    mov X0, #\reg
    add X0, X0, #'0'
    str X0, [SP]
    adrp X0, formatString@PAGE
    add X0, X0, formatString@PAGEOFF
    bl _printf

    add SP, SP, #32

    ldp XZR, LR, [SP], #16
    ldp X16, X17, [SP], #16
    ldp X14, X15, [SP], #16
    ldp X12, X13, [SP], #16
    ldp X10, X11, [SP], #16
    ldp X8, X9, [SP], #16
    ldp X6, X7, [SP], #16
    ldp X4, X5, [SP], #16
    ldp X2, X3, [SP], #16
    ldp X0, X1, [SP], #16
.endm

.macro   printString   txt
    stp X0, X1, [SP, #-16]!
    stp X2, X3, [SP, #-16]!
    stp X4, X5, [SP, #-16]!
    stp X6, X7, [SP, #-16]!
    stp X8, X9, [SP, #-16]!
    stp X10, X11, [SP, #-16]!
    stp X12, X13, [SP, #-16]!
    stp X14, X15, [SP, #-16]!
    stp X16, X17, [SP, #-16]!
    stp XZR, LR, [SP, #-16]!

    adrp X0, 1f@PAGE
    add X0, X0, 1f@PAGEOFF
    bl _printf

    ldp XZR, LR, [SP], #16
    ldp X16, X17, [SP], #16
    ldp X14, X15, [SP], #16
    ldp X12, X13, [SP], #16
    ldp X10, X11, [SP], #16
    ldp X8, X9, [SP], #16
    ldp X6, X7, [SP], #16
    ldp X4, X5, [SP], #16
    ldp X2, X3, [SP], #16
    ldp X0, X1, [SP], #16
    b 2f
    1: .asciz "\txt\n"
       .align 4
    2:
.endm

.data
formatString: .asciz "X%c = %32ld, 0x%016lx\n"
.align 4
.text
