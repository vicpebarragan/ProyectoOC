
.data

	text:  .asciiz "/"

.text

main: 	
	li $t0, 31
	li $t1, 1
	jal random
	add $s2, $a0, 0
	li $v0, 1   # 1 is the system call code to show an int number
	syscall     # as I said your generated number is at $a0, so it will be printed

    	# Printing out the text
    	li $v0, 4
    	la $a0, text
    	syscall

	li $t0, 12
	li $t1, 1
	jal random
	add $s1, $a0, 0
	li $v0, 1   # 1 is the system call code to show an int number
	syscall     # as I said your generated number is at $a0, so it will be printed

	# Printing out the text
    	li $v0, 4
    	la $a0, text
    	syscall

	li $t0, 100
	li $t1, 2000
	jal random	
	add $s0, $a0, 0	
	li $v0, 1   # 1 is the system call code to show an int number
	syscall     # as I said your generated number is at $a0, so it will be printed

	jal exit

random: 
	add $a1, $t0, 0 # $a1 is where you set the upper bound
	li $v0, 42  # 42 is system call code to generate random int
	syscall     # your generated number will be at $a0
	add $a0, $a0, $t1  #Here you add the lowest bound
	jr $ra
	
exit: 
	