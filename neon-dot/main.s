.global main
.align 2

; Multiplies two 4x4 matrices and outputs result
main:
    str LR, [SP, #-16]!
    stp X19, X20, [SP, #-16]!

    ; load A
    adrp X0, matrix_a@PAGE
    add X0, X0, matrix_a@PAGEOFF

    ldp Q0, Q1, [X0]
    ldp Q2, Q3, [X0, #32]

    ; load B
    adrp X0, matrix_b@PAGE
    add X0, X0, matrix_b@PAGEOFF

    ldp Q4, Q5, [X0]
    ldp Q6, Q7, [X0, #32]

    ; Calulates one column of a resulting matrix
    .macro mcol   col_b, col_r
        fmul.4S \col_r\(), V0, \col_b\()[0]
        fmla.4S \col_r\(), V1, \col_b\()[1]
        fmla.4S \col_r\(), V2, \col_b\()[2]
        fmla.4S \col_r\(), V3, \col_b\()[3]
    .endm

    mcol V4, V8
    mcol V5, V9
    mcol V6, V10
    mcol V7, V11

    adrp X0, matrix_r@PAGE
    add X0, X0, matrix_r@PAGEOFF

    stp Q8, Q9, [X0]
    stp Q10, Q11, [X0, #32]

    adrp X19, matrix_r@PAGE
    add X19, X19, matrix_r@PAGEOFF

    adrp X20, fstr@PAGE
    add X20, X20, fstr@PAGEOFF

    ; Prints row of a matrix stored in columnar order
    ; Requires 32 bytes on stack to pass arguments to printf
    .macro print_row   row
        ldr S0, [X19, #(\row * 4)]
        ldr S1, [X19, #(\row * 4 + 16)]
        ldr S2, [X19, #(\row * 4 + 32)]
        ldr S3, [X19, #(\row * 4 + 48)]
        fcvt D4, S0
        fcvt D5, S1
        fcvt D6, S2
        fcvt D7, S3
        stp D4, D5, [SP]
        stp D6, D7, [SP, #16]
        mov X0, X20
        bl _printf
    .endm

    sub SP, SP, #32
    print_row 0
    print_row 1
    print_row 2
    print_row 3
    add SP, SP, #32

    mov X0, XZR

    ldp X19, X20, [SP], #16
    ldr LR, [SP], #16
    ret

.data
    matrix_a: .single  1.0,  5.0,  9.0, 13.0
              .single  2.0,  6.0, 10.0, 14.0
              .single  3.0,  7.0, 11.0, 15.0
              .single  4.0,  8.0, 12.0, 16.0

    matrix_b: .single 16.0, 12.0,  8.0,  4.0
              .single 15.0, 11.0,  7.0,  3.0
              .single 14.0, 10.0,  6.0,  2.0
              .single 13.0,  9.0,  5.0,  1.0

    matrix_r: .fill 16, 4, 0

    fstr: .asciz "%10.3f %10.3f %10.3f %10.3f \n"
