# Sample MIPS program that writes to a new file. # by Kenneth Vollmar and Pete Sanderson
.data
fout : .asciiz "testout.txt" 
fin : .asciiz "testin.txt"
buffer_write : .space 1024
buffer_read : .space 1024
.text 
li $v0, 13
la $a0, fin
li $a1, 0
li $a2, 0
syscall
move $s6, $v0

li $v0, 14
la $a1, buffer_read
li $a2, 1024
syscall
move $s1, $v0

li $v0, 16
move $a0, $s6
syscall

li $v0,10
syscall
