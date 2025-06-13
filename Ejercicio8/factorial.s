.text 
.global main 
.global factorial

main: 
    #Test1 caso base 
    li a0,0 
    
    jal ra,factorial 
    li a1,1 
    bne a0,a1,noFunciona
    
    
    #Test2 
    
    li a0,5 
    
    jal ra, factorial 
    li a1,120 
    bne a0,a1,noFunciona
    
    
    funciona: 
        li a1, 1
        j fin 
    noFunciona: 
        li a1,0 
        j fin 
    fin: j fin

#Funcion 
factorial: 
    addi sp, sp, -16 #Prologo, reservo espacio en el stack 
    sw ra,0(sp)
    sw a0, 4(sp) #Cargo en memoria la direccion de retorno  

    beq a0,zero,casoBase0 #Caso base a0 == 0 
    addi a0,a0,-1
    jal ra, factorial #llamado recursivo factorial(n-1)
    
    lw t0, 4(sp) 
    mul a0,t0,a0
    j terminar
    
    
    casoBase0: 
    li a0, 1
    
    
    terminar: 
    lw ra,0(sp) 
    addi sp,sp,16
    ret 