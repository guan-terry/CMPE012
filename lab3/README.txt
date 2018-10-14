Terry Guan teguan@ucsc.edu
Lab3: Ripple Adder with Memory
2/7/2018
01H, MIchael Powell

Magic number :0B01111 0234 0x6010

Note: You have to press reset first before you start the program.
Note 2: I helped Samuel witt to start his circut by writing down "pseudocode" for 
him.

In this lab I learned how to use Flip flops to store memory, how to add in MML by 
daisy chaining one bit adders, as well as using MUX to select which desired result 
you want to select. I used MUX to select if the program should subtract or add by 
using the "AddSub" to select addition or subtraction. I found the length of the program 
to be extremely surprising. I did not expect such a simple program to take so much time 
and energy to complete. 

Some of the issues and bugs I had with building this circut was that I was adding 
one to both the inverter as well as six bit full adder. This took surprisingly a 
long time for me to figure out. Using LED's for everything definently made it 
easier for debug as well as figuring out logic. Adding LED's to outputs made it easier 
for me to see what part of the logic was not working as desired and easier for me 
to write it down on paper to debug my program.

When you subtract a larger number to a smaller number the program will switch it from 
a small number to a large number due to bits being "backwards". For example if I 
subtract 2 from 1 it will be 3F because 00 0001 + (11 1101 + 00 0001) = 11 1111 which 
is 3F. When I add a number that won't fit into 3 bits it will not take into account 
the bits that are out of the 6 bit range.



