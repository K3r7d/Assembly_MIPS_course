#-------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------#
#-------------------------------------------Menu--------------------------------------------#
#-------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------#
.data
	    cmt:	.asciiz "--------------------------------------------------------------------"
	    Menu:	.asciiz"                1.Play                      2.Exit"
	choose: 	.asciiz "Choose: "
	Welcome:	.asciiz "-------------------WELCOME TO BATTLESHIP GAME-----------------------"
	newline: 	.asciiz"\n"	
  invalid_input:	.asciiz "Invalid input, please input again\n"
		
	
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
	beq $t0, 2, end_
	
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
	InputRule:		.asciiz "Welcome to BATTLESHIP GAME.\nNow, each player have to input their boat by the syntax below\n\"Row_Boat Column_Boat Row_stern Column_stern\"\nExample:\"1 4 2 4\""
	player1_input:		.asciiz"Player 1 Turn\n"
	player2_input:		.asciiz"Player 2 Turn\n"
	EnterToContinue: 	.asciiz "Enter to Continue...\n"
	NumberofShipsPrompt: 	.asciiz "You will have 3 2x1, 2 3x1 and 1 4x1 ships\n"
	Ship4x1: 		.asciiz"4x1 Ship: "
	Ship3x1: 		.asciiz"3x1 Ship: "
	Ship2x1: 		.asciiz"2x1 Ship: "
	
	tempString: 		.space 9	
	INVALID_SHIP: 		.asciiz "\nInvalid ship input, please input again.\n"
	
	#____MAP____#
	MAP: 			.word 0:49
	MAP2: 			.word 0:49
	#NOTE
	#s0 is use for MAP
	#t8: Size of Ship
	#t9: Player flag
	#Gameloop
	GameStart_msg: 		.asciiz "-----------------------------GAME-START-----------------------------\n"
	P1_win: 		.asciiz "Player 1 win!!!\n"
	P2_win: 		.asciiz "Player 2 win!!!\n"
	P1_attack: 		.asciiz "Player 1 turn to attack\n"
	P2_attack: 		.asciiz "Player 2 turn to attack\n"
	HIT_MSG: 		.asciiz "  HIT!\n"
	attack_choose_msg: 	.asciiz "Please input a point(x,y) to attack:"
	attack_buffer: 		.space 10
	error_point: 		.asciiz "Invalid point, please input again\n"
	ROUND: 			.asciiz "ROUND "
	fout: 			.asciiz "move.txt"
	ENDGAME: 		.asciiz"THE GAME IS END!"
	PLAYAGAIN:		.asciiz "Do you want to play again: 1.Yes 2.No \n"
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
	
	j Player1_Input # JUMP TO PLAYER INPUT
	
#-------------------------------#

#-------------------------------#

#--------------MAP--------------#




#element access
#ADRESS = base +(Row * n + Column)* 4
#SHIP UPDATE MAP FUCNTION
Ship_Update:
	#load player map
	beq $t9,1, load_player1
	la $s0, MAP2
	j split
	load_player1:
	la $s0, MAP
	split:
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
	subi $a0, $a0, 1
	lb $t5, 0($a0)
	bne $t5, 32, error
	subi $a0, $a0, 2
	lb $t5, 0($a0)
	bne $t5, 32, error
	subi $a0, $a0, 2
	lb $t5, 0($a0)
	bne $t5, 32, error
	
	
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
	
	beqz $t5, check_13
	bge $t2, $t4,sub_
	sub $s1, $t4, $t2
	j sc_cont1
	sub_:
	sub $s1,$t2,$t4
	sc_cont1:
	addi $s1, $s1, 1
	bne $s1, $t8, error
	j initial_i_j
	
	check_13:
	bge $t1, $t3,sub__
	sub $s1, $t3, $t1
	j sc_cont2
	sub__:
	sub $s1,$t1,$t3
	sc_cont2:
	addi $s1, $s1, 1
	bne $s1, $t8, error
	
	#update to map
	initial_i_j:
	mul $s3, $t1, 7
	add $s3, $s3, $t2
	mul $s3, $s3, 4
	
	
	add $s5, $s3, $s0
	
	beq $t5, 1 ,Column
