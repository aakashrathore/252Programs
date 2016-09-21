# Written by- Aakash Singh Rathore
#Final
# Tests non-lowercase characters.
# The lowercase letters should not appear.

.data

lowerCase:
        .half   0
nonLowerCase:
        .half   1

string:
        .asciiz "HELLO"


 
# Your code goes below this line
.data
newLine:          .asciiz "\n"
lowerPrint:       .asciiz"Lower-case letters:"
nonLowerPrint:    .asciiz"Non-lowercase characters printed in reverse:"
countSmall:       .asciiz"Lower-case letters count: "
countNon:	     .asciiz"Non-lowercase characters count: "

.text
main:
        # Function prologue -- even main has one
         addiu $sp, $sp, -24        # allocate stack space -- default of 24 here
         sw    $fp, 0($sp)          # save caller's frame pointer
         sw    $ra, 4($sp)          # save return address
         addiu $fp, $sp, 20         # setup main's frame pointer

         la	$t0,	lowerCase		   # lower Case in $t1
         lh	$t1,	0($t0)

         la	$t0,	nonLowerCase		# Non lower case in $t4
         lh	$t4,	0($t0)

         addi	$s1,	$zero,	1		# $s1 = 1

         bne	$t1,	$s1,	skipLower

         la	$a0,	lowerPrint        # Printing msg1
         addi	$v0,	$zero,	4
         syscall

         la	$a0,	newLine			   # Printing New Line
         addi	$v0,	$zero,	4
         syscall

         la	$s3,	string			    # $s3 holds address to string

         addi	$s2,	$zero,	0		 # $s2 = i = 0
         addi	$s4,	$zero,	0		 # $s4 = countLower = 0

         j 	lowerLoopStart			    # Loop Start

lowerLoopStart:

         add	$t2,	$s3,	$s2		# $t2 = address of string[i]
         lb	   $t3,	0($t2)			# $t3 = elements[i]

         addi	$s2,	$s2,	1		   # i++

         beq	$t3,	$zero,	endLoop
                                    # test if for loop is done

         addi	$t6,	$zero,	96		# $t6 = 96
         slt	$t0,	$t3,	$t6		# if(elements[i]<96)
         beq	$s1,	$t0,	lowerLoopStart

         addi	$t6,	$zero,	122	# $t6 = 123
         slt	$t0,	$t6,	$t3		# if(123<elements[i])
         beq	$s1,	$t0,	lowerLoopStart

         la	   $a0,	($t3)			       # Printing the element
         addi	$v0,	$zero,	11
         syscall

         addi	$s4,	$s4,	1		     # count++
         

         j	lowerLoopStart 

endLoop:

	 la	$a0,	newLine			         # Printing New Line
         addi	$v0,	$zero,	4
         syscall

         la	$a0,	newLine			      # Printing New Line
         addi	$v0,	$zero,	4
         syscall


skipLower:
         

         bne	$t4,	$s1,	skipNonLower#Checking if nonLower letters must be printed or not
         la	$s3,	string			      # $s3 holds address to string
         addi	$s2,	$zero,	0		   # $s2 = i = 0

                                       # going to the end of the program
iLoopStart:
         add	$t2,	$s3,	$s2          # $t2 = address of string[i]
         lb	$t3,	0($t2)			       # $t3 = elements[i]
         beq	$t3,	$zero,	endLoopi	# test if for loop is done
         addi	$s2,	$s2,	1		      # i++
         j    iLoopStart 

endLoopi:

	 la	$a0,	nonLowerPrint            # Printing msg2
         addi	$v0,	$zero,	4
         syscall

         la	$a0,	newLine			      # Printing New Line
         addi	$v0,	$zero,	4
         syscall

         la	$s3,	string			      # $s3 holds address to string
         add	$s3,	$s3,	$s2 		   # $s3 holds address to last element of the string

         addi	$s5,	$zero,	0		   # $s5 = countLower = 0

         addi	$t5,	$zero,	1		   # $t5 = 1

	 j    nonLLoopStart			         # Loop Start

nonLLoopStart:

	 sub	$t2,	$s3,	$t5		         # $t2 = address of string[i]
         lb	$t3,	0($t2)			      # $t3 = elements[i]

         slt	$t0,	$zero,	$s2		# 0 < i

         beq	$t0,	$zero,	endLoop2	# test if for loop is done
         addi	$s2,	$s2,	-1		      # last memory location --
         addi	$t5,	$t5,	1		      # i--

         addi	$t6,	$zero,	96		   # $t6 = 96
         slt	$t0,	$t6,	$t3		    # if(96<elements[i])
         beq	$s1,	$t0,	nonLoopStart2	#goes to loopStart2 to check the second condition
         bne	$s1,	$t0,	nonLoopStart3	#since it's already less than 96, we don't need to check the next condition

nonLoopStart2:

         addi	$t6,	$zero,	122		# $t6 = 123
         slt	$t0,	$t3,	$t6		   # if(elements[i]<123)
         beq	$s1,	$t0,	nonLLoopStart

nonLoopStart3:

         la	$a0,	($t3)			          # Printing the element
         addi	$v0,	$zero,	11
         syscall

         addi	$s5,	$s5,	1 		       # count++
         

         j    nonLLoopStart 
         

endLoop2:
	 la	$a0,	newLine			          # Printing New Line
         addi	$v0,	$zero,	4
         syscall

         la	$a0,	newLine			       # Printing New Line
         addi	$v0,	$zero,	4
         syscall


skipNonLower:

	 bne	$t1,	$s1,	skipLowerCount
		 
	 la	$a0,	countSmall		          # Printing Count Line
         addi	$v0,	$zero,	4
         syscall

         add	$a0,	$s4,	$zero
	 addi	$v0,	$zero,	1
	 syscall

         la	$a0,	newLine			        # Printing New Line
         addi	$v0,	$zero,	4
         syscall

skipLowerCount:
	 bne	$t4,	$s1,	skipNonCount 	     #Checking if nonLower letters must be printed or not

	 la	$a0,	countNon		               # Printing Count Line
         addi	$v0,	$zero,	4
         syscall

         add	$a0,	$s5,	$zero
	 addi	$v0,	$zero,	1
	 syscall

         la	$a0,	newLine			         # Printing New Line
         addi	$v0,	$zero,	4
         syscall


skipNonCount:


done:             # Epilogue for main -- restore stack & frame pointers and return
         lw    $ra, 4($sp)    # get return address from stack
         lw    $fp, 0($sp)    # restore the caller's frame pointer
         addiu $sp, $sp, 24   # restore the caller's stack pointer
         jr    $ra            # return to caller's coda
