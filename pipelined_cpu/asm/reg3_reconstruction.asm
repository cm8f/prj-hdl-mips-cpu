addi $t0, $zero, 0 		#set t0 to zero
nop
addi $t1, $zero, 0x1c		#set t1 to 0x1c
nop
addi $t9, $zero, 1		#set t9 set to 1
nop
j test

loop:

test:
	blt $