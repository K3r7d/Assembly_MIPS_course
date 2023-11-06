.data
array:      .space 40      # 10 integers, each 4 bytes
prompt:     .asciiz "Enter an integer: "
newline:    .asciiz "\n"

.text
.globl main

main:
    la $a0, array          # Load the base address of the array into $a0
    li $t0, 10             # Set the loop counter to 10

input_loop:
    # Print the prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Read an integer from the user
    li $v0, 5
    syscall

    # Store the input integer into the array
    sw $v0, 0($a0)

    addi $a0, $a0, 4       # Move to the next element in the array
    addi $t0, $t0, -1      # Decrement the loop counter

    bnez $t0, input_loop   # Branch back to input_loop if counter is not zero

    # Print the array
    la $a0, array          # Reset $a0 to the base address of the array
    li $t0, 10             # Set the loop counter to 10

    li $t1, 0
print_loop:
    lw $a1, array($t1)         # Load the integer from the array into $a1
   
    # Print the integer
    li $v0, 1
    move $a0, $a1
    syscall

    # Print a newline
    li $v0, 4
    la $a0, newline
    syscall

    addi $a0, $a0, 4       # Move to the next element in the array
    addi $t0, $t0, -1      # Decrement the loop counter
    addi $t1, $t1, 4
    bnez $t0, print_loop   # Branch back to print_loop if counter is not zero

    # Exit the program
    li $v0, 10
    syscall
