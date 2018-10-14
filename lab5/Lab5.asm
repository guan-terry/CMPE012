# Terry Guan
# teguan@ucsc.edu
# Lab5: Decimal to Binary Converter
# 2/28/18
# 01H, MIchael Powell

# Pseudocode:
# Print: "User input Number: \n"
# print the location stored in UserInput
# Subtract 45 from the first digit in UserInput
# if 45 == 0 store it in a register as 1 and save for later
#
# Loop: (repeat until there are no more digits)
# 	get the nth number in the user Input
# 	Subtract that by 48
# 	Add it to $s0
# 	Multiply by 10 in $s0
# end:
# 	divide by 10
# 
# if the number was negative
# multiply $s0 by (-1)
# 
# loop: (repeat 32 times)
# 	And 2 ^ (31-n) with $s0
# 	print binary number
# 	divide 2 ^ (31-n) by 2
# 	loop++
# end:

.data
	newline: .asciiz "\n"
	printZero: .asciiz "0"
	printOne: .asciiz "1"
	printUserInput: .asciiz "User input number: \n"
.text
	main:
		li $v0, 4	#prints out the user input
		la $a0, printUserInput
		syscall 
		
		lw $s1, 0($a1) #store arguement into s1
		
		li $v0, 4	#Print out the location store in s1
		move $a0, $s1
		syscall
		
		lb $s2, 0($s1) #CHECKS FIRST DIGIT ~~~---- OF INPUT STRING	
		
		sub $s4, $s2, 45 #if s4 equals zero then the number is negative
		jal negative
		
		#While loop for getting value
		addi $t2, $zero, 1 #set s2 to one	
		while: 
			lb $s2, 0($s1)
			beq $s2, $zero, exit #if s0 == 0 exit
			addi $s1, $s1, 1 #get the nth number of s1
	
			subi $s2, $s2, 48 #the actual digit is now stored in $s2
			add $s0, $s0, $s2
			mul $s0, $s0, 10#the entire number is now in s3
		
			addi $t2, $t2, 1
			j while
		exit:
			div $s0, $s0, 10
		
		jal negative #if negative multiply s0 by -1
		
		li $v0, 4
		la $a0, newline
		syscall
		
		#subcase for printing the first number
		addi $t2, $zero, 2147483648
		and $s5, $s0, $t2
		jal printBinarySubCase
		
		addi $t2, $zero, 1073741824 #set t2 to 1073741824
		addi $t3, $zero, 0 #set t3 to zero
		while1:
			beq $t3, 31, exit1 #if t3 == 32, goto exit
			and $s5, $s0, $t2  #bitmasking every digit in s0
			
			jal printBinary
			
			div $t2, $t2, 2    #multiply t2 by 2 so we get the next bigtmask
  			addi $t3, $t3, 1   #inriment t3 by 1
  			j while1
		exit1:
		
		#end of main
		li $v0, 10
		syscall

# if the number is negative go to mul1
negative:
	beq $s4, $zero, mul1
	jr $ra
	
#multiplys the number by -1 and add 1 to s1 (go to next iteration)
mul1:
	mul $s0, $s0, -1
	addi $s1, $s1, 1
	jr $ra
	
#the first binary bitmasking
printBinarySubCase:
	addi $t4, $zero, -1
	beq $s5, $zero, print0
	ble $s5, $t4, print1
	
	jr $ra
#print binary
printBinary:
	addi $t4, $zero, 1
	beq $s5, $zero, print0
	bge $s5, $t4, print1
	
	jr $ra
#print 0
print0:
	li $v0, 4
	la $a0, printZero
	syscall
	jr $ra
#print 1
print1:
	li $v0, 4
	la $a0, printOne
	syscall
	jr $ra
