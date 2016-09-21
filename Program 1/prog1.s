.data
print: .word 1
multiply: .word 1
subtraction: .word 1


able: .half 16408
golf: .word -287
kilo: .half 42
lima: .byte 92
xray: .word 72
zulu: .byte -17

# Your code goes below this line
pm:	.asciiz "\"Multiplying\" each value by 6:"
pp:	.asciiz "Printing the six values:"
ps: .asciiz "Subtracting all the values from zero: "
newline: .asciiz "\n"
newtab: .asciiz "  "

#s0-able
#s1-golf
#s2-kilo
#s3-lima
#s4-xray
#s5-zulu
#s6-print
#s7-multiply
#t1-subtraction
.text
main:
         # Function prologue -- even main has one
         addiu $sp, $sp, -24        # allocate stack space -- default of 24 here
         sw    $fp, 0($sp)          # save caller's frame pointer
         sw    $ra, 4($sp)          # save return address
         addiu $fp, $sp, 20         # setup main's frame pointer

         la $t0, able
         lh $s0, 0($t0)

         la $t0, golf
         lw $s1, 0($t0)

         la $t0, kilo
         lh $s2, 0($t0)

         la $t0, lima
         lb $s3, 0($t0)

         la $t0, xray
         lw $s4, 0($t0)

         la $t0, zulu
         lb $s5, 0($t0)

         la $t0, print
         lw $s6, 0($t0)

         la $t0, multiply
         lw $s7, 0($t0)


         la $t0, subtraction
         lw $t1, 0($t0)

         addi $t7, $zero,1

         bne $t7, $s6, skipprint
         
         							#printed line
		 la   $a0, pp
		 addi $v0, $zero, 4
		 syscall
		 							#printing \n
		 la   $a0, newline
		 addi $v0, $zero, 4
		 syscall

		 							#printing first
		 add  $a0, $s0, $zero
		 addi $v0, $zero, 1
		 syscall
		 							#printing \n
		 la   $a0, newline
		 addi $v0, $zero, 4
		 syscall
		 							#printing second
		 add  $a0, $s1, $zero
		 addi $v0, $zero, 1
		 syscall
		 							#printing \n
		 la   $a0, newline
		 addi $v0, $zero, 4
		 syscall
		 							#printing third
		 add  $a0, $s2, $zero
		 addi $v0, $zero, 1
		 syscall
		 							#printing \n
		 la   $a0, newline
		 addi $v0, $zero, 4
		 syscall
		 							#printing fourth
		 add  $a0, $s3, $zero
		 addi $v0, $zero, 1
		 syscall
		 							#printing \n
		 la   $a0, newline
		 addi $v0, $zero, 4
		 syscall
		 							#printing fifth
		 add  $a0, $s4, $zero
		 addi $v0, $zero, 1
		 syscall
		 							#printing \n
		 la   $a0, newline
		 addi $v0, $zero, 4
		 syscall
		 							#printing sixth
		 add  $a0, $s5, $zero
		 addi $v0, $zero, 1
		 syscall

		 							#printing \n
		 la   $a0, newline
		 addi $v0, $zero, 4
		 syscall

		 							#printing \n
		 la   $a0, newline
		 addi $v0, $zero, 4
		 syscall

		


	 skipprint:
		 beq $zero, $s7, sysmultiply

		 							#printed line "multiplication"
		 la   $a0, pm
		 addi $v0, $zero, 4
		 syscall

		 							#printing \n
		 la   $a0, newline
		 addi $v0, $zero, 4
		 syscall

		 							#initializing $t2 with zero
		 addi $t2 $zero, 0

		 							#multiplying first
		 add $t2, $s0, $s0
		 add $t2, $t2, $t2
		 add $t2, $t2, $s0
		 add $t2, $t2, $s0

		 							#printing number
		 add $a0, $t2, $zero
		 addi $v0, $zero, 1
		 syscall

		 							#printing tab
		 la $a0, newtab
		 addi $v0, $zero, 4
		 syscall

		 							#initializing $t2 with zero
		 addi $t2 $zero, 0

		 							#multiplying second
		 add $t2, $s1, $s1
		 add $t2, $t2, $t2
		 add $t2, $t2, $s1
		 add $t2, $t2, $s1

		 							#printing number
		 add $a0, $t2, $zero
		 addi $v0, $zero, 1
		 syscall

		 							#printing tab
		 la $a0, newtab
		 addi $v0, $zero, 4
		 syscall

		 							#initializing $t2 with zero
		 addi $t2 $zero, 0

		 							#multiplying third
		 add $t2, $s2, $s2
		 add $t2, $t2, $t2
		 add $t2, $t2, $s2
		 add $t2, $t2, $s2

		 							#printing number
		 add $a0, $t2, $zero
		 addi $v0, $zero, 1
		 syscall

		 							#printing tab
		 la $a0, newtab
		 addi $v0, $zero, 4
		 syscall

		 							#initializing $t2 with zero
		 addi $t2 $zero, 0

		 							#multiplying fourth
		 add $t2, $s3, $s3
		 add $t2, $t2, $t2
		 add $t2, $t2, $s3
		 add $t2, $t2, $s3

		 							#printing number
		 add $a0, $t2, $zero
		 addi $v0, $zero, 1
		 syscall

		 							#printing tab
		 la $a0, newtab
		 addi $v0, $zero, 4
		 syscall


		 							#initializing $t2 with zero
		 addi $t2 $zero, 0

		 							#multiplying fifth
		 add $t2, $s4, $s4
		 add $t2, $t2, $t2
		 add $t2, $t2, $s4
		 add $t2, $t2, $s4

		 							#printing number
		 add $a0, $t2, $zero
		 addi $v0, $zero, 1
		 syscall

									 #printing tab
		 la $a0, newtab
		 addi $v0, $zero, 4
		 syscall

		 							#initializing $t2 with zero
		 addi $t2 $zero, 0

		 							#multiplying sixth
		 add $t2, $s5, $s5
		 add $t2, $t2, $t2
		 add $t2, $t2, $s5
		 add $t2, $t2, $s5

		 							#printing number
		 add $a0, $t2, $zero
		 addi $v0, $zero, 1
		 syscall


		 							#printing \n
		 la $a0, newline
		 addi $v0, $zero, 4
		 syscall

		 							#printing \n
		 la $a0, newline
		 addi $v0, $zero, 4
		 syscall




 sysmultiply:

         bne $t7, $t1, syssubtraction
         
         sub $t4, $zero, $s0
         sub $t4,   $t4, $s1
         sub $t4,   $t4, $s2
         sub $t4,   $t4, $s3
         sub $t4,   $t4, $s4
         sub $t4,   $t4, $s5
           

         							#printed line
		 la $a0, ps
		 addi $v0, $zero, 4
		 syscall

         							#printing number
		 add $a0, $t4, $zero
		 addi $v0, $zero, 1
		 syscall

		 							#printing \n
		 la $a0, newline
		 addi $v0, $zero, 4
		 syscall

		 							#printing \n
		 la $a0, newline
		 addi $v0, $zero, 4
		 syscall




 
 syssubtraction:

     done:    				  # Epilogue for main -- restore stack & frame pointers and return
         lw    $ra, 4($sp)    # get return address from stack
         lw    $fp, 0($sp)    # restore the caller's frame pointer
         addiu $sp, $sp, 24   # restore the caller's stack pointer
         jr    $ra            # return to caller's coda