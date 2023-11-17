.data
	arr: .space 60
	input: .asciiz"Please input an array: "
	msg1: .asciiz "Second largest value is: "
	msg2: .asciiz "found in index "
	comma:.asciiz ", "
	err:.asciiz "There is no second largest value."
	newline: .asciiz "\n"
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
	beq $s1, 15, second_largest
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
	beq $s1, 15, print
	j loop2
max2:
	addi $s4, $t2, 0
	beq $s1, 15, print
	j loop2

print:
	li $v0, 4
	la $a0, msg1
	syscall
	beq $s4, -1001,noSecondlargest
	j cont
noSecondlargest:
	li $v0, 4
	la $a0, err
	syscall
	j exit
cont:
	li $v0, 1
	move $a0, $s4
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, msg2
	syscall
	
	
	
	la $s0, arr	#load arr
	li $s1, 0	#i = 0
	li $t4, 0
	printloop:
	sll $t1, $s1, 2
	add $t3, $s0, $t1 #address

	
	lw $t2 ,0($t3)
	
	beq $t2, $s4, cont1
	addi $s1, $s1, 1
	beq $s0, 15, exit
	j printloop
cont1:
	beqz $t4 cont2
	
	li $v0, 4
	la $a0, comma
	syscall

cont2:
	addi $t4,$t4,1
	li $v0, 1
	move $a0, $s1
	syscall
	addi $s1, $s1, 1
	beq $s0, 15, exit
	j printloop
exit: 
	li $v0, 10
	syscall






	
