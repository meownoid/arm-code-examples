.global  _start
.p2align 2

_start:
    // Initialize X2 with 64-bit value
    movz X2, #0x6E3A
    movk X2, #0x4F5D, LSL #16
    movk X2, #0xFEDC, LSL #32
    movk X2, #0x1234, LSL #48

    // Now copy X2 to X3
    mov X3, X2           // without shift
    lsr X3, X2, #1       // logical shift right
    asr X3, X2, #5       // arithmetic shift right
    ror X3, X2, #5       // rotate right

    // Will be translated to mov X2, #0xAB00, LSL #16
    mov    X2, #0xAB000000

    // Will generate error
    // mov    X2, #0xABCDEF11

    // 32 bit registers
    mov W3, W2

    // MOVN = Move Not
    movn W4, #0xAB

    // X4 = X3 + 4000
    add X4, X3, #4000

    // X4 = X3 + 0x20000
    add X4, X3, #0x20, LSL 12

    // X4 = X3 + X2
    add X4, X3, X2

    // X4 += X3
    add X4, X4, X3

    // X4 = X2 + (X3 * 4)
    // X4 = X2 + (X3 << 2)
    add X4, X2, X3, LSL 2

    // X4 = X3 + SXTB(X2)
    // (first byte of the X2 will be extended to 8 bytes)
    // Not working for some reason
    // add X4, X3, X2, SXTB

    // Multiply 2 by -1 by using logical not and then adding 1
    movn W0, #2
    add W0, W0, #1

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

    // X3 = X2 - 17
    sub X3, X2, #17

    // Two's complement for -79
    movn W1, #79
    add W1, W1, #1

    // Add two 192-bit numbers
    // 0xfc60977740bc3f462f3d93e939a66db54c33f93f234f3d64
    // 0x96d16d6d8c2970a7024d99c75d45d228fb35d5b7978fd048

    movz X1, #0x3f46
    movk X1, #0x40bc, LSL #16
    movk X1, #0x9777, LSL #32
    movk X1, #0xfc60, LSL #48

    movz X2, #0x6db5
    movk X2, #0x39a6, LSL #16
    movk X2, #0x93e9, LSL #32
    movk X2, #0x2f3d, LSL #48

    movz X3, #0x3d64
    movk X3, #0x234f, LSL #16
    movk X3, #0xf93f, LSL #32
    movk X3, #0x4c33, LSL #48

    movz X4, #0x70a7
    movk X4, #0x8c29, LSL #16
    movk X4, #0x6d6d, LSL #32
    movk X4, #0x96d1, LSL #48

    movz X5, #0xd228
    movk X5, #0x5d45, LSL #16
    movk X5, #0x99c7, LSL #32
    movk X5, #0x24d, LSL #48

    movz X6, #0xd048
    movk X6, #0x978f, LSL #16
    movk X6, #0xd5b7, LSL #32
    movk X6, #0xfb35, LSL #48

    adds X9, X3, X6
    adcs X8, X2, X5
    adc X7, X1, X4

    // 128-bit subtraction
    // 0xc33335f2d16dad2544725acd391ad251
    // 0xc084f4e35baa64c4ca68573a71d696ce
    movz X1, #0xad25
    movk X1, #0xd16d, LSL #16
    movk X1, #0x35f2, LSL #32
    movk X1, #0xc333, LSL #48

    movz X2, #0xd251
    movk X2, #0x391a, LSL #16
    movk X2, #0x5acd, LSL #32
    movk X2, #0x4472, LSL #48

    movz X3, #0x64c4
    movk X3, #0x5baa, LSL #16
    movk X3, #0xf4e3, LSL #32
    movk X3, #0xc084, LSL #48

    movz X4, #0x96ce
    movk X4, #0x71d6, LSL #16
    movk X4, #0x573a, LSL #32
    movk X4, #0xca68, LSL #48

    sub X6, X2, X4
    sbc X5, X1, X3

    mov X0, #0           // rval
    mov X16, #1          // void exit(int rval)
    svc #0x80
