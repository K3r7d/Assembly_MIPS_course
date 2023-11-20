.data
inputString:    .space 256  # Allocate space for the input string
inputMsg:       .asciiz "Enter a string: "
outputMsg:      .asciiz "\nCharacter, Count:\n"
charCountMsg:   .asciiz "%c, %d\n"
newline: 	.asciiz "\n"
# Initialize the character count array with zeros
charCountArray: .space 128  # One slot for each ASCII character
.text
main:
    # Step 1: Get user input for the string
    li $v0, 4           # Print input message
    la $a0, inputMsg
    syscall

    li $v0, 8           # Read user input
    la $a0, inputString
    li $a1, 256         # Maximum length of the input string
    syscall

    # Step 2: Count the number of each character in the string
    la $a0, inputString  # Load the address of the input string
    la $a1, charCountArray  # Load the address of the character count array
    jal countCharacters  # Jump to the countCharacters subroutine

    # Step 3: Print the characters and their count in ascending order
    la $a0, outputMsg    # Load the address of the output message
    li $v0, 4            # Print the output message
    syscall

    la $a0, charCountArray  # Load the address of the character count array
    li $a1, 128           # Number of characters (ASCII range)
    jal printCharacterCount  # Jump to the printCharacterCount subroutine

    # Exit program
    li $v0, 10            # Exit syscall
    syscall


