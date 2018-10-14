Terry Guan
teguan@ucsc.edu
Lab5: Decimal to Binary Converter
2/28/18
01H, Michael Powell

Magic Number#: 0123

What worked well in this lab was going to my lab early and starting really early. Posting 
question on piazza also helped me a lot with understanding how masking really works. 
I tried doing long division the first time, but I kept missing bits and that made it 
extremely complicated, so I just diverted into doing masking as that was a lot easier 
than long division. I also diverted to the same guy on Youtube (Quasar Distant episode 
35) to learn how to do bit manipulation as I was extremely confused on how the "and" 
function in mips really worked.

1. When a user inputs a number that is too large to fit in the 32-bit 2SC it will go 
back to the the negative version of that.
For example: if you input 4294967297 it will go to 1 because it will be 
4294969297 - 2^31 and if that doesn't fit it will subtract another 2^31 until it fits 
into the 32-bit 2SC

2.When a user inputs a number that is too smal to fit in the 32-bit 2SC it will keep 
adding up 2^31 until it will fit into the 32-bit 2SC. This is very similar to Question 
number 1 but the opposite happens.

3. mult is multiply and multu is multiply unssigned. multu will overflow and mult will
not overflow. I used mult and not multu.

4. How I would write a BDC would be going through every bit with masking to determine 
which bit is a 1 and multiply it by the correct value and add it all up back together 
into s0. It is basically doing DBC backwards except you would not be able to hold 
the actual binary value in a register because it would be too big to hold.

Pseudocode:
Print: "User input Number: \n"
print the location stored in UserInput
Subtract 45 from the first digit in UserInput
if 45 == 0 store it in a register as 1 and save for later

Loop: (repeat until there are no more digits)
	get the nth number in the user Input
	Subtract that by 48
	Add it to $s0
	Multiply by 10 in $s0
end:
	divide by 10

if the number was negative
multiply $s0 by (-1)

loop: (repeat 32 times)
	And 2 ^ (31-n) with $s0
	print binary number
	divide 2 ^ (31-n) by 2
	loop++
end: