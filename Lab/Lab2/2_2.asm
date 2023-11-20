.globl main
main:

.data

msg1: .asciiz "Enter first integer n1: "
msg2: .asciiz "Enter second integer n2: "
msg3: .asciiz "Invalid input! please try again."
msg4: .asciiz "The greatest common divisor of n1 and n2 is "
msg5: .asciiz "The least common multiple of n1 and n2 is "
nl: .asciiz "\n"

.text

inputLoop:

la $a0, msg1
li $v0, 4
syscall 

li $v0, 5
syscall 
move $s0, $v0

slti $t0, $s0, 256
beq $t0, $zero, invalid

la $a0, msg2
li $v0, 4
syscall 

li $v0, 5
syscall 
move $s1, $v0

slti $t0, $s1, 256
beq $t0, $zero, invalid

beq $s0, $zero, zerovalid

j inputEnd

zerovalid:
beq $s1, $zero, invalid
j inputEnd

invalid:
la $a0, msg3
li $v0, 4
syscall 

la $a0, nl
li $v0, 4
syscall
j inputLoop

inputEnd:

la $a0, msg4
li $v0, 4
syscall 

add $a0, $s0, $zero
add $a1, $s1, $zero
jal gcd 
add $t0, $v0, $zero

move $a0, $t0
li $v0, 1
syscall 

la $a0, nl
li $v0, 4
syscall 

la $a0, msg5
li $v0, 4
syscall 

add $a0, $s0, $zero
add $a1, $s1, $zero
jal lcm 
add $t0, $v0, $zero

move $a0, $t0
li $v0, 1
syscall 

addi $v0, $zero, 10
syscall                 

gcd:
add $t0, $a0, $zero
add $t1, $a1, $zero

beq $t1, $zero, n2zero

add $t2, $t1, $zero
div $t0, $t1
mfhi $a1
move $a0, $t2
j gcd

return:
jr $ra

n2zero:
move $v0, $t0
j return

lcm:
addi $sp, $sp, -4
sw $ra, 0($sp)

add $t6, $a0, $zero
add $t7, $a1, $zero

add $a0, $t6, $zero
add $a1, $t7, $zero
jal gcd 
add $t0, $v0, $zero

mult $t6, $t7
mflo $t4

div $t4, $t0
mflo $v0

lw $ra, 0($sp)
addi $sp, $sp, 4

jr $ra
