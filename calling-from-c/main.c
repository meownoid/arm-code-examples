#include <stdio.h>

extern void asm_toupper_inplace(char*);

int main() {
    char message[] = "Test string! 123@#$!";
    asm_toupper_inplace(message);
    printf("%s\n", message);

    return 0;
}