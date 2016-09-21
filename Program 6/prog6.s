# Name: Aakash Singh Rathore.       Program 6 MIPS 
# Your code goes below this line

.text
average:
		
		#Function Prologue

		addiu	$sp,	$sp,	-36			# allocate stack space -- default of 24 here
		sw		$fp,	0($sp)				# save frame pointer of caller
		sw		$ra,	4($sp)				# save return address
 		# save parameters values $a0-#a3 on the stack
 		sw		$a0,	8($sp)				
 		sw		$a1,	12($sp)
 		sw		$a2,	16($sp)
 		sw		$a3,	20($sp)

 		addiu	$fp,	$sp,	33 			# setup frame ponter for average

 		lw		$t1,	24($sp)				# 5th parameter
 		lw		$t2,	28($sp)				# 6th parameter
 		lw		$t3,	32($sp)				# 7th parameter


        mtc1    $a1,    $f3
        cvt.s.w $f3,    $f3
        mtc1    $a2,    $f5
        cvt.s.w $f5,    $f5
        mtc1    $a3,    $f7
        cvt.s.w $f7,    $f7
        mtc1    $t1,    $f11
        cvt.s.w $f11,   $f11
        mtc1    $t2,    $f13
        cvt.s.w $f13,    $f13
        mtc1    $t3,    $f15
        cvt.s.w $f15,    $f15


        
 		addi	$t0,	$zero,	1
 		beq	    $a0,	$t0,	calcBatingAverage

 		addi	$t0,	$zero,	2
 		beq	    $a0,	$t0,	calcSluggingPercentage

 		addi	$t0,	$zero,	3
 		beq	    $a0,	$t0,	calcOnBasePercentage
        

calcBatingAverage:

		add.s	$f17,	$f5,	$f7			# hits = singles + doubles
		add.s	$f17,	$f17,	$f11		# hits = hits + triples
		add.s	$f17,	$f17,	$f13		# hits = hits + home runs

		add.s	$f19,	$f17,	$f15		# atBats = hits + outs
		

        add     $a0,    $zero,  $a1         # Getting parameters ready for printStats
        add     $a1,    $zero,  $a2
        add     $a2,    $zero,  $a3
        add     $a3,    $zero,  $t1
        add     $t1,    $zero,  $t2
        add     $t2,    $zero,  $t3

        addiu   $sp,    $sp,    -80         # preserving t registers
        swc1    $f1,    76($sp)
        swc1    $f3,    72($sp)
        swc1    $f5,    68($sp)
        swc1    $f7,    64($sp)
        swc1    $f11,   60($sp)
        swc1    $f13,   56($sp)
        swc1    $f15,   52($sp)
        swc1    $f17,   48($sp)
        swc1    $f19,   44($sp)
        swc1    $f21,   40($sp)
        sw      $t9,    36($sp)
        sw      $t8,    32($sp)
        sw      $t7,    28($sp)
        sw      $t6,    24($sp)
        sw      $t5,    20($sp)
        sw      $t4,    16($sp)
        sw      $t3,    12($sp)
        sw      $t2,    8($sp)
        sw      $t1,    4($sp)
        sw      $t0,    0($sp)

        sw      $t2,    -4($sp)            # put homeruns 2nd fm top of printStats' stack
        sw      $t1,    -8($sp)            # put triples 3rd fm top of printStats' stack


        jal     printStats

        lwc1    $f1,    76($sp)
        lwc1     $f3,    72($sp)
        lwc1    $f5,    68($sp)
        lwc1    $f7,    64($sp)
        lwc1    $f11,   60($sp)
        lwc1    $f13,   56($sp)
        lwc1    $f15,   52($sp)
        lwc1    $f17,   48($sp)
        lwc1    $f19,   44($sp)
        lwc1    $f21,   40($sp)
        lw      $t9,    36($sp)
        lw      $t8,    32($sp)
        lw      $t7,    28($sp)
        lw      $t6,    24($sp)
        lw      $t5,    20($sp)
        lw      $t4,    16($sp)
        lw      $t3,    12($sp)
        lw      $t2,    8($sp)
        lw      $t1,    4($sp)
        lw      $t0,    0($sp)

        addiu   $sp,    $sp,     80      # preserving t registers

        addi    $t0,    $zero,  0           
        mfc1    $t8,    $f19
        beq     $t8,    $t0,    AverageChangeToZero

		div.s	$f21,	$f17,	$f19		# Caculating batting 


        mfc1    $v0,    $f21

		j		endAverage

AverageChangeToZero:
		addi	$v0,	$zero,	0
		j		endAverage

