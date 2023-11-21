#-------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------#
#-------------------------------------------Menu--------------------------------------------#
#-------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------#
.data
	    cmt:.asciiz "--------------------------------------------------------------------"
	    Menu:.asciiz"                1.Play                      2.Exit"
	choose: .asciiz "Choose: "
	Welcome:.asciiz "-------------------WELCOME TO BATTLESHIP GAME-----------------------"
	newline: .asciiz"\n"
	
  invalid_input:.asciiz "Invalid input, please input again\n"
	
	
	
	
	
	
.text

menu__:
	li $v0, 4
	la $a0, cmt
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, Welcome
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, cmt
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
Choose___:	
	li $v0, 4
	la $a0, Menu
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, choose
	syscall
	
	li $v0, 5
	syscall 
	move $t0, $v0
	
	beq $t0, 1, play
	beq $t0, 2, exit
	
	li $v0, 4
	la $a0, invalid_input
	syscall
	
	j Choose___
#-------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------#





#-------------------------------------------------------------------------------------------#
#-----------------------------------------PLAY----------------------------------------------#
#-------------------------------------------------------------------------------------------#
play:


.data
	InputRule:.asciiz "Welcome to BATTLESHIP GAME.\nNow, each player have to input their boat by the syntax below\n\"Row_Boat Column_Boat Row_stern Column_stern\"\nExample:\"1 4 2 4\""
	
	player1_input:.asciiz"Player 1 Turn\n"
	player2_input:.asciiz"Player 2 Turn\n"
	
	EnterToContinue: .asciiz "Enter to Continue...\n"
	NumberofShipsPrompt: .asciiz "You will have 3 2x1, 2 3x1 and 1 4x1 ships\n"
	
	Ship4x1: .asciiz"4x1 Ship: "
	Ship3x1: .asciiz"3x1 Ship: "
	Ship2x1: .asciiz"2x1 Ship: "
	
	tempString: .space 9
	
	INVALID_SHIP: .asciiz "\nInvalid ship input, please input again.\n"
	
	#____MAP____#
	MAP: .word 0:49
	
	
	
	#NOTE
	#s0 is use for MAP
	#t8: Size of Ship
	
.text

#-------------------------------#

#-------------------------------#

#--------------RULE-------------#
	li $v0, 4
	la $a0, cmt
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0 ,4
	la $a0, InputRule
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	
	
	li $v0, 4
	la $a0, NumberofShipsPrompt
	syscall
	
	li $v0, 4
	la $a0, EnterToContinue
	syscall
	
	li $v0, 4
	la $a0, cmt
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 8
	syscall
	
#-------------------------------#

#-------------------------------#

#--------------MAP--------------#
la $s0, MAP	#j

j Player1_Input


#element access
#ADRESS = base +(Row * n + Column)* 4

Ship_Update:
	#split string
	lb $t1, 0($a0) 
	subi $t1, $t1, '0'
	add $a0, $a0, 2
	lb $t2, 0($a0)
	subi $t2, $t2, '0'
	add $a0, $a0, 2
	lb $t3, 0($a0)
	subi $t3, $t3, '0' 
	add $a0, $a0, 2
	lb $t4, 0($a0) 
	subi $t4, $t4, '0'
	

	
	#handle error
	ble $t1, -1, error
	ble $t2, -1, error
	ble $t3, -1, error
	ble $t4, -1, error
	
	bge $t1, 7, error
	bge $t2, 7, error
	bge $t3, 7, error
	bge $t4, 7, error
	
	seq $t5, $t1, $t3
	seq $t6, $t2, $t4
	xor $t7, $t5, $t6
	beqz $t7, error
	
	#size check
	
	beqz $t5, check_24
	bge $t1, $t3,sub__
	sub $s1, $t3, $t1
	sub__:
	sub $s1,$t1,$t3
	bne $s1, $t8, error
	j initial_i_j
	
	check_24:
	bge $t2, $t4,sub__
	sub $s1, $t4, $t2
	sub__:
	sub $s1,$t2,$t4
	bne $s1, $t8, error
	
	#update to map
	initial_i_j:
	mul $s3, $t1, 7
	add $s3, $s3, $t2
	mul $s3, $s3, 4
	
	
	add $s5, $s3, $s0
	
	beq $t5, 1,Column
Row:#  T2 = T4
	beqz $t8, end_update_map
	lw $s6, 0($s5)
	bnez $s6, error
	addi $s6, $zero, 1
	sw $s6, 0($s5)
	slt $s2, $t1, $t3
	beqz $s2, Row_Left
	Row_Right:
	addi $s5, $s5, 4
	j Continue_Row_Loop
	Row_Left:
	subi $s5, $s5, 4
	Continue_Row_Loop:
	subi $t8, $t8, 1
	j Row
