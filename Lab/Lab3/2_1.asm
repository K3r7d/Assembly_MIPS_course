.data
	msg1: .asciiz "Choose shape to calculate the surface area: 1.Rectangle Box   2. Cube   3.Cylinder   4.pyramid   5.prism   6.sphere\n"
	Input_R: .asciiz "Input R: "
	Input_H: .asciiz "Input H: "
	Input_A: .asciiz "Input a: "
	Input_B: .asciiz "input b: "
	Input_C: .asciiz "input c: "
	Input_S: .asciiz "input slant height: "
	
	ans: .a	sciiz "Surface Area: "
	newline: .asciiz "\n"
	two: .float 2.0
	four: .float 4.0
	PI: .float 3.141592
.text
	#input
	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	beq $s0, 1, Rectangle
	beq $s0, 2, Cube
	beq $s0, 3, Cylinder
	beq $s0, 4, pyramid
	beq $s0, 5, prism
	beq $s0, 6, sphere
	
Rectangle:
	
	li $v0, 4
	la $a0, Input_A
	syscall
	
	li $v0, 6
	syscall
	mov.s $f1, $f0
	
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, Input_B
	syscall
	
	li $v0, 6
	syscall
	mov.s $f2, $f0
	
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, Input_C
	syscall
	
	li $v0, 6
	syscall
	mov.s $f3, $f0
	
	li $v0, 4
	la $a0, newline
	syscall
	
	mul.s $f4,$f1,$f2
	mul.s $f5,$f1,$f3
	mul.s $f6,$f2,$f3
	add.s $f4, $f4, $f4
	add.s $f6, $f6, $f6
	add.s $f5, $f5, $f5
	
	add.s $f7, $f4, $f5
	add.s $f7, $f7, $f6
	
	mov.s $f12, $f7
	j answer
Cube:
	li $v0, 4
	la $a0, Input_A
	syscall
	
	li $v0, 6
	syscall
	mov.s $f1, $f0
	
	li $v0, 4
	la $a0, newline
	
	add.s $f2, $f1, $f1
	add.s $f3, $f2, $f2
	add.s $f3, $f3, $f2
	
	mov.s $f12, $f3
	j answer
Cylinder:
	li $v0, 4
	la $a0, Input_R
	syscall
	
	li $v0, 6
	syscall
	mov.s $f1, $f0
	
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, Input_H
	syscall
	
	li $v0, 6
	syscall
	mov.s $f2, $f0
	
	li $v0, 4
	la $a0, newline
	syscall
	
	l.s $f3 ,PI
	l.s $f4, two
	
	mul.s $f5, $f3, $f4
	mul.s $f5, $f5, $f1
	mul.s $f5, $f5, $f2
	
	mov.s $f12, $f5
	j answer
	
	
pyramid:
	li $v0, 4
	la $a0, Input_A
	syscall
	
	li $v0, 6
	syscall
	mov.s $f1, $f0
	
	li $v0, 4
	la $a0, Input_H
	syscall
	
	li $v0, 6
	syscall
	mov.s $f2, $f0

	
	l.s $f4, two
	div.s $f3,$f1,$f1	#f3 = f1/2
	mul.s $f5,$f1,$f1	#f5 = base A
	mul.s $f6,$f2,$f2	#f6 = h^2
	mul.s $f7, $f3, $f3	#f7 = f3^2
	add.s $f8, $f7, $f6
	sqrt.s $f8, $f8
	mul.s $f9, $f8, $f3
	l.s $f4, four
	mul.s $f9,$f9,$f4
	mul.s $f9, $f9, $f5
	mov.s $f12, $f9
	j answer
	
	
prism:
	li $v0, 4
	la $a0, Input_A
	syscall
	
	li $v0, 6
	syscall
	mov.s $f1, $f0
	
	li $v0, 4
	la $a0, Input_B
	syscall
	
	li $v0, 6
	syscall
	mov.s $f2, $f0
	
	li $v0, 4
	la $a0, Input_C
	syscall
	
	li $v0, 6
	syscall
	mov.s $f3, $f0
	
	li $v0, 4
	la $a0, Input_H
	syscall
	
	li $v0, 6
	syscall
	mov.s $f11, $f0
	
	add.s $f4, $f1, $f2
	add.s $f4, $f4, $f3
	l.s $f5, two
	div.s $f6, $f4, $f5	#p
	sub.s $f7, $f6, $f1
	sub.s $f8, $f6, $f2
	sub.s $f9, $f6, $f3
	mul.s $f10, $f6,$f7
	mul.s $f10, $f10, $f8
	mul.s $f10, $f10, $f9
	sqrt.s $f10, $f10
	mul.s $f10, $f10, $f5 #base area * 2 = f10
	mul.s $f4, $f4,$f11
	add.s $f12, $f4,$f10
	
	j answer
	
sphere:
	li $v0, 4
	la $a0, Input_R
	syscall
	
	li $v0, 6
	syscall
	mov.s $f1, $f0
	
	l.s $f2, four
	l.s $f3, PI
	mul.s $f1, $f1, $f1
	mul.s $f1, $f2, $f1
	mul.s $f1, $f3, $f1
	
	mov.s $f12, $f1
	j answer
answer:
	li $v0, 4
	la $a0, ans
	syscall
	
	li $v0,2 
	syscall
exit:
	li $v0, 10
	syscall