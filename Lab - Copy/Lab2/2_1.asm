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
    
# Subroutine to count the number of each character in the string
# Arguments:
#   $a0: Address of the input string
#   $a1: Address of the character count array
countCharacters:
    li $t0, 0            # Initialize counter to 0
    li $t1, 0            # Initialize index to 0

    count_loop:
        lb $t2, 0($a0)    # Load the current character from the string
        beqz $t2, count_done  # If the character is null (end of string), exit loop
        addi $a0, $a0, 1   # Move to the next character in the string

        # Update the character count array
        lb $t3, ($a1)      # Load the current count for the character
        addi $t3, $t3, 1   # Increment the count
        sb $t3, ($a1)      # Store the updated count back in the array

        j count_loop

    count_done:
        jr $ra            # Return from subroutine

# Subroutine to print characters and their count in ascending order
# Arguments:
#   $a0: Address of the output message
#   $a1: Address of the character count array
#   $a2: Number of characters (ASCII range)
printCharacterCount:
    li $t0, 0            # Initialize index to 0

    print_loop:
        beq $t0, $a2, print_done  # If index equals the number of characters, exit loop

        lb $t1, ($a1)      # Load the current count for the character
        bnez $t1, print_char_count  # If count is not zero, print the character and count

        j print_next_char

        print_char_count:
            li $v0, 11       # Print character (syscall)
            li $t2, 0        # Load the current character
            addi $t2, $t0, 32  # Convert index to ASCII code
            sb $t2, 0($a1)    # Store the current character in the array

            li $v0, 11       # Print character (syscall)
            li $t2, ','      # Print a comma
            syscall

            li $v0, 1        # Print integer (syscall)
            move $a0, $t1    # Load the current count
            syscall

            li $v0, 4        # Print newline character (syscall)
            la $a0, newline
            syscall

        print_next_char:
            addi $a1, $a1, 1  # Move to the next character in the array
            addi $t0, $t0, 1  # Increment the index
            j print_loop

    print_done:
        jr $ra            # Return from subroutine


