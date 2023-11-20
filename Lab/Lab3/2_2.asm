.data
	.msg: "Please input your ID: "
	
	a: .float
	b: .float
	c: .float
	d: .float
	e: .float
	u: .float
	v: .float
	
.text
	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 5
	syscall
	move $s0, $a0
	
	