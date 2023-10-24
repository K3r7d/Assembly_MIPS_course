.data
	a: .asciiz "Please input a : "
	b: .asciiz "Please input b : "
	operation: .asciiz "Please choose operation: 1.Add 2.Sub 3.Mul 4.Divi \n"
	result: .asciiz "Result: "
.text
	li $v0 , 4
	la $a0 ,a	
	syscall
	
	li $v0 , 5
	syscall
	move $t0 , $v0
	
	li $v0, 4
	la $a0 , b
	syscall
	
	li $v0 , 5
	syscall
	move $t1 , $v0
	
	li $v0, 4
	la $a0 , operation
	syscall
	
	li $v0 , 5
	syscall
	move $t2 , $v0
	
	beq $t2, 1, addition
        beq $t2, 2, subtraction
        beq $t2, 3, multiplication
        beq $t2, 4, division
        j exit
        
addition:
	add $t3, $t0, $t1
	j print
subtraction:
	sub $t3, $t0, $t1
	j print
multiplication:
	mul $t3, $t0, $t1
	j print
division:
	div $t0,$t1
	mflo $t3
print:
  
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

exit:
    li $v0, 10
    syscall
	
	
	