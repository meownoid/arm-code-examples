.global _start
.align 2

; X0-X2 - parameters to syscalls
; X1 - address of byte we are writing
; X4 - register to print
; W5 - loop index
; W6 - current character
; W16 - syscall number

; String will be formed at hexstr

_start:
    ; X4 = 0x1234FEDC4F5D6E3A
    mov X4, #0x6E3A
    movk X4, #0x4F5D, LSL #16
    movk X4, #0xFEDC, LSL #32
    movk X4, #0x1234, LSL #48

    adrp X1, hexstr@PAGE           ; X1 is the pointer to the page where hexstr is located
    add X1, X1, hexstr@PAGEOFF     ; add offset from beginning of the page
                                   ; X1 now is the pointer to the hexstr
    add X1, X1, #17              ; move to the end of the string

    ; FOR W5 = 16 TO 1 STEP -1
    mov W5, #16
    loop:
        and W6, W4, #0xF   ; W6 = W4 & 0xF
                           ; mask lower 16 bits of 32-bit W4
                           ; W4 is the lower 32 bits of X4
                           ; mod 16
        cmp W6, #10        ; if W6 >= 10:
        b.ge letter        ;    goto letter
                           ; else:
        add W6, W6, #'0'   ;    its a number, convert to ascii character
        b endif            ;    goto endit
    letter:
        add W6, W6, #('A'-10)
    endif:
        strb W6, [X1]      ; store byte from W6 in X1
        sub X1, X1, #1     ; move to next character in the result string
        lsr X4, X4, #4     ; shift off the digit
                           ; div 16
        subs W5, W5, #1    ; W5 = W5 - 1, loop counter
        b.ne loop          ; if W5 > 0:
                           ;     goto loop

    mov X0, #1             ; stdout
    adrp X1, hexstr@PAGE           ; X1 is the pointer to the page where hexstr is located
    add X1, X1, hexstr@PAGEOFF     ; add offset from beginning of the page
                                   ; X1 now is the pointer to the hexstr
    mov X2, #19            ; length
    mov X16, #4            ; user_ssize_t write(int fd, user_addr_t cbuf, user_size_t nbyte);
    svc #0x80              ; call

    mov X0, #0             ; rval
    mov X16, #1            ; void exit(int rval)
    svc #0x80

.data
hexstr: .ascii "0x0000000000000000\n"
