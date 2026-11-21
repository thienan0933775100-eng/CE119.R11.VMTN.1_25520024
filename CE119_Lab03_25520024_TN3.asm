.data
	soN: .word 20
	msg1: .asciiz "F("
	msg2: .asciiz ") = "
.text
.globl main
main:
	la $a0, msg1
	li $v0, 4
	syscall
	
	la $t0, soN
	lw $a0, 0($t0)
	li $v0, 1
	syscall
	
	la $a0, msg2
	li $v0, 4
	syscall
	
	lw $a0, 0($t0)
	jal fi_rec
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	
fi_rec:
	addi $sp, $sp, -12
	sw $ra,8($sp)
	sw $a0, 4($sp)
	sw $s0, 0($sp)
	slti $t1, $a0, 2
	bne $t1, $zero, cond
	
	
	addi $a0, $a0, -1
	jal fi_rec
	move $s0, $v0
	lw $a0, 4($sp)
	addi $a0, $a0, -2
	jal fi_rec
	add $v0, $v0, $s0
	
	
done:
	lw $s0, 0($sp)
	lw $a0, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	
cond:
	move $v0, $a0
	j done
	
fib_iter:
        move  $v0, $zero        # a = F(0)
        li    $t0, 1            # b = F(1)
        move  $t1, $zero        # i = 0
fi_loop:
        slt   $t2, $t1, $a0
        beq   $t2, $zero, fi_done
        addu  $t3, $v0, $t0     # a + b
        move  $v0, $t0
        move  $t0, $t3
        addiu $t1, $t1, 1
        j     fi_loop
fi_done:
        jr    $ra


	
	
