.data
input: .asciiz "input a and b: "
gcd: .asciiz "GCD: "
lcm: .asciiz "LCM: "
.text
.globl main
main:

    li $v0, 4
    la $a0, input
    syscall
    li $v0, 5
    syscall
    move $s0, $v0   # Store the original value of 'a' in $s0
    li $v0, 5
    syscall
    move $s1, $v0   # Store the original value of 'b' in $s1
    
    jal GCD # call function GCD

    li $v0, 4
    la $a0, gcd
    syscall

    li $v0, 1
    move $a0, $v0  # Load the GCD result for printing
    syscall

    li $v0, 4
    la $a0, lcm
    syscall

    # Calculate LCM (Least Common Multiple) using the formula: LCM(a, b) = (a * b) / GCD(a, b)
    mul $a0, $s0, $s1  # $a0 = a * b
    div $a0, $a0, $v0  # $a0 = (a * b) / GCD(a, b)
    mflo $a0           # Load the result (LCM) into $a0

    li $v0, 1
    syscall

    li $v0, 10  # Exit program
    syscall

GCD:
    beq $a1, $zero, return_a
    move $a0, $a1
    div $s0, $a1
    mfhi $a1
    jal GCD
    j exit_gcd

return_a:
    move $v0, $a0
    j exit_gcd

exit_gcd:
    jr $ra
