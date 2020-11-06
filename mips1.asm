.data
nx:	 		 .word 		0
ny:			 .word		0
prompt1:		.asciiz 		"gradul maxim al functiei x : "
prompt2: 		.asciiz	 	"gradul maxim al functiei y : "
prompt3:	 	.asciiz	 	"Pentru funtia x se va citi de la cel mai mic grad valoarea spre cel mai mare"
prompt4:		.asciiz	 	"Pentru funtia y se va citi de la cel mai mic grad valoarea spre cel mai mare"
prompt5: 		.asciiz	 	" * x^"
prompt6:	 	.asciiz	 	" * y^"
prompt7:		.asciiz		"Valoare conditie pentru x"
prompt8:		.asciiz		"Valoare conditie pentru y"
prompt9:		.asciiz		"Valoarea iteratiei h="
plus:		 	.asciiz	 	" + "
space: 		.asciiz	 	" "
endline: 		.asciiz	 	"\n"
afsx:			.asciiz		"x="
afsy:			.asciiz		"y="
myFx: 		.float	 	0.0:5
myFy: 		.float		0.0:5
valx0:		.float		0.0
valy0:		.float		0.0
unu:			.float		1.0
doi:			.float		2.0
six:			.float		6.0
three:		.float		3.0
zeroValF:		.float		0.0
h:			.float		0.1
iteratii:		.word	10
i:			.word	1
k1:			.float	
k2:			.float
k3:			.float
k4:			.float
.text
.globl Main
	Main:
	jal CitireGrad
	jal CitireFunctii
	jal PrintareXsiY
	jal CitireConditii
	
IteratieXY:
	#f2 = x pentru calcularea functiei diferentiale
	#f3 = y f(x,y) -> x=x(anterior) +h etc
	lwc1 $f2,valx0	
	lwc1 $f3,valy0
	
	li $v0,1
	lw $a0,i
	syscall
	
	li $v0,4
	la $a0,endline
	syscall
	
	li $v0,4
	la $a0,afsx
	syscall
	
	li $v0,2
	mov.s $f12,$f2
	syscall
	
	li $v0,4
	la $a0,endline
	syscall
	
	li $v0,4
	la $a0,afsy
	syscall
	
	li $v0,2
	mov.s $f12,$f3
	syscall
	
	li $v0,4
	la $a0,endline
	syscall
	
	jal CalculareFunctie	
	lwc1 $f9,h
	mul.s $f6,$f6,$f9
	swc1 $f6,k1
	
	li $v0,2
	lwc1 $f12,k1
	syscall
	li $v0,4
	la $a0,endline
	syscall
	
	lwc1 $f8,doi
	div.s $f9,$f9,$f8
	add.s $f2,$f9,$f2
	
	lwc1 $f9,k1
	div.s $f9,$f9,$f8
	add.s $f3,$f3,$f9
	
	jal CalculareFunctie
	lwc1 $f9,h
	mul.s $f6,$f6,$f9
	swc1 $f6,k2
	
	li $v0,2
	lwc1 $f12,k2
	syscall
	
	li $v0,4
	la $a0,endline
	syscall
	
	lwc1 $f3,valy0
	div.s $f6,$f6,$f8
	add.s $f3,$f6,$f3
	
	jal CalculareFunctie
	lwc1 $f9,h
	mul.s $f6,$f6,$f9
	swc1 $f6,k3
	
	li $v0,2
	lwc1 $f12,k3
	syscall
	
	li $v0,4
	la $a0,endline
	syscall
	
	lwc1 $f2,valx0
	lwc1 $f3,valy0
	
	add.s $f2,$f2,$f9
	add.s $f3,$f3,$f6
	
	jal CalculareFunctie
	lwc1 $f9,h
	mul.s $f6,$f6,$f9
	swc1 $f6,k4
	
	li $v0,2
	lwc1 $f12,k4
	syscall
	#ATRIBUIREA
	
	lwc1 $f2,valx0	
	lwc1 $f3,valy0
	
	lwc1 $f9,h
	add.s $f2,$f2,$f9
	swc1 $f2,valx0
	
	lwc1 $f6,k1
	lwc1 $f7,six
	div.s $f6,$f6,$f7
	add.s $f3,$f3,$f6
	
	lwc1 $f6,k2
	lwc1 $f7,three
	div.s $f6,$f6,$f7
	add.s $f3,$f3,$f6
	
	lwc1 $f6,k3
	lwc1 $f7,three
	div.s $f6,$f6,$f7
	add.s $f3,$f3,$f6
	swc1 $f3,valy0
	
	lwc1 $f6,k4
	lwc1 $f7,six
	div.s $f6,$f6,$f7
	add.s $f3,$f3,$f6
	
	lw $a1,iteratii
	lw $a2,i
	addi $a2,$a2,1
	sw $a2,i
	
	li $v0,4
	la $a0,endline
	syscall
	
	bne $a1,$a2,IteratieXY
	
	lwc1 $f2,valx0	
	lwc1 $f3,valy0
	
	li $v0,4
	la $a0,endline
	syscall
	
	li $v0,4
	la $a0,afsx
	syscall
	
	li $v0,2
	mov.s $f12,$f2
	syscall
	
	li $v0,4
	la $a0,endline
	syscall
	
	li $v0,4
	la $a0,afsy
	syscall
	
	li $v0,2
	mov.s $f12,$f3
	syscall
	
	li $v0,4
	la $a0,endline
	syscall
	
	li $v0,10
	syscall
	############################################################
	CitireGrad:
	#Printare text1
	li $v0,4
	la $a0,prompt1
	syscall
	
	#Citire Grad x
	li $v0,5
	syscall
	sw $v0,nx
		
	#Printare text2
	li $v0,4
	la $a0,prompt2
	syscall
	#Citire Grad y
	li $v0,5
	syscall
	sw $v0,ny
	
	jr $ra
	
	CitireFunctii:
	li $v0,4
	la $a0,prompt3
	syscall
	
	li $v0,6
	move $t0,$zero
	move $t1,$zero
	lw $t2,nx
