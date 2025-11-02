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
 	call 								 TribSetter
	
 	printi



  label 								 TribSetter
  push 	 2
  push 0
  push 	1
  push 	 2

 	call 									 Tribonacci
	
 	printi



  label 									 Tribonacci
 	 copy 	  4
 	 copy 	  4
	  	sub 
 dup
	 jz 										 TribonacciBase

		jn 										 TribonacciBase

  label 												 TribonacciBucle
 	 copy  	 2
 	 copy  	 2
 	 copy  	 2
	   add	   add  push 0
 
	swap		 store  push 	1
 
	swap		 store  push 	 2
 
	swap		 store 

drop  push 	1
	   sum  push 	 2
			retrieve  push 	1
			retrieve  push 0
			retrieve 	 copy 	  4
 	 copy 	  4
	  	sub
	 jz 											 TribonacciValor

 
j 												 TribonacciBucle

	return

  label 											 TribonacciValor
 	
slide 	  4

	return

  label 										 TribonacciBase
 	 copy 	  4
 	
slide 	 	5

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