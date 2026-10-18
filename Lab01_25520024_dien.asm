# $s1 lưu giá trị nhập vào  /  $a0 lưu địa chỉ mảng /  $v0 dùng để gọi dịch vụ hoặc lưu giá trị kết quả trả về
# $2 lưu địa chỉ mảng "khung"      / $3 lưu địa chỉ mảng "donGia"    / $s4 lưu kết quả  / $s5 lưu phần dư sau mỗi bậc 
#t1-t7 dùng làm các biến phụ 

.data
	msg1: .asciiz "Nhap so kWh (0..9999):  "
	msg2: .asciiz  "\nGia tri khong hop le, nhap lai."
	msg3: .asciiz "\nTien dien: "
	msg4: .asciiz " dong\n"
	donGia: .word  0, 1680, 1740, 2030, 2580, 2930, 3080
	khung: .word  1, 51, 101, 201, 301, 401, 10000

.text
main:
	loop1:
	la $a0, msg1
	li $v0, 4
	syscall 
	li $v0, 5
	syscall 
	add $s1, $zero, $v0
	li $t2, 9999
	bgtu $s1, $t2, return
	j exit1
	return: 
	la $a0, msg2
	li $v0, 4
	syscall
	j loop1
	
	exit1: 
	li $t1, 1
	la $s2, khung
	la $s3, donGia
	li $s4, 0
	add $s5, $zero, $s1
	
	loop2: 
	
	sll $t2, $t1, 2
	add $t3, $t2, $s2
	lw $t4, 0($t3)
	blt $s1, $t4, exit2
	
	lw $t5, -4($t3)
	sub $t6, $t4, $t5
	
	add $t3, $t2, $s3
	lw $t7, 0($t3)
	
	mul $t3, $t6, $t7
	add $s4, $s4, $t3 
	sub $s5, $s5, $t6
	
	addi $t1, $t1, 1
	j loop2
 
	exit2:
	sll $t1, $t1, 2
	add $t2, $t1, $s3
	lw $t3, 0($t2)
	mul $t2, $t3, $s5
	add $s4, $s4, $t2
	
	la $a0, msg3
	li $v0, 4
	syscall
	add $a0, $zero, $s4
	li $v0, 1
	syscall
	la $a0, msg4
	li $v0, 4
	syscall
	li $v0, 10
	syscall
	
