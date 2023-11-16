.data
	input: .asciiz "Input an interger: "
	invalid: .asciiz "A factorial for your number cannot be found."
	newline: .asciiz "\n"
.text
	#input
	li $v0, 4
	la $a0, input
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	
	#handle error
	bge $s0,0, factorial
	li $v0, 4
	la $a0, invalid
	syscall
	j exit
	
factorial:
	li $t0, 1
	loop:
	mul $t0, $t0, $s0
	subi $s0, $s0, 1
	beq $s0, 0, print
	j loop
print:
	li $v0, 1
	move $a0, $t0
	syscall
exit:
	li $v0, 10
	syscall
	
	
	
	
	