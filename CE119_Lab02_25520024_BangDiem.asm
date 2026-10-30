.data
	S: .word 10, 7, 1, 2, 6, 9, 0, 6, 10, 2, 8, 7
	grade_tab: .byte 0, 0, 0, 0, 1, 1, 1, 2, 2, 3, 3
	hist: .word 0, 0, 0, 0
	msg1: .asciiz "min="
	msg2: .asciiz "  max="
	msg3: .asciiz "\ng0="
	msg4: .asciiz "  g1="
	msg5: .asciiz "  g2="
	msg6: .asciiz "  g3="
	msg7: .asciiz "\ng0: "
	msg8: .asciiz "\ng1: "
	msg9: .asciiz "\ng2: "
	msg10: .asciiz "\ng3: "
	msg11: .asciiz "|"
	
.text
main:
    la   $a0, S
    li   $a1, 12
    jal  stats
    
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
    
    la   $a0, S
    li   $a1, 12
    la	 $a2, grade_tab
    la	 $a3, hist
    jal histogram
    
    la $t0, hist
    lw $t1, 0($t0)
    la $a0, msg3
    li $v0, 4
    syscall
    move $a0, $t1
    li $v0, 1
    syscall
    
    lw $t1, 4($t0)
    la $a0, msg4
    li $v0, 4
    syscall
    move $a0, $t1
    li $v0, 1
    syscall
    
    lw $t1, 8($t0)
    la $a0, msg5
    li $v0, 4
    syscall
    move $a0, $t1
    li $v0, 1
    syscall
    
    lw $t1, 12($t0)
    la $a0, msg6
    li $v0, 4
    syscall
    move $a0, $t1
    li $v0, 1
    syscall
    
    jal draw_hist
    li $v0, 10
    syscall
    
  stats:
  	lw $v0, 0($a0) #min
  	lw $v1, 0($a0)
  	loopS:
  	beq $a1, $zero, doneS
  	lw $t0, 0($a0)
  	
  	slt $t1, $v0, $t0
  	bne $t1, $zero, quitMin
  	move $v0, $t0
  	 quitMin:
  	slt $t2, $v1, $t0
  	beq $t2, $zero, quit
  	move $v1, $t0
  	
  	quit:
  	addi $a0, $a0, 4
  	addi $a1, $a1, -1
  	j loopS
  	
  	doneS: 
  	jr $ra 
  
  histogram:
  	loop:
  	beq $a1, $zero, doneH
  	lw $t0, 0($a0)  # lấy s[i]
  	sltiu $t5, $t0, 11  
  	beq $t5, $zero, skip
  	
  	add $t1, $t0, $a2
  	lbu $t2, 0($t1) # lấy grtab[S[i]]
  	
  	sll $t2, $t2, 2 
  	add $t3, $t2, $a3
  	lw $t4, 0($t3)
  	addi $t4, $t4, 1
  	sw $t4, 0($t3)
  	skip:
  	add $a0, $a0, 4
  	addi $a1, $a1, -1
  	j loop
  	doneH:
  	jr $ra
  	
  draw_hist:
  	la $a0, hist
  	move $t0, $a0
  	li $a1, 4
  	
  	loop1:
  	lw $t2, 0($t0)
  	beq $a1, 0, done
  	beq $a1, 4, outg0
  	beq $a1, 3, outg1
  	beq $a1, 2, outg2
  	beq $a1, 1, outg3
  	
  	outg0: 
  	addi $t0, $t0,4 
  	addi $a1, $a1 , -1 
  	la $a0, msg7
  	li $v0, 4
  	syscall
  	j loop2
  	
  	outg1:
  	addi $t0, $t0,4 
  	addi $a1, $a1 , -1
  	la $a0, msg8
  	li $v0, 4
  	syscall
  	j loop2
  	
  	outg2: 
  	addi $t0, $t0,4 
  	addi $a1, $a1 , -1
  	la $a0, msg10
  	li $v0, 4
  	syscall
  	j loop2
  	
  	outg3: 
  	addi $a1, $a1 , -1
  	la $a0, msg10
  	li $v0, 4
  	syscall
  	j loop2
  	
  	loop2: 
  	beq $t2, $zero, loop1
  	la $a0, msg11
  	li $v0, 4
  	syscall
  	addi $t2, $t2, -1
  	j loop2
  	
  	done:
  	jr $ra
  	
  	
  
  	
  	
  	
  	
  	
  	
