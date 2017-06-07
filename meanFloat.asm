#Finds mean value of n floating point values
#Luke Gulley
#November 29, 2016

.data
	.align 2
	askN: .asciiz "How many numbers would you like to average? "
	.align 2
	askFloat: .asciiz "Please enter a 3 digit decimal d.dd: "
	.align 2
	outSum: .asciiz "The sum is: "
	.align 2
	outAvg: .asciiz "\nThe average is: "

.text
.globl main

main:
#asks for user input (N)
la $a0, askN
li $v0, 4
syscall

#stores N in $t0
li $v0, 5
syscall
move $t0, $v0

#converts N to float and stores to $f2
mtc1 $t0, $f1
cvt.s.w $f2, $f1

#$t1 is counter for getFloat loop
li $t1, 1

#gets Floats and their sum
getFloat:
	#ends loop after all numbers added
	bgt $t1, $t0, end

	#asks for float input
	la $a0, askFloat
	li $v0, 4
	syscall
		
	#stores input to $f0
	li $v0, 6
	syscall

	#adds new float to total (total = $f3)
	add.s $f3, $f0, $f3
	
	#increments counter
	addi $t1, $t1, 1
	#loops for next float input
	j getFloat
		
#prints sum and average
end:
	#prints sum message
	la $a0, outSum
	li $v0, 4
	syscall
	
	#prints sum	
	add.s $f12, $f12, $f3
	li $v0, 2
	syscall

	#prints average message
	la $a0, outAvg
	li $v0, 4
	syscall
	
	#prints average
	div.s $f12, $f3, $f2
	li $v0, 2
	syscall

	#exit gracefully
	li $v0, 10 #system call for exit
	syscall #close file