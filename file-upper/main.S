#include "fileio.S"

.equ BUFFER_LEN, 256

.global _start
.align 2

_start:
    open_file INPUT_FILE, O_RDONLY
    adds X11, XZR, X0   ; input fd
    b.pl skip_input_error
    mov X1, #1   ; stdout
    adrp X2, INPUT_ERROR_SIZE@PAGE
    add X2, X2, INPUT_ERROR_SIZE@PAGEOFF
    ldr W2, [X2]
    write_file X1, INPUT_ERROR_MESSAGE, X2
    b exit

skip_input_error:
    open_file OUTPUT_FILE, O_CREAT+O_WRONLY
    adds X12, XZR, X0   ; output fd
    b.pl skip_output_error
    mov X1, #1   ; stdout
    adrp X2, OUTPUT_ERROR_SIZE@PAGE
    add X2, X2, OUTPUT_ERROR_SIZE@PAGEOFF
    ldr W2, [X2]
    write_file X1, OUTPUT_ERROR_MESSAGE, X2
    b exit

skip_output_error:
loop:
    read_file X11, BUFFER, BUFFER_LEN
    mov X13, X0   ; length read

    adrp X0, BUFFER@PAGE
    add X0, X0, BUFFER@PAGEOFF
    mov X1, X13
    bl toupper

    write_file X12, BUFFER, X13

    cmp X13, BUFFER_LEN
    b.eq loop

    flush_close X11
    flush_close X12

exit:
    mov X0, XZR
    mov X16, #SYS_exit
    svc #0x80

toupper:
    ; convert string to upper case ignoring characters outside of a-z range
    ; X0 - pointer to string
    ; X1 – string length
    ;
    ; X2 is an index, X3 is a current byte
    eor X2, X2, X2
    upper_loop:
        ldrb W3, [X0, X2]
        cmp W3, 'a'
        b.cc skip
        cmp W3, '{'
        b.cs skip
        sub W3, W3, #('a' - 'A')
        strb W3, [X0, X2]
        skip:
        add X2, X2, #1
        cmp X2, X1
        b.ne upper_loop
    ret


INPUT_FILE: .asciz "data.txt"
OUTPUT_FILE: .asciz "data-upper.txt"
INPUT_ERROR_MESSAGE: .asciz "Failed to open input file\n"
INPUT_ERROR_SIZE: .word  .-INPUT_ERROR_MESSAGE
OUTPUT_ERROR_MESSAGE: .asciz "Failed to open output file\n"
OUTPUT_ERROR_SIZE: .word  .-OUTPUT_ERROR_MESSAGE

.data
BUFFER: .fill  BUFFER_LEN + 1, 1, 0
