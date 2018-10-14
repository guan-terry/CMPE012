Terry Guan
teguan@ucsc.edu
Lab6: Vignere Cipher
3/9/2018
01H, Michael Powell

This lab was surprisingly harder than I thought. I believe that I started this lab pretty 
early, but it took me a lot longer than I thought. I believe that having prior C experience 
really helped me through this lab because C operates a lot like mips in terms of strings, 
in which they are both just an array of Strings. What gave me a lot of trouble was that I 
tried to make my own string and return a pointer of the array in $a1. This gave me a lot 
of trouble, and took me 3 hours to debug until I went to my Lab and my TA told me that 
$a1 was already given to me as a string. This was by far the most fustrating thing about 
this lab. EncryptChar and DecryptChar was a lot easier than I thought. This only took me 
about 2 hours and since they are both very similar in code, I just copied and pasted 
EncryptChar to DecryptChar and changed addition to subtraction and it mostly worked out.

1. Additional test code that I wrote was combining both z to a, adding random white 
spaces, caps, and random punctuation. For the most part many of these test cases went 
well because I thought through my code very thorougly before I ran any of the test 
code.

2. When I attempt to encrypt a keystring that has illegal characters, it works out fine.
It just adds the value of the encrypted string with the key in ascii. This is because 
I did not try to block any illegal characters. For Strings, it would just take the first 
character in the string because of the nature of how my code works.

3. Recursion would not be much different from how I did the EncryptString. I would simply 
recursivly decrease the array of A until A is empty and call EncryptChar on the string.
It is very similar to how I would do it with a while loop, but now I would have to use 
recursion to add up my values.

4. I would probably save them into the stack or even save them in another register and 
pull it out of the register or stack to overwrite them later on. I believe that saving 
it into another register and pulling it out of the register would be best fit for having 
"mulitiple" $a registers.