Row:
	beqz $t8, end_update_map
	lw $s6, 0($s5)
	bnez $s6, error
	addi $s6, $zero, 1
	sw $s6, 0($s5)
	slt $s2, $t1, $t3
	beqz $s2, Row_Left
	Row_Right:
	addi $s5, $s5, 28
	j Continue_Row_Loop
	Row_Left:
	subi $s5, $s5, 28
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
	addi $s5, $s5, 4
	j Continue_Column_Loop
	Column_down:
	subi $s5, $s5, 4
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
	li $t9, 1	#set the player
	
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
	
	
	
Player2_Input:
	li $t9, 2
	
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
	
	j Start
#-------------------------------#

#-------------------------------#

#------------GAMELOOP-----------#

check_win:
	beq $t9,1, load_player_1
	la $s0, MAP2
	j initial_check
	load_player_1:
	la $s0, MAP
	
	initial_check:
	li $t1, 49
	li $s1, 0
	check_loop:
	beqz $t1, win_
	sll $t2, $s1, 2
	add $t3, $t2, $s0
	
	lw $t4, 0($t3)
	beq $t4, 1, end_check_win
	
	addi $s1, $s1, 1
	subi $t1, $t1, 1
	j check_loop
	end_check_win:
	jr $ra
	
	win_:
	beq $t9, 2, Player1_win
	j Player2_win


attack: 
	lb $t1, 0($a0) 
	subi $t1, $t1, '0'
	add $a0, $a0, 2
	lb $t2, 0($a0)
	subi $t2, $t2, '0'
	
	ble $t1, -1, error_atk
	ble $t2, -1, error_atk
	bge $t1, 7, error_atk
	bge $t2, 7, error_atk
	
	beq $t9,1, load_player_2
	la $s0, MAP
	j access__
	load_player_2:
	la $s0, MAP2
	
	access__:
	mul $s3, $t1, 7
	add $s3, $s3, $t2
	mul $s3, $s3, 4
	
	add $s3, $s3, $s0
	
	lw $s5, 0($s3)
	beq $s5, 0, end_atk
	subi $s5, $s5, 1
	sw $s5, 0($s3)
	#HIT
	li $v0, 4
	la $a0, HIT_MSG
	syscall
	
	end_atk:
	li $v0, 4
	la $a0, newline
	syscall
	jr $ra
	
	error_atk:
	li $v0, 4
	la $a0, error_point
	syscall
	
	subi $ra ,$ra, 24
	jr $ra

Start:
	li $v0, 4
	la $a0, GameStart_msg
	syscall
	li $s7, 1
Gameloop:
	#player 1 turn
	li $v0, 4
	la $a0, cmt
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, ROUND
	syscall
	
	li $v0, 1
	move $a0, $s7
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall

	li $t9, 1
	
	li $v0, 4
	la $a0, P1_attack
	syscall
	
	li $v0, 4
	la $a0, attack_choose_msg
	syscall
	
	li $v0, 8
	la $a0, attack_buffer
	li $a1, 4
	syscall
	
	jal attack 
	#check win p1
	
	li $t9, 2
	jal check_win
	
	#player 2 turn
	li $v0, 4
	la $a0, P2_attack
	syscall
	
	li $v0, 4
	la $a0, attack_choose_msg
	syscall
	
	li $v0, 8
	la $a0, attack_buffer
	li $a1, 4
	syscall
	
	jal attack 
	
	#check win p2
	li $t9, 1
	jal check_win
	
	addi $s7, $s7, 1
	j Gameloop

Player1_win:
	li $v0, 4
	la $a0, newline
	syscall
	li $v0, 4
	la $a0, P1_win
	syscall
	j exit
	
Player2_win: 
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, P2_win
	syscall
	j exit

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
	li $v0, 4
	la $a0, ENDGAME
	syscall
	
	li $v0, 4
	la $a0, PLAYAGAIN
	syscall
	
	li $v0, 5
	syscall
	beq $v0, 1, Player1_Input
end_:
	
	li $v0, 10
	syscall
#-------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------#



