.text 
.global main 
.global fibonacci3


main: 
    # Test1 caso base 
    li a0, 2  # n = 2
    jal ra, fibonacci3 # fibonacci3(2) = 2 
    li a1, 2 
    bne a0, a1, noFunciona # fibonacci3(2) = 2 compara el valor obtenido con el esperado
    # Test1 caso n = 5 
    li a0, 5 
    jal ra, fibonacci3 # fibonacci3(5) 
    li a1, 11
    bne a0,a1,noFunciona # fibonacci3(5) == 11
funciona:  
    li a1, 1 # si funciona guardo 1 en a1 
    j fin # termino ejecucion del test 
noFunciona:  
    li a1, 0 # si no funciona guardo 0 en a1 
    fin: j fin # fin del test 
fibonacci3:
    addi sp,sp,-16 #Prolgo
    sw ra,0(sp) #Prolgo
    sw s0,4(sp) #Prolgo
    sw s1, 8(sp) #Prolgo
    sw s2, 12(sp) #Prolgo
     
    mv s0,a0 # s0 = a0 = n 
    caso_base: 
    li t0, 0        
    beq s0,t0,caso0 # n == 0 
    li,t0,1
    beq s0,t0,caso1 # n == 1
    li t0,2
    beq s0,t0,caso2 # n == 2
    caso_recursivo: 
        addi a0,s0,-1 #a0 = n-1
        jal ra, fibonacci3 # a0 = T(n-1)
        mv s1,a0 #s1 = a0
        
        addi a0,s0,-2 #a0 = n-2
        jal ra, fibonacci3 # a0 = T(n-2)
        mv s2,a0       # s2 = a0 
        
        addi a0, s0,-3  #a0 = n -3
        jal ra,fibonacci3 #a0 = T(n-3)
        add a0, a0,s1 # a0 += T(n-1)
        add a0, a0,s2 # a0 += T(n-2)
        j epilogo 
        
    
    caso0:
         li a0, 0 # a0 = 0 
         j epilogo
     caso1:
         li a0, 1 # a0 = 1
         j epilogo      
     caso2:
         li a0, 2 # a0 = 1
         j epilogo
    
    epilogo:
        lw ra,0(sp) # Restauro la direccion de retorno 
        lw s0,4(sp) # Restauro el valor de s0 
        lw s1,8(sp) # Restauro el valor de s1
        lw s2,12(sp) # Restauro el valor de s2
        addi sp,sp,16 #Borro el espacio reservado en la pila 
        ret  # return 
    
    
    
    
