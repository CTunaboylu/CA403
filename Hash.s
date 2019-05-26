In this project, you are required to implement basic data structures in assembly code.

- Linked list (25 points): Implement all necessary functions for a linked list structure using assembly code. For example: add_node, delete_node, etc. You are required to identify the functions and define the APIs (5 points), and write assembly code accordingly (20 points).

- FIFO (25 points): Implement all necessary functions for a FIFO structure using assembly code. For example: push, pop, etc. You are required to identify the functions and define the APIs (5 points), and write assembly code accordingly (20 points).

- Binary Search Trees (25 points): Implement all necessary functions for a binary search tree structure using assembly code.You are required to identify the functions and define the APIs (5 points), and write assembly code accordingly (20 points).

- Hashing (25 points): Implement all necessary functions for a hash table using assembly code. You are required to identify the functions and define the APIs (5 points), and write assembly code accordingly (20 points).

Bonus: Write ArmV8 code that is capable of determining cache size of the CPU on an ARM board (example: Raspberry Pi).

// Hash table: hash function (basic) = mod(table_size:prime) + f(i) = collision resolution strategy quadratic probing where i:iteration
 anatomy of registers: X0:item, X1:mod, X2:quotient(reusable), X3:remainder a.k.a. hash, X4:iteration count for collision resolution, X7:hash table address, 
 

hash: //
	// input: x0=dividend, x1=divisor
	SDIV X2, X0, X1
	MSUB X3, X2, X1, X0
	// result: x2=quotient, x3=remainder
insert_int: //location = (X3)hash(element) + i**2, args:{ int:(item:X0, hash_table starting address: X7)
	SUBI SP, SP, #1
	STUR LR, [SP, #0]
	
	BL hash
	ADDI X5,X3, XZR
	BL while // if there is a collision until it is handled, if cannot handle raise an error
	
	ADDI X0, X5, XZR

	// get original LR and shrink stack
	LDUR LR [SP,#0]
	ADDI SP, SP, #1
	
	BR LR

while:	//CHECK FOR COLLISION - what if we get stuck with the  same pattern over and over again?
	ADD X7, X7, X5
	LDUR X2, [X7, #0 ]
	// X6 data in location:for collision check we check the validity of the data: we assume that 0 is for empty slot value
	CBNZ X2, resolve // if X2 != 0 it means occupied -> collision 
	BR LR

resolve: // we need to know iteration count Gonnet and Baeza-Yates compare several hashing strategies; their results suggest that quadratic probing is the fastest method.
	MUL X10, X4,X4
	ADD X5,X3,X10
	ADDI X6, X6, #1
	SUB XZR,X5,X1
	B.LT while   
	SDIV X10, X5, X1
	MSUB X5, X10, X1, X5
	B while

