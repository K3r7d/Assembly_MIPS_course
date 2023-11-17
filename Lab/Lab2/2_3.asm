.data
	arr: .space 28
	msg1: .asciiz "Please input an array:"
	msg2: .asciiz "output: "
.text
main:
	la $s1 ,arr
	li $s0, 0
	li $v0, 4
	la $a0, msg1
	syscall
inputloop:
	sll $t1, $s0, 2
	add $t3, $t1, $s1
	
	li $v0, 5
	syscall
	sw $v0, 0($t3)
	
	addi $s0, $s0, 1
	beq $s0, 7, check
	j inputloop
check:
	la $s1, arr
	la $s0, 0
	li $s2, 4
check_loop:
	sll $t1, $s0, 2
	add $t3, $t1, $s1
	addi $s0,$s0,1
	
	lw $t2, 0($t3)
	rem $t4,$t2,$s2
	bnez $t4, handle 
	beq $s0, 8, print
	j check_loop
handle:
	sub $t2, $t2, $t4
	sw $t2, 0($t3)
	j check_loop
print:
	la $s1,arr
	la $s0, 0
printloop:
	sll $t1, $s0, 2
	add $t3, $t1, $s1
	addi $s0,$s0,1
	
	li $v0, 1
	lw $a0, 0($t3)
	syscall
	
	beq $s0,7, exit
	j printloop
exit: 
	li $v0, 10
	syscall
