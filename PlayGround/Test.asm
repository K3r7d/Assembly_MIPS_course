.data
	print: .asciiz "Hello Nigga"
.text
	li $v0 , 4
	la $a0, print
	syscall