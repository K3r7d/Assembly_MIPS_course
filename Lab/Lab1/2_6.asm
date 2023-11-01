.data
	prompt: .asciiz "Enter a 10 bit binary number: "
	res: .word 0
	ans: .asciiz "Answer: " 
.text
.globl main
main:
	li $v0, 4
	la $a0, prompt
	syscall
	li $v0, 5
	syscall
	move $t0, $v0

	li $t1, 1
	li $t4, 0
	li $t2, 0
	li $t5, 10

loop:
	bge $t2 , 10 , exit

	div $t0, $t5
	mflo $t0
	mfhi $t3

	addi $t2, $t2, 1
	sll $t1,$t1,1

	beqz $t3 else
	add $t4, $t4, $t1
	else:
	j loop

exit:
	sw $t1, res
	li $v0, 4
	la $a0, ans
	syscall
	li $v0, 1
	lw $a0, res
	syscall
	li $v0, 10
	syscall