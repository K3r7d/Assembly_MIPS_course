.data
    prompt_N: .asciiz "Enter the value of N: "
    prompt_M: .asciiz "Enter the value of M: "
    prompt_X: .asciiz "Enter the value of X: "
    sequence: .asciiz "Sequence: "
    comma: .asciiz ", "
.text
    main:
        # Prompt user for N
        li $v0, 4
        la $a0, prompt_N
        syscall
        li $v0, 5
        syscall
        move $s0, $v0 # Store N in $s0

        # Prompt user for M
        li $v0, 4
        la $a0, prompt_M
        syscall
        li $v0, 5
        syscall
        move $s1, $v0 # Store M in $s1

        # Prompt user for X
        li $v0, 4
        la $a0, prompt_X
        syscall
        li $v0, 5
        syscall
        move $s2, $v0 # Store X in $s2

        # Print sequence label
        li $v0, 4
        la $a0, sequence
        syscall

    print_sequence:
        # Initialize sequence
        move $s3, $s0  # $s3 = N (current sequence element)
        li $t0, 0      # $t0 = 0 (iteration counter)

    loop:
        
        # Check if we've printed X-1 elements (since it's 0-based)
        beq $t0, $s2, done
	# Calculate and print the current element
	move $a0, $s3
        li $v0, 1
        syscall

        # Print a comma and a space
        li $v0, 4
        la $a0, comma
        syscall

        # Calculate the next element in the sequence
        mul $s3, $s3, $s1  # $s3 = $s3 * M

        # Increment the iteration counter
        addi $t0, $t0, 1

        # Repeat the loop
        j loop

    done:
        # Exit the program
        li $v0, 10
        syscall
