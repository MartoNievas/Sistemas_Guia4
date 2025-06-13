.data 
polinomio1: .word 1,2,3,0,5
pilonomio2: .word 0,0,0,1,2
len1: .word 5
len2: .word 5 
.text 
.global main 
.global EvaluarMonomio 
.global EvaluarPolinomio 

main: 
    #Tests Evaluar Monomio 
    
    #Test1 
    
    li a0, 3 # x
    li a1, 2 # c
    li a2, 0 # p 
    jal ra, EvaluarMonomio 
    li a2, 2
    bne a0,a2, noFunciona 
    
    
    #Tests EvaluarPolinomio 
    #Test 1
    li a0, 1
    la a1,polinomio1 
    lw a2,len1 
    jal ra, EvaluarPolinomio
    li a2, 11 
    bne a0,a2,noFunciona
    funciona:
        li a1,1 
        j fin
    noFunciona: 
        li a1, 0
        j fin 
        

    fin: j fin  
EvaluarMonomio: 
    addi sp,sp,-16 
    sw ra,0(sp) 
    li t0,1
    
    while: 
    beq a2,zero,terminaPotencia
    mul t0,t0,a0
    addi a2,a2,-1
    j while
    
    
    
    terminaPotencia: 
    mv a0,t0
    mul a0,a0,a1  
    lw ra,0(sp) 
    addi sp,sp,16 
    ret 

EvaluarPolinomio: 
    addi sp,sp,-32
    sw ra,0(sp) 
    sw a0,4(sp) # x   
    sw a1,8(sp) # base del arreglo 
    sw a2,12(sp) # longitud del arreglo 
    
    
    li t0,0 # i = 0 
    li t1,0 # SumaParcial = 0
    
    while1: 
        bge t0, a2, terminar
        slli t2,t0,2 # offset = i * 4 
        add t2,t2,a1 # direccion del arreglo 
        sw t0,16(sp) # guardo el valor de i actual en el stack 
        mv a2,t0  # este es el p = i 
        lw a1,0(t2) # este es el c = arr[i]
        jal ra, EvaluarMonomio 
        
        add t1,t1,a0 #t1 += a0
        lw a0,4(sp) # restauro el valor de a0 
        lw a1,8(sp) # restauro el valor de a1
        lw a2 12(sp) #restauro el valor de a2 
        lw t0, 16(sp) #restauro el valor de i 
        addi t0,t0,1 # i += 1 
        j while1 
    terminar: 
        mv a0,t1
        lw ra,0(sp) 
        addi sp,sp,32
        ret 
        
