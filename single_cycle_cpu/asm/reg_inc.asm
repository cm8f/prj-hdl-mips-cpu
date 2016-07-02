addi $t0,$zero,0 # init i
nop
addi $t1,$zero,30 # init n
nop
addi $t9,$zero,1 # compare value
nop

j test

loop:
	addi $t0,$t0,4
	nop
	sw $t0,($t0) 	# stoe word
	nop
test:
	slt $t2,$t0,$t1 # i < n?
	nop
	beq $t2,$t9,loop # loop while less than
	nop

addi $t0,$zero,0 # init read iteratoin i
nop 
addi $t1,$zero,30 # end of iteration
nop 

j memtest

memcheck:
	lw $t3,($t0) # load word from addr i to t3
	nop
	addi $t0,$t0,4 # increment
	nop
memtest:
	slt $t2,$t0,$t1 # i < n	
	nop 
	beq $t2,$t9,memcheck
	nop
	
