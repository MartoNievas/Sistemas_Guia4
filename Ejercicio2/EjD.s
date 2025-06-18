.text 
.global main 
.global division

main:
    #Test1  
    li a0,4 # x 
    li a1,2 # y 
    jal ra, division 
    li a2, 2 
    bne a0,a2,noFunciona
    #Test2 
    li a0, 3 
    li a1, -2 
    jal ra,division
    li a2, -1 
    bne a0,a2,noFunciona
    funciona: 
        li a1, 1
        j fin 
        
    noFunciona:
        li a1,0 
        j fin 
    fin:
        j fin 
        
division: #un n y un d como parametro a0 = n y a1 = d  
    addi sp, sp ,-16 
    sw ra, 0(sp) # guardo la direccion de retorno en la pila 
    li t0,0 # contador = 0 
    li t1,0 #flag del signo 
    #faltaban comprobaciones de signo 
    
    bgez a0,checka1  # si a0 >= 0 me fijo a1 
    xori t1,t1,1 #caso contrario invertimos la flag de signo 
    neg a0,a0  #pasamos a positivo a0 
    
    checka1: 
        bgez a1,while 
        xori t1,t1,1 #si no invertimos la flag de signo 
        neg a1,a1 #ahora lo pasamos a positivo 
    
    
    
    
    while: 
        blt a0,a1, termina # si n < d termina 
        sub a0,a0,a1 # n = n - d 
        addi t0,t0,1 # contador += 1
        j while 
    
    
    termina: 
    beqz t1,epilogo #ya era positivo 
    neg t0,t0
    
    epilogo:
        mv a0,t0 # Epilogo, muevo el valor de retorno a a0 
        lw ra,0(sp)  # Epilogo 
        addi sp,sp,16  #Epilogo 
        ret # return 
