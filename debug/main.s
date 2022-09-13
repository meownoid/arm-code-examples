.include "debug.s"

.global main
.align 2

main:
    stp FP, LR, [SP, #-16]!

    mov X2, #0x0000000000000103
    mov X3, #0xFFFFFFFFFFFFFFFF

    printString "Input A:"
    printRegister 2
    printRegister 3

    mov  X4, #0x0000000000002007
    mov  X5, #0x0000000000000001

    printString "Input B:"
    printRegister 4
    printRegister 5

    adds X7, X3, X5      // low order 64 bits
    adc X6, X2, X4       // high order 64 bits

    printString "Output:"
    printRegister 6
    printRegister 7

    ldp FP, LR, [SP], #16

    mov X0, #0
    ret