Loop1:	#parcurgere recursiva si salvare valoare citita in myFx(indice) -> cea mai mica valoarea o sa fie la myFx(0) etc
	syscall	
	swc1 $f0,myFx($t0)
	addi $t0, $t0,4
	addi $t1,$t1,1
	bne $t1,$t2,Loop1
	
	li $v0,4
	la $a0,prompt4
	syscall
	li $v0,6
	move $t0,$zero
	move $t1,$zero
	lw $t2,ny
Loop2:
	syscall	
	swc1 $f0,myFy($t0)
	addi $t0, $t0,4
	addi $t1,$t1,1
	bne $t1,$t2,Loop2
	jr $ra
	
PrintareXsiY:
	move $t1,$zero
	move $t0,$zero
	lw $t2,nx
	
Loopprint1:
	lwc1 $f12,myFx($t1)
	li $v0,2
	syscall	
	li $v0,4
	la $a0,prompt5
	syscall	
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,plus
	syscall
	addi $t1, $t1,4
	addi $t0,$t0,1
	bne $t0,$t2, Loopprint1
	
	#endline
	li $v0,4
	la $a0,endline
	syscall
	
	move $t1,$zero
	move $t0,$zero
	lw $t2,ny
	
Loopprint2:
	lwc1 $f12,myFy($t1)
	li $v0,2
	syscall
	li $v0,4
	la $a0,prompt6
	syscall	
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,plus
	syscall
	addi $t1, $t1,4
	addi $t0,$t0,1
	bne $t0,$t2, Loopprint2
	jr $ra
	
CitireConditii:
	li $v0,4
	la $a0,endline
	syscall
	#citire X
	li $v0,4
	la $a0,prompt7
	syscall	
	li $v0,6
	syscall
	swc1 $f0,valx0
	
	li $v0,4
	la $a0,endline
	syscall
	#citire Y
	la $a0,prompt8
	syscall
	li $v0,6
	syscall
	swc1 $f0,valy0
	
	li $v0,4
	la $a0,endline
	syscall
	#citire H
	la $a0,prompt9
	syscall
	li $v0,6
	syscall
	swc1 $f0,h
	
	li $v0,4
	la $a0,endline
	syscall
	
	jr $ra

CalculareFunctie:
	
	#Calculare ecuatie x , parcurgem vectorul iar la fiecare iteratie inmultim cu x^ respectiva apoi adunam in rezultat
	# x e in $f2, y e in $f3
	
	
	move $t1,$zero #contor i
	move $t3,$zero
	lwc1 $f6,zeroValF #rezultat final
 	lwc1 $f4,unu
 	lw $t2,nx
 Loop3:
 	lwc1 $f5,myFx($t3) 	
 	mul.s $f5,$f5,$f4
 	add.s $f6,$f5,$f6		
 	addi $t3,$t3,4
 	mul.s $f4,$f4,$f2 # x^ iteratiei
 	addi $t1,$t1,1 	
 	bne $t1,$t2,Loop3
 	
 	move $t1,$zero #contor i
	move $t3,$zero
 	lwc1 $f7,zeroValF #rezultat final
 	lwc1 $f4,unu
 	lw $t2,ny
Loop4:
	 lwc1 $f5,myFy($t3) 	
 	mul.s $f5,$f5,$f4
 	add.s $f7,$f5,$f7
 	addi $t3,$t3,4
 	mul.s $f4,$f4,$f3
 	addi $t1,$t1,1
 	bne $t1,$t2,Loop4
 	
 	div.s $f6,$f6,$f7
 	
 	jr $ra
	
	
		
	
	
