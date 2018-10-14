# Terry Guan
# teguan@ucsc.edu
# Lab6: Vingere Cipher
# 3/9/18
# 01H, Micahel Powell

#pseudoCode for EncryptChar
# move a0 and a1 to s0 and s1 registers
# if s0 is an UpperCase character then set s2 to 1
# subtract s1 from 65
# add s1 to s0
# if s0 goes over the edge (greater than z or greater than Z)
# then subtract 26 from it

#pseudocode for decryptChar (this is extremely similar to encryptChar)
# move a0 and a1 to s0 and s1 registers
# if s0 is an upperCase character the nset s2 to 1
# subtract s1 from 65
# subtract s0 from s1
# if s0 goes over the edge then subtract 26 from it

#pseudocode for EncryptString
# move a0 to s0 and a1 to s1
# while a0 is not empty 
# 	if s1 is not empty reset s1 to the beginning of the string
# 	load the byte of s0 and s1 into a0 and a1
# 	call EncryptChar with a0 and a1 registers
#	save that to the a2 array
# return a2

#pseudocdoe for DecryptString (This is almost identical to EncryptString)
# move a0 to s0 and a1 to s1
# while a0 is not empty
# 	if s1 is not empty reset s1 to the beginning of the string
#	load the byte of s0 and s1 into a0 and a1
# 	call DecryptChar with a0 and a1 registers
# 	save that into the a2 array
# return a2


.text
# Subroutine EncryptChar
# Encrypts a single character using a single key character.
# input: $a0 = ASCII character to encrypt
# $a1 = key ASCII character
# output: $v0 = Vigenere-encrypted ASCII character
# Side effects: None
# Notes: Plain and cipher will be in alphabet A-Z or a-z
# key will be in A-Z
	EncryptChar:
		#allocate memroy
		addi $sp, $sp, -16
		sw $ra, 12($sp)
		sw $s0, 8($sp)
		sw $s1, 4($sp)
		sw $s2, 0($sp)
		
		move $s0, $a0
		move $s1, $a1
		bgt $s0, 96, __skip 
		addi $s2, $zero, 1 #if s2 is 1 than character is uppercase	
		__skip:
			subi $s1, $s1, 65
			add $s0, $s0, $s1
			#this will fix if it goes after z
			jal __fixOverfull
			move $v0, $s0
		#free memory
		lw $ra, 12($sp)
		lw $s0, 8($sp)
		lw $s1, 4($sp)
		lw $s2, 0($sp)
		addi $sp, $sp, 16
		
		jr $ra
		
	#if s0 goes over z or Z
	__fixOverfull:
		beq $s2, 1, __upperCase
		bgt $s0, 122, __subtract
		jr $ra
		
	__subtract:
		subi $s0, $s0, 26
		jr $ra
		
	__upperCase:
		bgt $s0, 90, __subtract
		jr $ra
		
# Subroutine EncryptString
# Encrypts a null-terminated string of length 30 or less,
# using a keystring.
# input: $a0 = Address of plaintext string
# $a1 = Address of key string
# $a2 = Address to store ciphertext string
# output: None
# Side effects: String at $a2 will be changed to the
# Vigenere-encrypted ciphertext.
# $a0, $a1, and $a2 may be altered			
	EncryptString:
		addi $sp, $sp, -24
		sw $s2, 20($sp)
		sw $ra, 16($sp)
		sw $s0, 12($sp)
		sw $s1, 8($sp)
		sw $s3, 4($sp)
		sw $s4, 0($sp)
		
		move $s0, $a0
		move $s1, $a1
		#goes through the entire array of chars and 
		#calls encryptchar on each character
		__a0NotEmpty:
			lb $a0, 0($s0)
			lb $a1, 0($s1)
			beq $a1, $zero, __resetKey
			beq $a0, $zero, __a0Empty
			jal __legalChar
			jal EncryptChar
			move $a0, $v0
			addi $s1, $s1, 1
			addi $s2, $s2, -1
		#if not legal char then it will skip to this label which adds 1 to s0 or
		#it jumps to the next iteration of the plaintext string
		__notLegalChar:
			sb $a0, 0($a2)
			addi $a2, $a2, 1
			addi $s0, $s0, 1
			j __a0NotEmpty
		__a0Empty:
		
		lw $s2, 20($sp)
		lw $ra, 16($sp)
		lw $s0, 12($sp)
		lw $s1, 8($sp)
		lw $s3, 4($sp)
		lw $s4, 0($sp)
		
		addi $sp, $sp, 24
		jr $ra
		
		__resetKey:
			add $s1, $s1, $s2
			addi $s2, $zero, 0
			j __a0NotEmpty
		
		__legalChar:
			#if s4 < 65, not legal && s4 > 122, not legal
			#if s4 > 90 && s4 < 97, not legal
			blt $a0, 65, __notLegalChar
			bgt $a0, 122, __notLegalChar
			bgt $a0, 90, __betweenCaps
			jr $ra
			__betweenCaps:
				blt $a0, 97, __notLegalChar
				jr $ra
				
