.data
	arr: .space 15
	arr_val: .word 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14
	prompt1: .asciiz "Choose mode(1 or 2) : "
	mode1: .asciiz "Mode 1, input number in range 0-14: "
	mode2a: .asciiz "Mode 2, input a in range 0-14: "
	mode2b: .asciiz "Mode 2, input b in range 0-14(b is larger than a) : "
	invalid_message: .asciiz "Invalid input"
.text
	#choose mode
input:
	li $v0 ,4
	la $a0, prompt1
	syscall
	#input mode
	li $v0, 5
	syscall
	move $t0, $v0
	
	beq $t0, 1, one
	beq $t0, 2, two
	j input
	
one:	#mode 1
	li $v0 ,4
	la $a0, mode1
	syscall
	#input
	li $v0, 5
	syscall
	move $a0, $v0
	#print
	li $v0, 1
	syscall
	j exit
two:    # mode2
    # Prompt
    li $v0, 4
    la $a0, mode2a
    syscall

    # Read a
    li $v0, 5
    syscall
    move $t1, $v0

    # Prompt 
    li $v0, 4
    la $a0, mode2b
    syscall

    # Read b
    li $v0, 5
    syscall
    move $t2, $v0

    # Check 
    bgt $t1, $t2, invalid_indices
print_sequence:
    
    la $t4, arr_val
    mul $t5, $t1, 4       
    add $t4, $t4, $t5  

    lw $t3, 0($t4)       
    li $v0, 1             
    move $a0, $t3          
    syscall

    addi $t1, $t1, 1     
    ble $t1, $t2, print_sequence

    # Exit the program
    li $v0, 10              # Exit syscall code
    syscall

invalid_indices:
    li $v0, 4
    la $a0, invalid_message
    syscall

exit:	#exit
	li $v0 , 10
	syscall