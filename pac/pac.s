.global _start
.align 2

_start:
    bl fn_1
    bl fn_2

    mov X0, #0
    mov X16, #1
    svc #0x80

fn_1:
    // prints its name and returns

    pacib LR, SP         // same as pacibsp
                         // sign LR using SP as a nonce
    mov X0, #1
    adr X1, msg_1
    mov X2, #5
    mov X16, #4
    svc #0x80
    autib LR, SP         // same as retab
                         // authenticate LR using SP as a nonce
    ret

fn_2:
    // prints its name and returns

    pacibsp              // sign LR using SP as a nonce
    mov X0, #1
    adr X1, msg_2
    mov X2, #5
    mov X16, #4
    svc #0x80
    adr LR, fn_3         // comment to avoid an error
    retab                // authenticate LR using SP as a nonce

fn_3:
    // prints its name and exits

    mov X0, #1
    adr X1, msg_3
    mov X2, #5
    mov X16, #4
    svc #0x80

    mov X0, #0
    mov X16, #1
    svc #0x80



.align 4
msg_1: .ascii "fn_1\n"
.align 4
msg_2: .ascii "fn_2\n"
.align 4
msg_3: .ascii "fn_3\n"
