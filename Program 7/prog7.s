# Aakash Singh Rahore           Program 7       Final Version
# Your code goes below this line
.text
parens:

.data
		
parensPrintBalanced:
				.asciiz	"Balanced!"
parensPrintNotBalanced:
				.asciiz	"Not Balanced!"

parensLevelPrint:
				.asciiz	" -- parens level "
parensNewLine:
				.asciiz	"\n"
parensSpace:
				.asciiz	" "

.text

			# Function prologue
 			addiu	$sp,	$sp,	-24			# allocate stack space -- default of 24 here
 			sw		$a0,	8($sp)				# save the starting address of the string
 			sw		$ra,	4($sp)				# save return address
 			sw		$fp,	0($sp)				# save frame pointer of caller
 			addiu	$fp,	$sp,	20 			# setup frame ponter for squiggle

 			la		$t1,	($a0)				# t1 holds the string now
 			add		$t6,	$zero,	$a1			# t6 hold the recursion level
 			addi	$t2,	$zero,	40			# t2 = (
 			addi	$t5,	$zero,	41			# t2 = )
            
			addi    $v0,    $zero,  41          # initializing it with any random vale. If the function is called twice, the reurn value in $v0, used for recursion isn't changing and 
                                                # hence is causing the function to behave in an untraditional manner when it is called for the second time.
			addi	$t3,	$zero,	1			# i = 1

			add		$t4,	$t1,	$zero

parensLoopStart:
			add		$t4,	$t1,	$t3
			lb		$t0,	0($t4)
			beq		$t0,	$zero,	parensPrint

			beq		$t0,	$t2,	parensRecursion
												# if string[i] == (
			beq		$t0,	$t5,	parensPrint
												# if string[i] == )

            addi    $t3,    $t3,    1           # i++

			j		parensLoopStart             # restart loop
			
parensRecursion:
			addi	$a0,	$t4,	0
			addi	$a1,	$t6,	1

			addiu 	$sp,  	$sp,    -40        # preserving t registers
         	sw    	$t9,  	36($sp)
         	sw    	$t8,  	32($sp)
         	sw    	$t7,  	28($sp)
         	sw    	$t6,  	24($sp)
         	sw    	$t5,  	20($sp)
         	sw    	$t4,  	16($sp)
         	sw    	$t3,  	12($sp)
         	sw    	$t2,  	8($sp)
         	sw    	$t1,  	4($sp)
         	sw    	$t0,  	0($sp)

         	jal      parens

         	lw    	$t9,  	36($sp)
         	lw    	$t8,  	32($sp)
         	lw    	$t7,  	28($sp)
         	lw    	$t6,  	24($sp)
         	lw    	$t5,  	20($sp)
         	lw    	$t4,  	16($sp)
         	lw    	$t3,  	12($sp)
         	lw    	$t2,  	8($sp)
         	lw    	$t1,  	4($sp)
         	lw    	$t0,  	0($sp)
         	addiu 	$sp,  	$sp,     40         # Restoring t registers

            addi    $t8,    $zero,  -1
            beq     $v0,    $t8,    parensEndLoop
                                                # Checking if it is unbalanced  

            add     $t3,    $t3,    $v0
            addi    $t3,    $t3,    1           # i++


         	j		parensDoNothing

parensPrint:

            addi    $a0,    $t1,    0
            addi    $a1,    $t3,    1
            addi    $t7,    $zero,  0

            bne     $t0,    $zero,  parensPrintAsItIs
            addi    $v0,    $zero,  -1         # returning -1 because the loop is unbalanced
            addi    $t7,    $v0,    0
            addi    $a0,    $t1,    0
            addi    $a1,    $t3,    0

parensPrintAsItIs:
			
			addiu 	$sp,  $sp,     -40         # preserving t registers
         	sw    	$t9,  36($sp)
         	sw    	$t8,  32($sp)
         	sw    	$t7,  28($sp)
         	sw    	$t6,  24($sp)
         	sw    	$t5,  20($sp)
         	sw    	$t4,  16($sp)
         	sw    	$t3,  12($sp)
         	sw    	$t2,  8($sp)
         	sw    	$t1,  4($sp)
         	sw    	$t0,  0($sp)

         	jal      printFormula

         	lw    	$t9,  36($sp)
         	lw    	$t8,  32($sp)
         	lw    	$t7,  28($sp)
         	lw    	$t6,  24($sp)
         	lw    	$t5,  20($sp)
         	lw    	$t4,  16($sp)
         	lw    	$t3,  12($sp)
         	lw    	$t2,  8($sp)
         	lw    	$t1,  4($sp)
         	lw    	$t0,  0($sp)
         	addiu 	$sp,  $sp,     40           # Restoring t registers



         	la		$a0,	parensLevelPrint
         	addi  	$v0,  	$zero,	4
         	syscall

         	addi	$a0,	$t6,	0		    # printing recusrison level
         	addi  	$v0,  	$zero,	1
         	syscall

            addi    $t8,    $zero,  -1
            beq     $t7,    $t8,    parensUnbalancedPrint
                                                # Checking if it is unbalanced  

            addi    $t9,    $zero,  1
            bne     $t9,    $t6,    parensNotLevelOne


         	la   	$a0,  	parensSpace          # printing space
         	addi  	$v0,  	$zero,   4
         	syscall

			la   	$a0,  	parensPrintBalanced
         	addi  	$v0,  	$zero,   4
         	syscall

            j       parensNotLevelOne
parensUnbalancedPrint:

            la      $a0,    parensSpace         # Printing Space
            addi    $v0,    $zero,   4
            syscall

                                                # Printing Not Balanced!
            la      $a0,    parensPrintNotBalanced
            addi    $v0,    $zero,   4
            syscall

            la      $a0,    parensNewLine
            addi    $v0,    $zero,  4
            syscall

            addi    $v0     $zero,  -1          # returning -1 because the loop is unbalanced
            j       parensUnbalancedString
            

parensNotLevelOne:

         	la		$a0,	parensNewLine
         	addi  	$v0,  	$zero,	4
         	syscall

            addi    $v0,     $t3,    0          # returning the value to set the offset


         	j		parensEndLoop

parensDoNothing:
			j		parensLoopStart

parensUnbalancedString:

            addi   $v0     $zero,  -1           # returning -1 because the loop is unbalanced

parensEndLoop:

			# Epilogue for parens -- restore stack & frame pointers and return
 			lw		$ra,	4($sp)			# get return address from stack
 			lw		$fp,	0($sp)			# restore frame pointer of caller
 			addiu	$sp,	$sp,	24		# restore stack pointer of caller
 			jr		$ra