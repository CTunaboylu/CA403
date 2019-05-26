FIFO: // 2 WAY IMPLEMENTATION
	// STACK POINTER
	BL add_item
add_item: 
	ADDI X19, XZR, XZR // X19 : ITEM COUNTER
	SUBI SP, [SP, #8] // OPEN ROOM FOR NEW WORD
	STUR X0, [SP, #0]
	ADDI X19, X19, #1
	BR LR  

delete_item: # return the item and delete it 
	CBZ X19, fifo_empty
	SUBI X19, X19, #1
	LDUR X0, [] # problem! now it is FILO rather than FIFO 
	
fifo_empty:
