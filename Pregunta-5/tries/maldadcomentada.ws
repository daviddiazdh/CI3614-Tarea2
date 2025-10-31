  push 	  			 "N"
	
  printc  push 			 	 	"u"
	
  printc  push 		 		 	"m"
	
  printc  push 		  	 	"e"
	
  printc  push 			  	 "r"
	
  printc  push 		 				"o"
	
  printc  push  			 	 ":"
	
  printc  push  	     ""
	
  printc  push 0
	
		readi  push 0
			 
 dup
 	call 					 Log2Piso

 	call 				 Narayana

 	call 					 Log2Piso
  push 	1
	   sum
 	call 								 labelTrib
	
 	printi



  label 								 labelTrib
 
 dup  push 		3
	  	sub
		jn 									 labelTribBase
 
 dup  push 	1
	  	sub
 	call 								 labelTrib
 	 copy 	1
  push 	 2
	  	sub
 	call 								 labelTrib
 	 copy 	 2
  push 		3
	  	sub
 	call 								 labelTrib
	   sum	   sum 	
 	slide1

	return

  label 									 labelTribBase

	return

  label 					 Log2Piso
  push	0
 	 copy 	

  label 						 Bucle
 	 copy 0
  push 	1
	  	sub 	 copy 0

	 jz 							 SalidaBucle
 	 copy 0

		jn 							 SalidaBucle
 

  push 	 2
	 	 div 
	swap  push 	1
	   sum 
	swap
 
 						 Bucle

  label 							 SalidaBucle
 

drop 

drop 	
 	slide1

	return

  label 				 Narayana
 	 copy 	
 	 copy 	

 	call 			 1
 	 copy 	 
 	 copy 	 
  push 	1
	  	sub
 	call 			 1
	  mul
 	 copy 	 
	 	 div 	
 	 slide2

	return

  label 			 1Combinatorio
 
 dup
 	call 	 0
 	 copy 	 

 	call 	 0
 
	swap 	 copy  		
 	 copy  		
	  	sub
 	call 	 0
	  mul
	 	 div 	
 	 slide2

	return

  label 	 0factorial
 
 dup  push 	1
	  	sub
	 jz 		 2
 
 dup  push 	1
	  	sub
 	call 	 0
	  mul

	return

  label 		 2
 

  push 	1

	return
  push                                                                       	