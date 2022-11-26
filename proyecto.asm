# t0 es el límite superior
# t1 es el límite inferior
# s0 es el año
# s1 es el mes
# s2 es el día
# s3 indicador de año bisiesto
# t6 indicador si el mes tiene 31 dìas
# t7 indicador si el mes tiene 30 dias

.data

	mactual: .asciiz "actual: "
	msiguiente: .asciiz " siguiente: "
	text:  .asciiz "/"

.text

main: 	

	li $t0, 100
	li $t1, 2000
	jal random	
	add $s0, $a0, 0	
	li $t3, 4
	div $s0, $t3
	mfhi $t2
	bne $t2, $zero, bex
	li $s3, 1
	
bex:
	li $t0, 12
	li $t1, 1
	jal random
	add $s1, $a0, 0
	andi $t2, $s1, 1
	slti $t3, $s1, 8
	and $t4, $t2, $t3
	sll $t2, $t2, 31
	nor $t2, $t2, $t2
	srl $t2, $t2, 31
	sll $t3, $t3, 31
	nor $t3, $t3, $t3
	srl $t3, $t3, 31
	and $t5, $t2, $t3
	or $t6, $t4, $t5
	beq $t6, $zero, beqex
	li $t0, 31
	jal bexit
	
beqex:
	li $t2, 2
	beq $t2, $s1, feb
	li $t0, 30
	jal bexit
	
feb: 
	bne $s3, $zero, bis
	li $t0, 28
	jal bexit

bis:
	li $t0, 29
	

bexit:
	li $t1, 1
	jal random
	add $s2, $a0, 0

    	# Printing out the text
    	li $v0, 4
    	la $a0, mactual
    	syscall
    	
    	add $a0, $s2, 0
	li $v0, 1   # 1 is the system call code to show an int number
	syscall     # as I said your generated number is at $a0, so it will be printed

	# Printing out the text
    	li $v0, 4
    	la $a0, text
    	syscall
	
	add $a0, $s1, 0
	li $v0, 1   # 1 is the system call code to show an int number
	syscall     # as I said your generated number is at $a0, so it will be printed

	# Printing out the text
    	li $v0, 4
    	la $a0, text
    	syscall
	
	add $a0, $s0, 0
	li $v0, 1   # 1 is the system call code to show an int number
	syscall     # as I said your generated number is at $a0, so it will be printed

	beq $s2, $t0, sig
	li $t2, 0 # t2 indica si es fin de mes
	jal sigexit
	
sig: 
	li $t2, 1
	
	
sigexit:
	li $t3, 12
	beq $t3, $s1, dic
	li $t4, 0
	jal dicexit

dic:
	li $t4, 1
	
dicexit:
	and $t3, $t2, $t4
	beq $t3, $zero, finmes
	li $s2, 1
	li $s1, 1
	addi $s0, $s0, 1
	jal finmesexit
	
finmes: 
	beq $t2, $zero, finanio
	li $s2, 1
	addi $s1, $s1, 1
	jal finmesexit
	
finanio:
	addi $s2, $s2, 1

finmesexit:
	
	# Printing out the text
    	li $v0, 4
    	la $a0, msiguiente
    	syscall
    	
    	add $a0, $s2, 0
	li $v0, 1   # 1 is the system call code to show an int number
	syscall     # as I said your generated number is at $a0, so it will be printed

	# Printing out the text
    	li $v0, 4
    	la $a0, text
    	syscall
	
	add $a0, $s1, 0
	li $v0, 1   # 1 is the system call code to show an int number
	syscall     # as I said your generated number is at $a0, so it will be printed

	# Printing out the text
    	li $v0, 4
    	la $a0, text
    	syscall
	
	add $a0, $s0, 0
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
	
