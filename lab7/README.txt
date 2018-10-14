Terry Guan
teguan@ucsc.edu
Lab7: Floating Point Calculations
3/17/2018
01H, Michael Powell

I learned how to use IEEE 754 SP and how they work. For the most part I learned it 
through google and youtube videos. I had a lot of trouble with multiplication due to 
the fact that it is very easy to make arithimitic errors with addition. Question 2b.
also intriguied me and I had to do some clever thinking and log rules to simplify it 
enough such that it was easy to compute. I found this lab extremely tedious because 
we wern't allowed to use a calculator but I feel like as long as you understand the 
concept, a calculator would have been very helpful. I dont understand why were weren't 
allowed to use a calculator because we shouldn't be tested for our ability to do 
arithmetic, but should be tested on our ability to understand it conceptually.

1. the largest IEEE 745 SP floating point postitive number should be 0111 1111 1111...
because it would be the closest to 2, but not reaching 2 yet and 2 ^ 256-127. and the 
smallest would be the negative of that which is just 1111 1111 1111.... which is the 
complete opposite with it being negative.

2. 2SC would be faster because you would just take the complement of the negative 
number and add them up isntead of subtracting every number which can lead to arithmetic 
errors and carryovers which take a lot more time.

3. For addition I would first check the sign to see if I have to add or subtract the 
numbers. I would then change exponent bits to decimal and subtract that by 127. Subtract 
the 2 exponenet bits and take the absolute value of that. I would then find the smaller 
Exponent bit and shift the bits by the amount if subtracted to the left. After I would 
add the numbers up and change it back into binary. Multiplication would be a little 
bit more tricky, but very doable. I would first check if the signs are both the same, 
if not the end product would be a negative and positive elsewise. I would then 
add the exponents together in decimal form and multiply the significand by removing the 
trailing 0s in both of the significands and add a 1 in the beginning of both significands.
After that I check how many numbers in both of the significands after removing the 0 and 
before I add the 0 and multiply and add it up. Bot hof the numbers in the significands 
would be added together and add a decimal point to how many digits were added together.
