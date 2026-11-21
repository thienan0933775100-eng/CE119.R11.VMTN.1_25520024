.data 
	msg1: .asciiz "lenh jal ghi dia chi vao ra"
.text 
.globl main
main:
	la $a0, msg1
	jal reverse_words
	la $a0, msg1
	li $v0, 4
	syscall
	li $v0,10
	syscall
	
reverse_words:

	addi $sp, $sp, -24
	sw $ra, 20($sp)         
	sw $s0, 16($sp)         
	sw $s1, 12($sp)         
	sw $s2, 8($sp)
	move $s2, $a0
	li $s1, 1
	jal  strlen
	move $s0, $v0
	jal rev_range
	
	
	loop:
	lb $t0, 0($s2)
	beq $t0, $zero, done
	li $t3, ' '
	beq $t0, $t3, skip
	
	li $s1, 0
	jal strlen
	move $s0, $v0
	jal rev_range
	addi $s0, $s0, 1
	add $s2, $s2, $s0
	j loop
	
	skip:
	addi $s2, $s2, 1
	j loop
	done:	
	lw $ra, 20($sp)         
	lw $s0, 16($sp)         
	lw $s1, 12($sp)         
	lw $s2, 8($sp)          
	addi $sp, $sp, 24
	jr $ra
	
	
strlen:
	li $t1,-1
	move $t2, $s2
	
	beq $s1, $zero, Chalen
	loopStr:
	lb $t0, 0($t2)
	beq $t0, $zero, quitStr 
	addi $t1, $t1,1
	addi $t2, $t2, 1
	j loopStr
	quitStr:
	move $v0, $t1
	jr $ra
	Chalen:
	li $t3, ' '
	loopCha:
	lb $t0, 0($t2)
	beq $t0, $t3, quitRange
	beq $t0, $zero,quitRange
	addi $t1, $t1,1
	addi $t2, $t2, 1
	j loopCha
	quitRange:
	move $v0, $t1
	jr $ra
	
rev_range:
	move $t0, $s0
	move $t2, $s2
	add $t1, $t0, $t2
	
	loopRa:
	lb $t4, 0($t1)  # phai qua trai 
	lb $t3, 0($t2)	
	slt $t5, $t2, $t1 
	beq $t5, $zero, quitRa
	sb $t3, 0($t1)
	sb $t4, 0($t2)
	addi $t2, $t2, 1
	addi $t1, $t1, -1
	j loopRa
	quitRa:
	jr $ra 
	
	

	
	
	
	
