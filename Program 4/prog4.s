
 
.data
 
numPhrases:
         .word  2
 
whatToPrint:
         .word  2
 
phrases:
         .word  phrase1
         .word  phrase2
        
phrase1:
         .asciiz "abcdefghijklmnopqrstuvwxyz"
phrase2:
         .asciiz "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdeabcdeABCDEXYXYXYZz"
        
# Your code goes below this line

# Done
.data

alphabetCount:
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0
         .word   0


newLine:    
         .asciiz "\n"
colon:
         .asciiz  ":   "


.text
main:
        # Function prologue -- even main has one
         addiu $sp, $sp, -24        # allocate stack space -- default of 24 here
         sw    $fp, 0($sp)          # save caller's frame pointer
         sw    $ra, 4($sp)          # save return address
         addiu $fp, $sp, 20         # setup main's frame pointer

         la    $t0,  whatToPrint    # t4 = whatToPrint
         lw    $t4,  0($t0)

         addi  $t0,  $zero,   0
         beq   $t0,  $t4,     end

         addi  $t0,  $zero,   1
         beq   $t0,  $t4,     startPrintMain

         addi  $t0,  $zero,   2
         beq   $t0,  $t4,     startPrintAndCount

startPrintMain:


         la    $t0,  numPhrases
         lw    $s1,  0($t0)         # s1 has the no. of elements

         addi  $t2,  $zero,   0     # i = 0
         la    $t1,  phrases        # address of beginning of array

startPrint:

         beq   $t2,  $s1,  endPrint # if(i = array.size()), then jump to the end.
         la    $t1,  phrases        # address of beginning of array
         add   $t0,  $zero,   $t2   # want position i
         sll   $t0,  $t0,     2     # multiply position by 4
         add   $t1,  $t1,     $t0   # add offset to beginning of array
         lw    $a0,  0($t1)         # get the address of the ith string
         addi  $v0,  $zero,   4
         syscall

         la    $a0,  newLine        # Printing New Line
         addi  $v0,  $zero,   4
         syscall

         addi  $t2,  $t2,     1     # i++

         j     startPrint

endPrint:
         j     end




startPrintAndCount:
                                    # code here for counting
         la    $t0,  numPhrases
         lw    $s1,  0($t0)         # s1 has the no. of elements

         addi  $t2,  $zero,   0     # i = 0
         la    $t1,  phrases        # address of beginning of array

startPrintCount:                    # outer loop
         beq   $t2,  $s1,  endPrintCount 
                                    # if(i = array.size()), then jump to the end.
         la    $t1,  phrases        # address of beginning of array
         add   $t0,  $zero,   $t2   # want position i
         addi  $t2,  $t2,     1     # numPhrases++
         sll   $t0,  $t0,     2     # multiply position by 4
         add   $t1,  $t1,     $t0   # add offset to beginning of array

         lw    $a0,  0($t1)         # get the address of the ith string
         addi  $v0,  $zero,   4
         syscall

         la    $a0,  newLine        # Printing New Line
         addi  $v0,  $zero,   4
         syscall

         lw    $s6,  0($t1)

         add   $s2,  $zero,   0     # j = 0

innerloopStart:

         add   $t0,  $s6,  $s2  
         lb    $t3,  0($t0)         # $t3 = elements[i]


         beq   $t3,  $zero,   innerLoopEnd

         addi  $t5,  $zero,   65    # A start
         addi  $t6,  $zero,   97    # a start

         addi  $t7,  $zero,   0     # l = 0

arrayUpdateLoop:
         addi  $s3,  $zero,   26    # end of the array
         beq   $s3,  $t7,  countNothing
         beq   $t5,  $t3,  updateSmall
         beq   $t6,  $t3,  updateCapital
         addi  $t7,  $t7,      1    # l++

         addi  $t5,  $t5,      1    # Capital
         addi  $t6,  $t6,      1    # Small

         j     arrayUpdateLoop

updateSmall:
         addi  $s7,  $t6,     -97
         la    $s4,  alphabetCount   # address of beginning of array
         add   $t0,  $zero,   $s7    # want position i
         sll   $t0,  $t0,     2      # multiply position by 4
         add   $s4,  $s4,     $t0    # add offset to beginning of array
         #la    $t0,  $s4
         lw    $s5,  0($s4)   
         addi  $s5,  $s5,     1      #count++
         sw    $s5,  0($s4)
         j     countNothing

updateCapital:
         addi  $s7,  $t5,     -65
         la    $s4,  alphabetCount   # address of beginning of array
         add   $t0,  $zero,   $s7    # want position i
         sll   $t0,  $t0,     2      # multiply position by 4
         add   $s4,  $s4,     $t0    # add offset to beginning of array
         #la    $t0,  $s4
         lw    $s5,  0($s4)   
         addi  $s5,  $s5,     1      #count++
         sw    $s5,  0($s4)
         j     countNothing


countNothing:
         addi  $s2,  $s2,     1      # j++

         j     innerloopStart


innerLoopEnd:

         addi  $s6,  $zero,   0      # i = 0
         addi  $t5,  $zero,   65     # A start
         addi  $t6,  $zero,   97     # a start

arrayOutputLoopStart:

         addi  $t0,  $zero,   26 
         beq   $s6,  $t0,  arrayOutputLoopEnd

         la    $a0,  ($t6)           # Printing the element
         addi  $v0,  $zero,   11
         syscall

         la    $a0,  colon           # Printing New Line
         addi  $v0,  $zero,   4
         syscall

         addi  $t6,  $t6,     1       # if(i = array.size()), then jump to the end.
         la    $s3,  alphabetCount    # address of beginning of array
         add   $t0,  $zero,   $s6     # want position i
         sll   $t0,  $t0,     2       # multiply position by 4
         add   $s3,  $s3,     $t0     # add offset to beginning of array

         lw    $a0,  0($s3)           # get the address of the ith string
         addi  $v0,  $zero,   1
         syscall

         la    $a0,  newLine          # Printing New Line
         addi  $v0,  $zero,   4
         syscall

         addi  $s6,  $s6,     1       # i++

         j     arrayOutputLoopStart

arrayOutputLoopEnd:



         j     startPrintCount

endPrintCount:

                                    
end:
done:             # Epilogue for main -- restore stack & frame pointers and return
         lw    $ra, 4($sp)    # get return address from stack
         lw    $fp, 0($sp)    # restore the caller's frame pointer
         addiu $sp, $sp, 24   # restore the caller's stack pointer
         jr    $ra            # return to caller's coda