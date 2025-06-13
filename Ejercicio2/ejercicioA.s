.data 
.text 
.global mult 
.global main
main:
   li a0,2
   li a1,2 
   call mult 
   
   
   ret
   nop
mult: 
    addi sp, sp, -8 
    sw ra, 4(sp) 
    sw t0, 0(sp)
    
    mv t0, x0
    
    for:
    beqz a1, fin
    add t0,t0,a0
    addi,a1,a1,-1
    
    j for
    fin: 
        mv a0,t0
        
        lw ra, 4(sp)
        lw t0, 0(sp)
        addi sp,sp,8
        ret
    

    
        
    
    
    
            