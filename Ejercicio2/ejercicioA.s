.data 
.text 
.global mult 
.global main
main:
   li a0,2
   li a1,2 
   call mult 
   li a1,4 
   bne a0,a1,noFunciona
   li a0,4
   li a1,-2 
   jal ra, mult 
   li a1,-8 
   bne a0,a1,noFunciona
   
   funciona:
       li a1,1
       j final 
   noFunciona: 
       li a1,0
       j final 
   final: j final 
mult: 
    addi sp, sp, -16 
    sw ra, 4(sp) 
    
    mv t0, x0
    li t1,0 
    
    
    bgez a0, check_a1 # si a0 >= 0 entonces chequeamos el signo de a1 
    xori t1,t1,1
    
    check_a1: 
        bgez a1,for
        xori t1,t1,1
        neg a1,a1
    
    for:
        beqz a1,fin 
        add t0,t0,a0
        addi a1,a1,-1 
        j for 
    
    fin:
        beqz t1,epilogo 
        neg t0,t0
        
    epilogo: 
        mv a0,t0 
        lw ra, 4(sp) 
        addi sp,sp,16 
        ret 
      
       
    

    

    
        
    
    
    
            