#include <stdio.h>

int main() {
    char message[] = "Test string! 123@#$!";
    
    asm (
        "mov X0, %0\n"
        "eor X1, X1, X1\n"
        "0:\n"
        "    cmp X1, #256\n"
        "    b.eq 1f\n"
        "    ldrb W2, [X0, X1]\n"
        "    add X1, X1, #1\n"
        "    cmp W2, #0\n"
        "    b.ne 0b\n"
        "1:\n"
        "sub X1, X1, #1\n"
        "eor X2, X2, X2\n"
        "2:\n"
        "    ldrb W3, [X0, X2]\n"
        "    cmp W3, 'a'\n"
        "    b.cc 3f\n"
        "    cmp W3, '{'\n"
        "    b.cs 3f\n"
        "    sub W3, W3, #('a' - 'A')\n"
        "    strb W3, [X0, X2]\n"
        "    3:\n"
        "    add X2, X2, #1\n"
        "    cmp X2, X1\n"
        "    b.ne 2b\n"
        :
        : "r" (message)
        : "r0", "r1", "r2", "r3"
    );

    printf("%s\n", message);

    return 0;
}