# Subroutine DecryptString
# Decrypts a null-terminated string of length 30 or less,
# using a keystring.
# input: $a0 = Address of ciphertext string
# $a1 = Address of key string
# $a2 = Address to store plaintext string
# output: None
# Side effects: String at $a2 will be changed to the
# Vigenere-decrypted plaintext
# $a0, $a1, and $a2 may be altered
	DecryptString:
		addi $sp, $sp, -20
		sw $ra, 16($sp)
		sw $s0, 12($sp)
		sw $s1, 8($sp)
		sw $s3, 4($sp)
		sw $s4, 0($sp)
		
		move $s0, $a0
		move $s1, $a1
		#goes through the entire array of chars and 
		#calls encryptchar on each character
		__cipherHasText:
			lb $a0, 0($s0)
			lb $a1, 0($s1)
			beq $a1, $zero, __resetCipher
			beq $a0, $zero, __cipherEmpty
			jal __skipChar
			jal DecryptChar
			move $a0, $v0
			addi $s1, $s1, 1
			addi $s2, $s2, -1
		#if not legal char then it will skip to this label which adds 1 to s0 or
		#it jumps to the next iteration of the plaintext string
		__notLegalCharChipher:
			sb $a0, 0($a2)
			addi $a2, $a2, 1
			addi $s0, $s0, 1
			j __cipherHasText
		__cipherEmpty:
		
		lw $ra, 16($sp)
		lw $s0, 12($sp)
		lw $s1, 8($sp)
		lw $s3, 4($sp)
		lw $s4, 0($sp)
		
		addi $sp, $sp, 20
		jr $ra
		
		__resetCipher:
			add $s1, $s1, $s2
			addi $s2, $zero, 0
			j __cipherHasText
		
		__skipChar:
			#if s4 < 65, not legal && s4 > 122, not legal
			#if s4 > 90 && s4 < 97, not legal
			blt $a0, 65, __notLegalCharChipher
			bgt $a0, 122, __notLegalCharChipher
			bgt $a0, 90, __betweenCapsLetter
			jr $ra
			__betweenCapsLetter:
				blt $a0, 97, __notLegalCharChipher
				jr $ra
		
# Subroutine DecryptChar
# Decrypts a single character using a single key character.
# input: $a0 = ASCII character to decrypt
# $a1 = key ASCII character
# output: $v0 = Vigenere-decrypted ASCII character
# Side effects: None
# Notes: Plain and cipher will be in alphabet A-Z or a-z
# key will be in A-Z	
	DecryptChar:
		addi $sp, $sp, -16
		sw $ra, 12($sp)
		sw $s0, 8($sp)
		sw $s1, 4($sp)
		sw $s2, 0($sp)
		
		move $s0, $a0
		move $s1, $a1
		bgt $s0, 96, __skip1
		addi $s2, $zero, 1 #if s2 is 1 than character is uppercase	
	__skip1:
		subi $s1, $s1, 65
		sub $s0, $s0, $s1
		
		jal __fixUnderFull
		move $v0, $s0
		lw $ra, 12($sp)
		lw $s0, 8($sp)
		lw $s1, 4($sp)
		lw $s2, 0($sp)
		addi $sp, $sp, 16
		
		jr $ra
		
	#if s0 goes over z or Z
	__fixUnderFull:
		beq $s2, 1, __upperCase1
		blt $s0, 97, __add
		jr $ra
		
	__add:
		addi $s0, $s0, 26
		jr $ra
		
	__upperCase1:
		blt $s0, 65, __add
		jr $ra
		
