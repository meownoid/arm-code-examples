.include "debug.s"

.global main
.align 2

main:
    str LR, [SP, #-16]!

    // Adding 128-bit numbers
    // First number is in X2 and X3
    // 0x0000000000000003FFFFFFFFFFFFFFFF
    mov X2, #0x0000000000000003
    mov X3, #0xFFFFFFFFFFFFFFFF
    // Second number is in X4 and X5
    // 0x00000000000000050000000000000001
    mov  X4, #0x0000000000000005
    mov  X5, #0x0000000000000001
    // Result is in X6, X7
    adds X7, X3, X5      // low order 64 bits
    adc X6, X2, X4       // high order 64 bits

    printString "Input A:"
    printRegister 2
    printRegister 3
    printString "Input B:"
    printRegister 4
    printRegister 5
    printString "Output:"
    printRegister 6
    printRegister 7

    mov X0, #0
    mov X16, #1
    svc #0x80