calcSluggingPercentage:

        add.s   $f17,   $f7,    $f7        # doubles*2

        add.s   $f19,   $f5,    $f17        # SP =singles + doubles*2
        add.s   $f17,   $f11,   $f11       # triples*2
        add.s   $f17,   $f17,   $f11       # triple*3

        add.s   $f19,   $f19,   $f17       # SP = SP + triples*3

        add.s   $f17,   $f13,   $f13       # homerun*2
        add.s   $f17,   $f17,   $f17       # homerun*4

        add.s   $f19,   $f19,   $f17       # SP = SP + homerun*4


        add.s   $f17,   $f5,    $f7         # hits = singles + doubles
        add.s   $f17,   $f17,   $f11        # hits = hits + triples
        add.s   $f17,   $f17,   $f13        # hits = hits + home runs

        add.s   $f17,   $f17,   $f15        # atBats = hits + outs

        add     $a0,    $zero,  $a1         # Getting parameters ready for printStats
        add     $a1,    $zero,  $a2
        add     $a2,    $zero,  $a3
        add     $a3,    $zero,  $t1
        add     $t1,    $zero,  $t2
        add     $t2,    $zero,  $t3

        addiu   $sp,    $sp,     -80        # preserving t registers
        swc1    $f1,    76($sp)
        swc1    $f3,    72($sp)
        swc1    $f5,    68($sp)
        swc1    $f7,    64($sp)
        swc1    $f11,   60($sp)
        swc1    $f13,   56($sp)
        swc1    $f15,   52($sp)
        swc1    $f17,   48($sp)
        swc1    $f19,   44($sp)
        swc1    $f21,   40($sp)
        sw      $t9,    36($sp)
        sw      $t8,    32($sp)
        sw      $t7,    28($sp)
        sw      $t6,    24($sp)
        sw      $t5,    20($sp)
        sw      $t4,    16($sp)
        sw      $t3,    12($sp)
        sw      $t2,    8($sp)
        sw      $t1,    4($sp)
        sw      $t0,    0($sp)

        sw      $t2,    -4($sp)            # put homeruns 2nd fm top of printStats' stack
        sw      $t1,    -8($sp)            # put triples 3rd fm top of printStats' stack


        jal     printStats

        lwc1    $f1,    76($sp)
        lwc1    $f3,    72($sp)
        lwc1    $f5,    68($sp)
        lwc1    $f7,    64($sp)
        lwc1    $f11,   60($sp)
        lwc1    $f13,   56($sp)
        lwc1    $f15,   52($sp)
        lwc1    $f17,   48($sp)
        lwc1    $f19,   44($sp)
        lwc1    $f21,   40($sp)
        lw      $t9,    36($sp)
        lw      $t8,    32($sp)
        lw      $t7,    28($sp)
        lw      $t6,    24($sp)
        lw      $t5,    20($sp)
        lw      $t4,    16($sp)
        lw      $t3,    12($sp)
        lw      $t2,    8($sp)
        lw      $t1,    4($sp)
        lw      $t0,    0($sp)

        addiu   $sp,    $sp,     80         # preserving t registers


        addi    $t0,    $zero,  0           
        mfc1    $t6,    $f17
        beq     $t6,    $t0,    SluggingChangeToZero

        div.s   $f21,   $f19,   $f17        # SP = SP/atBats 

        mfc1    $v0,    $f21


		j		endAverage

SluggingChangeToZero:
        addi    $v0,    $zero,  0
        j       endAverage

calcOnBasePercentage:


        add.s   $f17,   $f5,    $f7         # hits = singles + doubles
        add.s   $f17,   $f17,   $f11        # hits = hits + triples
        add.s   $f17,   $f17,   $f13        # hits = hits + home runs

        add.s   $f19,   $f17,   $f15        # atBats = hits + outs

        add.s   $f17,   $f17,   $f3         # hits + walks
        add.s   $f19,   $f19,   $f3         # atBats + walks

        add     $a0,    $zero,  $a1         # Getting parameters ready for printStats
        add     $a1,    $zero,  $a2
        add     $a2,    $zero,  $a3
        add     $a3,    $zero,  $t1
        add     $t1,    $zero,  $t2
        add     $t2,    $zero,  $t3

        addiu   $sp,    $sp,     -80        # preserving t registers
        swc1    $f1,    76($sp)
        swc1    $f3,    72($sp)
        swc1    $f5,    68($sp)
        swc1    $f7,    64($sp)
        swc1    $f11,   60($sp)
        swc1    $f13,   56($sp)
        swc1    $f15,   52($sp)
        swc1    $f17,   48($sp)
        swc1    $f19,   44($sp)
        swc1    $f21,   40($sp)
        sw      $t9,    36($sp)
        sw      $t8,    32($sp)
        sw      $t7,    28($sp)
        sw      $t6,    24($sp)
        sw      $t5,    20($sp)
        sw      $t4,    16($sp)
        sw      $t3,    12($sp)
        sw      $t2,    8($sp)
        sw      $t1,    4($sp)
        sw      $t0,    0($sp)

        sw      $t2,    -4($sp)             # put homeruns 2nd fm top of printStats' stack
        sw      $t1,    -8($sp)             # put triples 3rd fm top of printStats' stack


        jal     printStats

        lwc1    $f1,    76($sp)
        lwc1     $f3,    72($sp)
        lwc1    $f5,    68($sp)
        lwc1    $f7,    64($sp)
        lwc1    $f11,   60($sp)
        lwc1    $f13,   56($sp)
        lwc1    $f15,   52($sp)
        lwc1    $f17,   48($sp)
        lwc1    $f19,   44($sp)
        lwc1    $f21,   40($sp)
        lw      $t9,    36($sp)
        lw      $t8,    32($sp)
        lw      $t7,    28($sp)
        lw      $t6,    24($sp)
        lw      $t5,    20($sp)
        lw      $t4,    16($sp)
        lw      $t3,    12($sp)
        lw      $t2,    8($sp)
        lw      $t1,    4($sp)
        lw      $t0,    0($sp)

        addiu   $sp,    $sp,     80         # preserving t registers


        addi    $t0,    $zero,  0           
        mfc1    $t6,    $f19
        beq     $t6,    $t0,    OnBaseChangeToZero

        div.s   $f21,   $f17,   $f19        # OnBase Percentage


        mfc1    $v0,    $f21

		j		endAverage

OnBaseChangeToZero:
        addi    $v0,    $zero,  0
        j       endAverage




endAverage:



        
        lw      $fp,    0($sp)              # save frame pointer of caller
        lw      $ra,    4($sp)              # save return address

        lw      $a0,    8($sp)              
        lw      $a1,    12($sp)
        lw      $a2,    16($sp)
        lw      $a3,    20($sp)
        addiu   $sp,    $sp,    36         # allocate stack space -- default of 24 here
        jr      $ra

