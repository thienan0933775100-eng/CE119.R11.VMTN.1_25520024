.data	
	string: .asciiz "([{([{()}])}])"
	msg1: .asciiz "("
	msg2: .asciiz ", "
	msg3: .asciiz ")"
.text 
main:
	li $sp, 0x7fffeffc
	jal check_brackets
	move $t1, $v0
	move $t2, $v1
	
	la $a0, msg1
	li $v0, 4
	syscall
	
	move $a0, $t1
	li $v0, 1
	syscall
	
	la $a0, msg2
	li $v0, 4
	syscall
	
	move $a0, $t2
	li $v0, 1
	syscall
	
	la $a0, msg3
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
	
check_brackets:
	la $a0, string
	move $t0, $sp
	li $v0, 0
	li $t1, '('
	li $t2, '{'
	li $t3, '['
	li $t5, ')'
	li $t6, '}'
	li $t7, ']'
	loop:
	addi $v0, $v0, 1
	lbu $t4, 0($a0)
	beq $t4, $zero, check3
	beq $t4, $t1, open1
	beq $t4, $t2, open2
	beq $t4, $t3, open3
	
	beq $t4, $t5, close1
	beq $t4, $t6, close2
	beq $t4, $t7, close3
	j next 
	
	open1:
	addi $sp, $sp, -4           
	sw   $t4, 0($sp)
	j next
	open2:
	addi $sp, $sp, -4           
	sw   $t4, 0($sp)
	j next
	open3:
	addi $sp, $sp, -4           
	sw   $t4, 0($sp)
	j next
	
	close1:
	beq $sp, $t0, err2
	lw   $t8, 0($sp)
	addi $sp, $sp, 4
	beq $t8, $t1, next
	addi $v1, $zero, 1
	j exit
	
	close2:
	beq $sp, $t0, err2
	lw   $t8, 0($sp)
	addi $sp, $sp, 4
	beq $t8, $t2, next
	addi $v1, $zero, 1
	j exit
	
	close3:
	beq $sp, $t0, err2
	lw   $t8, 0($sp)
	addi $sp, $sp, 4
	beq $t8, $t3, next
	addi $v1, $zero, 1
	j exit
	
	err2:
	addi $v1, $zero, 2
	j exit
	
	check3:
	lw   $t8, 0($sp)
	addi $sp, $sp, 4
	beq $t8, $t1, err3
	beq $t8, $t2, err3
	beq $t8, $t3, err3
	j done
	err3:
	addi $v1, $zero, 3
	j exit 
	
	
	next: 
	addi $a0, $a0, 1  
	j loop
	
	done: 
	addi $v0, $zero, 0
	addi $v1, $zero, 0
	
	exit:
	move $sp, $t0
	jr $ra
