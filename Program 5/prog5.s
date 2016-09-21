# Your code goes below this line

.text
squiggle:
			# Function prologue
 			addiu	$sp,	$sp,	-24			# allocate stack space -- default of 24 here
 			sw		$a0,	8($sp)				# save the starting address of the string
 			sw		$ra,	4($sp)				# save return address
 			sw		$fp,	0($sp)				# save frame pointer of caller
 			addiu	$fp,	$sp,	20 			# setup frame ponter for squiggle

			addiu	$sp,	$sp,	-80		   # 80 bytes on stack for string

         lb    $t0,  0($a0)
         beq   $zero,   $t0,  emptyStringSquiggle
                                       #checking for empty string

 			addi	$t3,	$sp,	0				# $t3 now holds the start of the stack
 			addi	$t1,	$sp,	0				# $t1 to store the start of the stack

 			addi	$t4,	$zero,	0			# i=0
 			addi	$t7,	$a0,	0				# storing string in t7

squiggleLoopEven:
			
			add	$t5,	$t7,	   $t4
			lb		$t0,	0($t5)
			beq	$t0,	$zero,	squiggleLoopEvenEnd
													# checks for null
			sb		$t0,	0($t3)				# stored the alphabet in the stack
			addi	$t4,	$t4,	   1			# i++
			addi	$t3,	$t3,	   1			# j++

			add	$t5,	$t7,	   $t4
			lb		$t0,	0($t5)				# checking next element for null
			beq	$t0,	$zero,	squiggleLoopEvenEnd
			addi	$t0,	$zero,	32			# adding space in the next element
			sb		$t0,	0($t3)
			addi	$t4,	$t4,	   1			# i++
			addi	$t3,	$t3,	   1			# j++

			j		squiggleLoopEven

squiggleLoopEvenEnd:

         addiu $sp,  $sp,     -40      # preserving t registers
         sw    $t9,  36($sp)
         sw    $t8,  32($sp)
         sw    $t7,  28($sp)
         sw    $t6,  24($sp)
         sw    $t5,  20($sp)
         sw    $t4,  16($sp)
         sw    $t3,  12($sp)
         sw    $t2,  8($sp)
         sw    $t1,  4($sp)
         sw    $t0,  0($sp)

         addi  $a0,  $t1,     0         # parameters for printline
         addi  $a1,  $t3,     -1        # subtracting one here to remove the extra space created here while checking for null

         jal      printLine

         lw    $t9,  36($sp)
         lw    $t8,  32($sp)
         lw    $t7,  28($sp)
         lw    $t6,  24($sp)
         lw    $t5,  20($sp)
         lw    $t4,  16($sp)
         lw    $t3,  12($sp)
         lw    $t2,  8($sp)
         lw    $t1,  4($sp)
         lw    $t0,  0($sp)
         addiu $sp,  $sp,     40       # Restoring t registers


			addi	$t3,	$t1,	   0			# $t3 now holds the start of the stack

 			addi	$t4,	$zero,	0			# i=0


squiggleLoopOdd:

			add	$t5,	$t7,	   $t4
			lb		$t0,	0($t5)				# checking next element for null

			beq	$t0,	$zero,	squiggleLoopOddEnd
			addi	$t0,	$zero,	32			# adding space in the even element element
			sb		$t0,	0($t3)

			addi	$t4,	$t4,	   1			# i++
			addi	$t3,	$t3,	   1			# j++

			add	$t5,	$t7,	   $t4
			lb		$t0,	0($t5)
			beq	$t0,	$zero,	squiggleLoopOddEnd
													# checks for null
			sb		$t0,	0($t3)				# stored the alphabet in the stack
			addi	$t4,	$t4,	   1			# i++
			addi	$t3,	$t3,	   1			# j++

			j		squiggleLoopOdd

squiggleLoopOddEnd:

         addiu $sp,  $sp,     -40      # preserving t registers
         sw    $t9,  36($sp)
         sw    $t8,  32($sp)
         sw    $t7,  28($sp)
         sw    $t6,  24($sp)
         sw    $t5,  20($sp)
         sw    $t4,  16($sp)
         sw    $t3,  12($sp)
         sw    $t2,  8($sp)
         sw    $t1,  4($sp)
         sw    $t0,  0($sp)

         addi  $a0,  $t1,     0         # parameters for printline
         addi  $a1,  $t3,     -1        # subtracting one here to remove the extra space created here while checking for null

         jal      printLine

         lw    $t9,  36($sp)
         lw    $t8,  32($sp)
         lw    $t7,  28($sp)
         lw    $t6,  24($sp)
         lw    $t5,  20($sp)
         lw    $t4,  16($sp)
         lw    $t3,  12($sp)
         lw    $t2,  8($sp)
         lw    $t1,  4($sp)
         lw    $t0,  0($sp)
         addiu $sp,  $sp,     40        # Restoring t registers


			addi	$t4,	$zero,	0			 # i=0

			addi	$t2,	$zero,	0			 # count = 0

squiggleCountStart:
			add	$t5,	$t7,	   $t4
			lb		$t0,	0($t5)				# checking next element for null

			beq	$t0,	$zero,	squiggleCountEnd
			addi	$t2,	$t2,	   1			# count++
			addi	$t4,	$t4,	   1			# i=0

			j		squiggleCountStart
squiggleCountEnd:

 			addi	$v0,	$t2,	  0

         j    endSquiggle

emptyStringSquiggle:
         addi  $v0,  $zero,   0

endSquiggle:

			# Epilogue for squiggle -- restore stack & frame pointers and return
			addiu	$sp,	$sp,	  80			# Remove the extra bytes used by the string

 			#lw		$a0,	8($sp)
 			lw		$ra,	4($sp)				# get return address from stack
 			lw		$fp,	0($sp)				# restore frame pointer of caller
 			addiu	$sp,	$sp,	24				# restore stack pointer of caller
 			jr		$ra