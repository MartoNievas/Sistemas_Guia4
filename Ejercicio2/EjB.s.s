.text 
.global main 
.global fibonacciI

main: 
    li a0, 0 
    jal ra, fibonacciI
    li a2, 0 
    bne a0,a2,noFunciona 
    li a0, 5 
    jal ra, fibonacciI
    li a2, 3
    bne a0,a2,noFunciona
     
    funciona: 
    li a1, 1
    j fin
    noFunciona: 
    li a1, 0 
    j fin
    fin: 
        j fin     
        
fibonacciI:
    addi sp,sp,-16 
    sw ra,0(sp)
    mv t0,a0 # t0 = n  
    li t1,0 #anterior = 0 
    li t2,1 #anterior = 1 
    li a0 ,0 
    casosbase:
    beq t0,t1, terminar
    beq t0,t2, terminar
        
    
    li t3, 2 # i = 2    
    while: 
        bgt t3,t0, terminar # i == n termina la iteracion 
        add a0, t1,t2 # res = anterior1 + anterior2
        mv t1,t2 # anterior1 = anterior2
        mv t2,a0 #anterior2 = res 
        addi t3,t3,1 # i += 1 
        j while 
    terminar:
        lw ra,0(sp)
        addi sp,sp,16
        mv a0,t1 
        ret 