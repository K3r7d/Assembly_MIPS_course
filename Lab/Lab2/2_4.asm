.data
	arr: .space 60
	index: .space 60
	input: .asciiz"Please input an array: "
	msg1: .asciiz "Second largest value is: "
	msg2: .asciiz "found in index "
	comma:.asciiz ", "
.text
	li $v0, 4
	la $a0, input
	syscall
	
	la $s0, arr
	li $s1, 0
	inputloop:
	sll $t1, $s1, 2
	add $t3, $s0, $t1
	addi $s1, $s1, 1
	li $v0, 5
	syscall
	sw $v0, 0($t3)
	
	beq, $s1, 15, largest
	j inputloop
largest:
	la $s0, arr	#load arr
	li $s1, 0	#i = 0
	li $t0, -1000	#max
	loop1:
	sll $t1, $s1, 2
	add $t3, $s0, $t1 #address
	addi $s1, $s1, 1
	
	lw $t2, 0($t3)
	bge $t2, $t0 max
	beq $s1, 15, second_largest
	j loop1
max:
	addi $t0, $t2, 0
	j loop1
	
second_largest:
	la $s0, arr	#load arr
	li $s1, 0	#i = 0
	li $s4, -1001	#second max
	loop2:
	sll $t1, $s1, 2
	add $t3, $s0, $t1 #address
	addi $s1, $s1, 1
	
	lw $t2, 0($t3)
	
	slt $t4 ,$t2, $t0	#cur<max
	sgt $t5 ,$t2, $s4
	and $s2, $t5, $t4
	
	bne $s2, 0, max2
	beq $s1, 15, count
	j loop2
max2:
	addi $t1, $t2, 0
	j loop2
count:
	la $s3, index
	la $s0, arr	#load arr
	li $s1, 0	#i = 0
	li $s2, 0	#j = 0
	loop3:
	sll $t1, $s1, 2
	add $t3, $s0, $t1 #address
	addi $s1, $s1, 1
	
	lw $t2, 0($t3)
	beq $t2, $s4, index_store
	
	beq $s1, 15, print

index_store:
	sll $t4, $s2,2
	add $t5, $t4, $s3
	sw $s1, 0($t5)
	addi $s2,$s2,1
	j loop3
print:
	li $v0, 4
	la $a0, msg1
	syscall
	li $v0, 1
	move $a0, $s4
	syscall
	li $v0, 4
	la $a0, msg2
	syscall
	
	la $s0, index	#load arr
	li $s1, 0	#i = 0
	
	printloop:
	sll $t1, $s1, 2
	add $t3, $s0, $t1 #address
	addi $s1, $s1, 1
	
	li $v0, 1
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, comma
	syscall
	
	beq $s1, $s2,exit
exit: 
	li $v0, 10
	syscall






	