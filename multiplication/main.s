.include "debug.s"

.global main
.align 2

main:
    stp FP, LR, [SP, #-16]!

    mov X2, #25
    mov X3, #4

    printString "Inputs:"
    printRegister 2
    printRegister 3

    mul X4, X2, X3
    printString "mul X4, X2, X3"
    printRegister 4

    mneg X4, X2, X3
    printString "mneg X4, X2, X3"
    printRegister 4

    smull X4, W2, W3
    printString "smull X4, W2, W3"
    printRegister 4

    smnegl X4, W2, W3
    printString "smnegl X4, W2, W3"
    printRegister 4

    umull X4, W2, W3
    printString "umull X4, W2, W3"
    printRegister 4

    umnegl X4, W2, W3
    printString "umnegl X4, W2, W3"
    printRegister 4

    adrp X2, A@PAGE
    add X2, X2, A@PAGEOFF
    ldr X2, [X2]

    adrp X3, B@PAGE
    add X3, X3, B@PAGEOFF
    ldr X3, [X3]

    printString "Inputs:"
    printRegister 2
    printRegister 3

    mul X4, X2, X3
    printString "mul X4, X2, X3"
    printString "(lower bits)"
    printRegister 4

    smulh X4, X2, X3
    printString "smulh X4, X2, X3"
    printString "(higher bits)"
    printRegister 4

    umulh X4, X2, X3
    printString "umulh X4, X2, X3"
    printString "(higher bits)"
    printRegister 4

    ldp FP, LR, [SP], #16

    mov X0, #0
    ret

.data
A: .dword    0x7812345678
B: .dword    0xFABCD12345678901
