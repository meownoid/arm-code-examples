.global main
.align 2

main:
    str LR, [SP, #-16]!

    adrp X0, points@PAGE
    add X0, X0, points@PAGEOFF
    ldp S0, S1, [X0]
    ldp S2, S3, [X0, #8]
    bl distance
    fmov S2, W0
    fcvt D0, S2

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
points: .single 0.0, 0.0, 3.0, 4.0
fstr: .asciz "distance = %f\n"
