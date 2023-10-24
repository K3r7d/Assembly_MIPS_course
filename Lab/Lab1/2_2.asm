.data
    arr: .space 80
    val: .word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20

.text

main:
    la $t0, val
    la $t1, val
    addi $t1, $t1, 76 

reverse:
    lw $t2, 0($t0)
    lw $t3, 0($t1)

    sw $t3, 0($t0)
    sw $t2, 0($t1)

    addi $t0, $t0, 4
    subi $t1, $t1, 4


    ble $t0, $t1, reverse


la $t0, val
la $t1, val
addi $t1, $t1, 80 

print_loop:
    lw $a0, 0($t0)   
    li $v0, 1         
    syscall

    addi $t0, $t0, 4


    bge $t0, $t1, exit_print


    li $v0, 4        
    la $a0, space_str
    syscall

    j print_loop

exit_print:
    li $v0, 10     
    syscall

.data
    space_str: .asciiz " " 
