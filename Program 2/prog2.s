#Aakash Singh Rathore

.data

backward:
         .byte  1
forward:
         .byte  3

numbers: 
         .word -9999
         .word -999999
         .word  17
         .word -50
         .word   3
         .word -23
         .word -60
         .word  97
         .word -82
         .word  53
         .word  30
         .word -17
         .word 142
         .word  93
         .word  -1
         .word -298374
         .word   5
         .word   1
         .word -999999

# Your code goes below this line
.data
newLine:    .asciiz "\n"
msg1:       .asciiz"The non-negative integers in order:"
msg2:       .asciiz"The non-positive integers in backwards order:"

largeNo:    .word -999999
largeNo1:   .word  999999


.text
main:
        # Function prologue -- even main has one
         addiu $sp, $sp, -24        # allocate stack space -- default of 24 here
         sw    $fp, 0($sp)          # save caller's frame pointer
         sw    $ra, 4($sp)          # save return address
         addiu $fp, $sp, 20         # setup main's frame pointer

                                #forward in t1 
        la $t0, forward         #$t0 has the address of the forward memory location
        lb $t1,0($t0)	          #$s6 now holds the value of forward
                                #adding 1 to s6
        addi $s6, $zero,1 
                                #-999999 in t6
        la  $t0, largeNo
        lw  $t6, 0($t0)
                                #counter
        addi $t7,$zero,0

        la $t0, numbers				  #s2 has the address for 1st element
        lw $s2, 0($t0)

        bne $t1, $s6, skipForward

        addi $s1, $zero, 0      #$s1 = i = 0
        addi $t7, $t7, 1        #counter
                                #printing msg1
        la   $a0, msg1
        addi $v0, $zero, 4
        syscall
                                #printing new line
        la   $a0, newLine
        addi $v0, $zero, 4
        syscall


loopBeginF:

         

                                  #computing address
           add $t1, $s1, $s1
           add $t1, $t1, $t1		  #$t1 = 4*i
           add $t2, $t0, $t1		  #$t2 = address of numbers[i]

           lw  $t4, 0($t2)
           slt $t3, $t4, $zero
           beq $t4, $t6, skipF
           bne $t3, $zero, skipPrintF

                                  #printing number
           lw  $a0, 0($t2)			  
           addi $v0, $zero,1
           syscall

                                  #printing new line
           la   $a0, newLine
           addi $v0, $zero, 4
           syscall
skipPrintF:
                                  #increament
           addi $s1, $s1, 1

           j loopBeginF

skipF:

skipForward:

                                  #backward in t1
          la $t0, backward        #$t0 has the address of the backward memory location
          lb $t1,0($t0)           #$s6 now holds the value of forward

          bne $t1, $s6, skipB

          la $t0, numbers         #s2 has the address for 1st element
          lw $s2, 0($t0)

          beq $t7, $zero, skipP

                                  #printing new line
          la   $a0, newLine
          addi $v0, $zero, 4
          syscall
          skipP:
          addi $s1, $zero, 0      #$s1 = i = 0
                                  #printing msg2
          la   $a0, msg2
          addi $v0, $zero, 4
          syscall
                                  #printing new line
          la   $a0, newLine
          addi $v0, $zero, 4
          syscall
                                  #getting to the address of the last element 

loopBegin:

                                  #computing address
           add $t1, $s1, $s1
           add $t1, $t1, $t1      #$t1 = 4*i
           add $t2, $t0, $t1      #$t2 = address of numbers[i]

                                  #increament
           addi $s1, $s1, 1

           lw  $t4, 0($t2)
                                  #hiting -999999
           beq $t4, $t6, endLoop
           

           j loopBegin

endLoop:        

                                  #addi $s1, $s1, -1  
add  $s3, $zero, $zero

                                  #loop to print the values
loopBeginB:

           slt $t1, $zero, $s1     #$t1 = i> 0
           beq $t1, $zero, skipB

                                  #computing address
           add $t1, $s3, $s3
           add $t1, $t1, $t1      #$t1 = 4*j 
           sub $t5, $t2, $t1      #$t5 = address of numbers[i]

           lw  $t4, 0($t5)
           slt $t3, $zero, $t4
           bne $t3, $zero, skipPrintB

           lw  $t7, 0($t5)
           beq $t7, $t6, skipPrintB

                                  #printing number
           lw  $a0, 0($t5)        
           addi $v0, $zero,1
           syscall

                                  #printing new line
           la   $a0, newLine
           addi $v0, $zero, 4
           syscall
skipPrintB:

                                  #decreament
           addi $s1, $s1, -1
           addi $s3, $s3, 1


           j loopBeginB


skipB:

done:             # Epilogue for main -- restore stack & frame pointers and return
         lw    $ra, 4($sp)    # get return address from stack
         lw    $fp, 0($sp)    # restore the caller's frame pointer
         addiu $sp, $sp, 24   # restore the caller's stack pointer
         jr    $ra            # return to caller's coda