.text 
.global main 
.global Collatz

main: 
    li a0,6 
    
    jal ra, Collatz
    li a1, 8 
    bne a0,a1,noFunciona 
    
    li a0, 1
    
    jal ra, Collatz
    li a1, 0 
    bne a0, a1, noFunciona 
    
    
    funciona: 
        li a1, 1
        j fin 
    
    noFunciona: 
        li a1, 0 
        j fin 
    fin: j fin 

esPar: 
    addi sp, sp, -16 
    sw ra, 0(sp) 
    
    andi a0,a0,1
    beq a0,zero, par
    li a0,0 
    j epilogo
    
    par: 
        li a0, 1
        j epilogo
    epilogo: 
        lw ra,0(sp) 
        addi sp,sp,16
        ret 
        
Collatz: 
    addi sp,sp,-16 
    sw ra, 0(sp) 
    sw a0, 4(sp) 
    li t1,3 # para poder multiplicar por 3  
    li t2,1
    
    beq a0,t2, casoBase
    
    jal ra, esPar
    beq a0,zero,casoImpar
    lw a0, 4(sp)
    srai a0,a0,1 # n / 2 porque es par 
    jal ra, Collatz
    addi a0, a0,1
    
    
    j epilogo1
    casoImpar: 
        lw a0, 4(sp) 
        mul a0,a0,t1 # 3n 
        addi a0,a0,1 # 3n + 1 
        jal ra, Collatz
        addi a0, a0,1
        
        j epilogo1
    casoBase: 
        li a0,0 
    
    epilogo1: 
        lw ra, 0(sp) 
        addi sp, sp,16
        ret 
        
    
    
    
    