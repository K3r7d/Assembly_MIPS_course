# Sample MIPS program that writes to a new file. # by Kenneth Vollmar and Pete Sanderson
.data
fout : .asciiz "testout.txt" # filename for output msg1: . asciiz ”Before read : ”
msg2: .asciiz "After read :" 
buffer_write : .asciiz "The quick brown fox jumps over thelazy dog.\n"
buffer_read : .asciiz "−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−\n"
.text
####################################################### # Open (for writing) a file that does not exist
li $v0, 13 # system call for open file
la $a0, fout # output file name
li $a1, 1 # Open for writing (flags are 0: read, 1: write) li $a2, 0 # mode is ignored
syscall # open a file ( file descriptor returned in $v0) move $s6, $v0 # save the file descriptor
####################################################### # Write to file just opened
li $v0, 15 # system call for write to file move $a0, $s6 # file descriptor
la $a1 , buffer_write # address of buffer from which to write l i $a2 , 44 # hardcoded buffer length
syscall # write to file
####################################################### # Close the file
li $v0, 16 # system call for close file
move $a0 , $s6 # f i l e descriptor to close syscall # close file
####################################################### #######################################################
la $a1 , buffer_read # address of buffer read l i $a2 , 44 # hardcoded buffer length
syscall # read file


li $v0,10
syscall