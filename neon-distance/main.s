.global main
.align 2

main:
    str LR, [SP, #-16]!

    adrp X0, vector_1@PAGE
    add X0, X0, vector_1@PAGEOFF
    ldr Q0, [X0]

    adrp X0, vector_2@PAGE
    add X0, X0, vector_2@PAGEOFF
    ldr Q1, [X0]

    bl distance
    fmov S1, W0
    fcvt D0, S1

    adrp X0, fstr@PAGE
    add X0, X0, fstr@PAGEOFF

    sub SP, SP, #16
    str D0, [SP]
    bl _printf
    add SP, SP, #16

    mov X0, XZR

    ldr LR, [SP], #16
    ret

.data
vector_1: .single 1.0, 2.0, 3.0, 4.0
vector_2: .single 5.5, 6.6, 7.7, 8.8
fstr: .asciz "distance = %f\n"
