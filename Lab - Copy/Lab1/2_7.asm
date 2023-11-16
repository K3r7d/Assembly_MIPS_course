.data
prompt: .asciiz "Enter a number: "

.text

li $v0, 4
la $a0, prompt
syscall


li $v0, 5
syscall
move $t0, $v0


li $t1, 1


factorial_loop:
    beqz $t0, print_result  
    mul $t1, $t1, $t0     
    subi $t0, $t0, 1      
    j factorial_loop


print_result:
li $v0, 1
move $a0, $t1  
syscall


li $v0, 10
syscall
