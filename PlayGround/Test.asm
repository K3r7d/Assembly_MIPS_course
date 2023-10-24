.data
    print: .asciiz "Hello World \n"
    char:  .byte 'a'
    num:   .word 10

.text
.globl main

# Function to print a string
print_string:
    li $v0, 4
    syscall
    jr $ra

# Function to print a character
print_char:
    li $v0, 11
    syscall
    jr $ra

# Function to print an integer
print_int:
    li $v0, 1
    syscall
    jr $ra

main:
    # Print string
    la $a0, print
    jal print_string

    # Print character
    la $a0, char
    jal print_char

    # Print integer
    lw $a0, num
    jal print_int

    # Exit
    li $v0, 10
    syscall
