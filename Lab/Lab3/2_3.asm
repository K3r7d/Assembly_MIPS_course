.data
    	fin: .asciiz "testin.txt" 
    	buffer: .space 1024

    	format_a: .asciiz "Student medical information\n"
    	format_b: .asciiz "Name:"
    	format_c: .asciiz "ID: "
    	format_d: .asciiz "Weight:"
    	format_e: .asciiz "Height:"
    	format_f: .asciiz "Medical history:"
    	endline: .asciiz "\n"

    	name: .space 32  
    	ID: .space 8  
    	weight: .space 8  
    	height: .space 8  
    	medical_history: .space 64  

.text

main:

    	li $v0, 13  
    	la $a0, fin  
    	li $a1, 0  
    	li $a2, 0  
    	syscall  
    	move $s6, $v0  


    	li $v0, 14 
    	move $a0, $s6  
    	la $a1, buffer  
    	li $a2, 1024
    	syscall  


    	li $a0, 1024
    	li $v0, 9 
    	syscall 
    	move $s0, $v0  
    	move $t0, $s0


    	la $t6, buffer 
    
    	la $t9,ID
	la $t8,name
	la $t7,weight
	la $t3,height
	la $t2,medical_history
	
copy_loop:	#copy string into heap data
    	lb $t5, 0($t6)
    	beqz $t5, end_copy_loop
    	sb $t5, 0($t0)
    	addiu $t0, $t0, 1
    	addiu $t6, $t6, 1
    	j copy_loop
    
end_copy_loop:
	move $t0,$s0
	move $s5,$t9
	li $s7,0
update_loop:
    	lb $t5, 0($t0)
    	beqz $t5, end_update
    	beq $t5,',',next_field
    	sb $t5, 0($s5)
    	addiu $t0, $t0, 1
    	addiu $s5, $s5, 1
    	j update_loop
next_field:
   	addiu $t0, $t0, 1
	addi $s7,$s7,1
	beq $s7,1,update_name
	beq $s7,2,update_weight
	beq $s7,3,update_height
	beq $s7,4,update_medical
update_name:
	move $s5,$t8
	j update_loop
update_weight:
	move $s5,$t7
	j update_loop
update_height:
	move $s5,$t3
	j update_loop
update_medical:
	move $s5,$t2
	j update_loop
end_update:
	
   	li $v0, 4
    	la $a0, format_a
    	syscall
	
   	li $v0, 4
    	la $a0, format_b
    	syscall
    	
   	li $v0, 4
    	la $a0, name
    	syscall

	li $v0, 4
    	la $a0, endline
    	syscall
	
	li $v0, 4
    	la $a0, format_c
    	syscall
    	
    	li $v0, 4
    	la $a0, ID
    	syscall
    	
	li $v0, 4
    	la $a0, endline
    	syscall
    	
	li $v0, 4
    	la $a0, format_d
    	syscall
	
      	li $v0, 4
    	la $a0, weight
    	syscall
    	
	li $v0, 4
    	la $a0, endline
    	syscall
    	
	li $v0, 4
    	la $a0, format_e
    	syscall
    	
    	li $v0, 4
    	la $a0, height
    	syscall

	li $v0, 4
    	la $a0, endline
    	syscall


	li $v0, 4
    	la $a0, format_f
    	syscall

   	li $v0, 4
    	la $a0, medical_history
    	syscall

	li $v0, 4
    	la $a0, endline
    	syscall
        
    	li $v0, 10 
    	syscall 
