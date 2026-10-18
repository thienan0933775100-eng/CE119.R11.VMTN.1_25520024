.data
	msg1 : .asciiz "\nTong du kien (ms): "
	msg2: .asciiz "\nThoi gian do duoc (ms): "
	msg4: .asciiz "\n"
	msg3: .asciiz " "
	soNot: .word 14
	caoDo: .word 64, 64, 65, 67, 67, 65, 64, 62, 60, 60, 62, 64, 64, 62, 62
	doDai: .word  340, 340, 340, 340, 340, 340, 340, 340,340, 340, 340, 340, 510, 170, 680
#nhac cu 40     4
.text
	li $t0, 0
	li $s0, 0
	lw $t1, soNot
	la $s1, caoDo
	la $s2, doDai 
	
	li $v0, 30
	syscall
	add $t6, $zero, $a0
	 
	loop:
	sll $t2, $t0, 2
	add $t2, $t2, $s1
	lw $t3, 0($t2)
	
	sll $t2, $t0, 2
	add $t2, $t2, $s2
	lw $t4, 0($t2)
	add $s0, $s0, $t4
	
	la $a0, msg4
	li $v0, 4
	syscall
	
	add $a0, $zero, $t3
	li $v0, 1
	syscall
	
	la $a0, msg3
	li $v0, 4
	syscall
	
	add $a0, $zero, $t4
	li $v0, 1
	syscall
	
	add $a0, $zero, $t3
	add $a1, $zero, $t4
	addi $a2, $zero, 40
	addi $a3, $zero, 100
	li $v0, 31
	syscall 
	
	add $a0, $zero, $t4
	li $v0, 32
	syscall 
	
	beq $t0, $t1, exit
	addi $t0, $t0, 1
	j loop 
	
	exit:
	li $v0, 30
	syscall
	subu $s4, $a0, $t6
	
	la $a0, msg1
	li $v0, 4
	syscall
	add $a0, $zero, $s0
	li $v0, 1 
	syscall 
	la $a0, msg2 
	li $v0, 4
	syscall
	add $a0, $zero, $s4
	li $v0, 1
	syscall 
	
	li $v0, 10
	syscall 
	
	
	
	
	