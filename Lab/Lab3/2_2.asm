.data
	msg:.asciiz "Please input your ID (7 digits): "
	
	one: .float 1.0
	three:.float 3.0
	four: .float 4.0
	five: .float 5.0
.text
	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	li $s1, 10
	
	div $s0, $s1
	mfhi $t7
	mflo $s0
	
	div $s0, $s1
	mfhi $t6
	mflo $s0
	
	div $s0, $s1
	mfhi $t5
	mflo $s0
	
	div $s0, $s1
	mfhi $t4
	mflo $s0
	
	div $s0, $s1
	mfhi $t3
	mflo $s0
	
	div $s0, $s1
	mfhi $t2
	mflo $s0
	
	div $s0, $s1
	mfhi $t1
	mflo $s0
	#e
	mtc1 $t7, $f7
	cvt.s.w $f7, $f7
	#v
	mtc1 $t6, $f6
	cvt.s.w $f6, $f6
	#u
	mtc1 $t5, $f5
	cvt.s.w $f5, $f5
	
	#d
	mtc1 $t4, $f4
	cvt.s.w $f4, $f4
	
	#c
	mtc1 $t3, $f3
	cvt.s.w $f3, $f3
	
	#b
	mtc1 $t2, $f2
	cvt.s.w $f2, $f2
	
	#a
	mtc1 $t1, $f1
	cvt.s.w $f1, $f1
	
	mul.s $f7, $f7, $f7 #e^2
	
	l.s $f8, one
	div.s $f16, $f8, $f7 #1/e^2
	
	sub.s $f9, $f5, $f6
	mul.s $f9, $f9, $f4 #d(u-v)

	l.s $f8, three
	
	mul.s $f10, $f5, $f5 #u^2
	mul.s $f10, $f5, $f10 #u^3
	mul.s $f11, $f6, $f6
	mul.s $f11, $f11, $f6#v^3
	sub.s $f11, $f10, $f11
	div.s $f13, $f11, $f8 
	mul.s $f13, $f13, $f3 #c(u^3-v^3)/3
	
	l.s $f8, four
	
	mul.s $f10, $f5, $f5
	mul.s $f10, $f10, $f10
	mul.s $f11, $f6, $f6
	mul.s $f11, $f11, $f11
	sub.s $f11, $f10, $f11
	div.s $f11, $f11, $f8
	mul.s $f14, $f11, $f2
	
	l.s $f8, five
	
	mul.s $f10, $f5, $f5
	mul.s $f10, $f10, $f10
	mul.s $f10, $f10, $f5
	mul.s $f11, $f6, $f6
	mul.s $f11, $f11, $f11
	mul.s $f11, $f11, $f6
	sub.s $f11, $f10, $f11
	div.s $f11, $f11, $f8
	mul.s $f15, $f11, $f1
	
	add.s $f12, $f13, $f14
	add.s $f12, $f12, $f15
	add.s $f12, $f12, $f9
	mul.s $f12, $f12, $f16
	
	li $v0, 2
	syscall
	
	
	
	li $v0, 10
	syscall
	
	
	
	
