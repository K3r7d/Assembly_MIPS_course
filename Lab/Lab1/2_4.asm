.data
    prompt_a:   .asciiz "Enter the value of a: "
    prompt_b:   .asciiz "Enter the value of b: "
    prompt_c:   .asciiz "Enter the value of c: "
    prompt_d:   .asciiz "Enter the value of d: "
    result_F:   .asciiz "Result of F: "
    result_G:   .asciiz "Result of G: "
    one:        .float 1.0
    two:        .float 2.0
    three:      .float 3.0

.text
    # Read input values for a, b, c, and d
    li $v0, 4
    la $a0, prompt_a
    syscall
    li $v0, 6
    syscall
    mtc1 $v0, $f0 # Store a in $f0

    li $v0, 4
    la $a0, prompt_b
    syscall
    li $v0, 6
    syscall
    mtc1 $v0, $f1 # Store b in $f1

    li $v0, 4
    la $a0, prompt_c
    syscall
    li $v0, 6
    syscall
    mtc1 $v0, $f2 # Store c in $f2

    li $v0, 4
    la $a0, prompt_d
    syscall
    li $v0, 6
    syscall
    mtc1 $v0, $f3 # Store d in $f3

    # Load constants from data section
    lwc1 $f10, one
    lwc1 $f11, two
    lwc1 $f12, three

    # Calculate F
    add.s $f4, $f0, $f1      # a + b
    sub.s $f5, $f2, $f3      # c - d
    mul.s $f6, $f4, $f5      # (a + b) * (c - d)
    mul.s $f7, $f0, $f0      # a^2
    div.s $f8, $f6, $f7      # ((a + b) * (c - d)) / (a^2)

    # Calculate G
    add.s $f12, $f0, $f10    # a + 1
    add.s $f13, $f1, $f11    # b + 2
    sub.s $f14, $f2, $f12    # c - 3
    mul.s $f15, $f12, $f13   # (a + 1) * (b + 2)
    mul.s $f16, $f14, $f15       # ((a + 1) * (b + 2) * (c - 3))
    sub.s $f17, $f2, $f0     # c - a
    div.s $f18, $f16, $f17   # ((a + 1) * (b + 2) * (c - 3)) / (c - a)

    # Print the results
    li $v0, 4
    la $a0, result_F
    syscall
    li $v0, 2
    mov.s $f12, $f8
    syscall

    li $v0, 4
    la $a0, result_G
    syscall
    li $v0, 2
    mov.s $f12, $f18
    syscall

    # Exit
    li $v0, 10
    syscall
