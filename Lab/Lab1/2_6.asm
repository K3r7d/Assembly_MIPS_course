    .data
prompt: .asciiz "Enter a decimal number: "
buffer: .space 32

    .text
    .globl main
main:
    # Print prompt
    la $a0, prompt
    li $v0, 4
    syscall

    # Read integer
    li $v0, 5
    syscall

    # Store number in $t0
    move $t0, $v0

    # Print 10-bit binary representation
    li $t1, 9  # counter for 10 bits
print_loop:
    # Shift right by counter
    srlv $t2, $t0, $t1

    # Isolate bit
    andi $t2, $t2, 1

    # Print bit
    add $a0, $t2, '0'
    li $v0, 11
    syscall

    # Decrement counter
    sub $t1, $t1, 1

    # Repeat for all bits
    bgez $t1, print_loop

exit:
    # Exit program
    li $v0, 10
    syscall