Column:
	beqz $t8, end_update_map
	lw $s6, 0($s5)
	bnez $s6, error
	addi $s6, $zero, 1
	sw $s6,0($s5)
	slt $s2, $t2, $t4
	beqz $s2, Column_up
	Column_up:
	addi $s5, $s5, 28
	j Continue_Column_Loop
	Column_down:
	subi $s5, $s5, 28
	Continue_Column_Loop:
	subi $t8, $t8, 1
	j Column
	
	
	end_update_map:
	jr $ra
	
error:
	li $v0, 4
	la $a0, INVALID_SHIP	
	syscall
	
	subi $ra, $ra, 44
	jr $ra
#-------------------------------#

#-------------------------------#

#-------------INPUT-------------#
	
Player1_Input:
	li $a3, 1	#set the player
	
	li $v0, 4
	la $a0, player1_input
	syscall	
	
	#4x1
	li $v0, 4
	la $a0, Ship4x1
	syscall
	
	li $v0, 8
	la $a0, tempString
	li $a1, 9
	syscall
	move $t1, $v0
	li $t8, 4
	jal Ship_Update
	
	#3x1
	li $v0, 4
	la $a0, Ship3x1
	syscall
	
	li $v0, 8
	la $a0, tempString
	li $a1, 9
	syscall
	move $t1, $v0
	li $t8, 3
	jal Ship_Update
	

	li $v0, 3
	la $a0, Ship3x1
	syscall
	
	li $v0, 8
	la $a0, tempString
	li $a1, 9
	syscall
	move $t1, $v0
	li $t8, 3
	jal Ship_Update
	
	#2x1
	li $v0, 4
	la $a0, Ship2x1
	syscall
	
	li $v0, 8
	la $a0, tempString
	li $a1, 9
	syscall
	move $t1, $v0
	li $t8, 2
	jal Ship_Update
	
	li $v0, 4
	la $a0, Ship2x1
	syscall
	
	li $v0, 8
	la $a0, tempString
	li $a1, 9
	syscall
	move $t1, $v0
	li $t8, 2
	jal Ship_Update
	
	li $v0, 4
	la $a0, Ship2x1
	syscall
	
	li $v0, 8
	la $a0, tempString
	li $a1, 9
	syscall
	move $t1, $v0
	li $t8, 2
	jal Ship_Update
	
	
	
Player2_Input:
	li $a3, 0
	
	li $v0, 4
	la $a0, player2_input
	syscall
	
	#4x1
	li $v0, 4
	la $a0, Ship4x1
	syscall
	
	li $v0, 8
	la $a0, tempString
	li $a1, 9
	syscall
	move $t1, $v0
	li $t8, 4
	jal Ship_Update
	
	#3x1
	li $v0, 4
	la $a0, Ship3x1
	syscall
	
	li $v0, 8
	la $a0, tempString
	li $a1, 9
	syscall
	move $t1, $v0
	li $t8, 3
	jal Ship_Update
	

	li $v0, 4
	la $a0, Ship3x1
	syscall
	
	li $v0, 8
	la $a0, tempString
	li $a1, 9
	syscall
	move $t1, $v0
	li $t8, 3
	jal Ship_Update
	
	#2x1
	li $v0, 4
	la $a0, Ship2x1
	syscall
	
	li $v0, 8
	la $a0, tempString
	li $a1, 9
	syscall
	move $t1, $v0
	li $t8, 2
	jal Ship_Update
	
	li $v0, 4
	la $a0, Ship2x1
	syscall
	
	li $v0, 8
	la $a0, tempString
	li $a1, 9
	syscall
	move $t1, $v0
	li $t8, 2
	jal Ship_Update
	
	li $v0, 4
	la $a0, Ship2x1
	syscall
	
	li $v0, 8
	la $a0, tempString
	li $a1, 9
	syscall
	move $t1, $v0
	li $t8, 2
	jal Ship_Update
	
	
#-------------------------------#

#-------------------------------#

#------------GAMELOOP-----------#
Gameloop:



#-------------------------------#

#-------------------------------#

#-------------------------------#



#-------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------#



#-------------------------------------------------------------------------------------------#
#-----------------------------------------EXIT----------------------------------------------#
#-------------------------------------------------------------------------------------------#
exit:
	li $v0, 10
	syscall
#-------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------#



