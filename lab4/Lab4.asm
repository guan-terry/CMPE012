# Terry Guan
# teguan@ucsc.edu
# Lab4: DEADBEEF in Mips
# 2/16/18
# 01H, Micahel Powell

.data
	prompt: .asciiz "Enter a number N: "
	newLine: .asciiz "\n"
	dead: .asciiz "DEAD\n"
	beef: .asciiz "BEEF\n"
	deadbeef: .asciiz "DEADBEEF\n"
.text
	main:
	#prompt user to enter a number N
	li $v0, 4
	la $a0, prompt
	syscall
	
	# pause for user input
	li $v0, 5
	syscall	
	
	# save the user input
	move $t0, $v0
	
	#set i = 0
	addi $t1, $zero, 1
	#set 4 to $t2
	addi $t2, $zero, 4
	#set 9 to $t3
	addi $t3, $zero, 9
	while:
		bgt $t1, $t0, exit # if t1 > t0 exit
		
		div $t1, $t2 #divide t1/4
		mfhi $s0 # get the remainder of t1/4 and set it to s0
		div $t1, $t3 #divde t1/9
		mfhi $s1 #get the remainder of t1/9 and set it to s1
		
		add $t4, $s0, $s1
		
		beq $t4, $zero, modByFourAndNine
		beq $s0, $zero, modByFour # if s0 is zero meaning if there is no remainder than call modByFour
		beq $s1, $zero, modByNine #t1%9 == 0 than call mod by nine
		
		jal printNumber # prints the number
		
		addi $t1, $t1, 1 # t1++
		
		j while # jump back to t1
	exit:
	
	# End of program
	li $v0, 10
	syscall

# prints the number if it does not mod by 4 or mod by 9
printNumber: 
	li $v0, 1
	add $a0, $t1, $zero
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	jr $ra
	
# prints if mod by four and nine
modByFourAndNine:
	li $v0, 4
	la $a0, deadbeef
	syscall
	
	jr $ra
	
# prints if mod by four
modByFour:
	li $v0 ,4 
	la $a0, dead
	syscall
	
	jr $ra
	
#prints if mod by nine
modByNine:
	li $v0 ,4
	la $a0, beef
	syscall
	
	jr $ra
	
