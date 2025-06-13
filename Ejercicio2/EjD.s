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
    li a1, 2 
    jal ra,division
    li a2, 1 
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
    while: 
        blt a0,a1, termina # si n < d termina 
        sub a0,a0,a1 # n = n - d 
        addi t0,t0,1 # contador += 1
        j while 
    
    
    termina: 
        mv a0,t0 # Epilogo, muevo el valor de retorno a a0 
        lw ra,0(sp)  # Epilogo 
        addi sp,sp,16  #Epilogo 
        ret # return 
