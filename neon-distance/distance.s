.global distance
.align 2

distance:
    ; Takes two 4d vectors in V0, V1
    ; Returns distance in 
    fsub V2.4S, V0.4S, V1.4S
    fmul V2.4S, V2.4S, V2.4S
    faddp V0.4S, V2.4S, V2.4S
    faddp V0.4S, V0.4S, V0.4S
    fsqrt S1, S0
    fmov W0, S1
    ret
