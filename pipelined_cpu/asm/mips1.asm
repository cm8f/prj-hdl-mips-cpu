addi $t0, $zero, 0 #set register to 1
addi $t1, $zero, 1 #set increment

addi $t2, $zero, 10 # set n
addi $t3, $zero, 0  # set i = 0
# increment
j test
loop:
	add $t0, $t0, $t1 # increment register by 4
	addi $t3, $t3, 1  # increment loop variable
test:
	#blt $t3, $t2, loop 
	slt $t9, $t2, $t3
	beq $t9, 1, loop
	
