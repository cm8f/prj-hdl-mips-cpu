# increment register n times

addi $t0,$zero,0	# i = 0
addi $t1,$zero,1000	# n = 1000
addi $t9,$zero,1	# compare = 1

j test

loop:
	addi $t0,$t0,1	# i = i + 1
test:
#	blt $t0,$t1,loop
	slt $t2,$t0,$t1	# t2 = (i < n)
	beq $t2,$t9,loop	# branch to loop if t2 = 1