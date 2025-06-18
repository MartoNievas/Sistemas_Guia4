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
    
    #Tests EvaluarPolinomio 
    #Test 1
    li a0, 1 #x
    la a1,polinomio1 # base del arreglo 
    lw a2,len1  #longitud 
    jal ra, EvaluarPolinomio
    li a2, 11 
    bne a0,a2,noFunciona
    funciona:
        li a1,1 
        j final
    noFunciona: 
        li a1, 0
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

EvaluarMonomio: 
    addi sp,sp,-16 
    sw ra,0(sp) 
    sw a0,4(sp) #guardo valor original de a0
    sw a1,8(sp) # guardo valor orignal de a1
    sw a2,12(sp) # guardo valor original de a2 
    
    #caso si a2 es 0 
    beqz a2, casoP0
    
    
    while: 
    beq a2,zero,terminaPotencia
    mv a1,a0  #pasamo el mismo a0 dos veces como parametro 
    jal ra, mult 
    
    
    lw a1,8(sp) # restauro a1 
    addi a2,a2,-1
    j while
    
    casoP0: 
        beq a0,zero, terminaPotencia #si a0 = 0 devuevlo 0 
        li a0, 1 # caso contario a0 = 1 
    
    terminaPotencia: 
    jal ra,mult # realizo c * a0^p 
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
        
        #---------------
        #Preparamos los 3 argumentos para EvaluarMonomio 
        
        
        lw a1, 0(t2)           # a1 = c = arr[i]
        mv a2, t0              # a2 = p = i  
        sw t0,16(sp) 
        sw t1, 20(sp)
        
   
        jal ra, EvaluarMonomio 
        
        
        lw t0,16(sp)
        lw t1,20(sp)
        add t1,t1,a0 #t1 += a0
        #restauro el valor de x 
        lw a0, 4(sp) # X 
        lw a1, 8(sp) # base del arreglo 
        lw a2, 12(sp) # longitud del arreglo 
 
        addi t0,t0,1 # i += 1 
        j while1 
    terminar: 
        mv a0,t1
        lw ra,0(sp) 
        addi sp,sp,32
        ret 
        
