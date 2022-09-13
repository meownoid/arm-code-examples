.include "debug.s"

.global main
.align 2

main:
    stp FP, LR, [SP, #-16]!
    stp X20, X19, [SP, #-16]!

    ; MULTIPLICATION

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

    ; DIVISION

    mov X2, #100
    mov X3, #4

    printString "Inputs:"
    printRegister 2
    printRegister 3

    sdiv X4, X2, X3
    printString "sdiv X4, X2, X3"
    printRegister 4

    sdiv X4, X3, X2
    printString "sdiv X4, X3, X2"
    printRegister 4

    udiv X4, X2, X3
    printString "udiv X4, X2, X3"
    printRegister 4

    udiv X4, X3, X2
    printString "udiv X4, X3, X2"
    printRegister 4

    sdiv X4, X2, XZR
    printString "sdiv X4, X2, XZR"
    printString "(division by zero)"
    printRegister 4

    ; 3x3 MATRIX MULTIPLICATION

    mov X1, #0   ; Row index
    mov X2, #0   ; Col index
    
    adrp X4, Am@PAGE
    add  X4, X4, Am@PAGEOFF

    adrp X5, Bm@PAGE
    add  X5, X5, Bm@PAGEOFF

    adrp X19, Cm@PAGE
    add  X19, X19, Cm@PAGEOFF

    mov X20, X19   ; C pointer

    loop_row:
        eor X2, X2, X2
        loop_col:
            eor X7, X7, X7   ; Accumulator
            eor X8, X8, X8   ; counter
            mov X11, X4      ; A[row][0]
            add X11, X11, X1
            mov X12, X5      ; B[0][col]
            add X12, X12, X2
            
            loop_inner:
                ldr X9, [X11], #8
                ldr X10, [X12], #24
                madd X7, X9, X10, X7

                add X8, X8, #1
                cmp X8, #3
                b.ne loop_inner
            
            str X7, [X20], #8
            add X2, X2, #8
            cmp X2, #24
            b.ne loop_col

        add X1, X1, #24
        cmp X1, #72
        b.ne loop_row

    printString "Matrix multiplication result:"
    
    eor X0, X0, X0
    mov X20, X19
    loop_print:
        ldr X1, [X20], #8
        printRegister 1
        add X0, X0, #1
        cmp X0, #9
        b.ne loop_print

    ldp X20, X19, [SP], #16
    ldp FP, LR, [SP], #16

    mov X0, #0
    ret

.data
A: .dword    0x7812345678
B: .dword    0xFABCD12345678901

Am:    .dword   1, 2, 3
       .dword   4, 5, 6
       .dword   7, 8, 9
Bm:    .dword   9, 8, 7
       .dword   6, 5, 4
       .dword   3, 2, 1
Cm:    .fill    9, 8, 0
