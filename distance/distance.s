.global distance
.align 2

distance:
    ; Calculate distance between points (S0, S1) and (S2, S3)
    str LR, [SP, #-16]!

    fsub S4, S2, S0
    fsub S5, S3, S1
    fmul S4, S4, S4
    fmul S5, S5, S5
    fadd S4, S4, S5
    fsqrt S4, S4
    fmov W0, S4

    ldr LR, [SP], #16
    ret
