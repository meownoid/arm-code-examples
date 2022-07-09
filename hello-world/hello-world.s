.global _start
.align 2

_start:
    mov X0, #1           // fd (stdout)
    adr X1, helloworld   // cbuf
    mov X2, #14          // nbyte
    mov X16, #4          // user_ssize_t write(int fd, user_addr_t cbuf, user_size_t nbyte);
    svc #0x80
    mov X0, #0           // rval
    mov X16, #1          // void exit(int rval)
    svc #0x80

helloworld: .ascii "Hello, world!\n"
