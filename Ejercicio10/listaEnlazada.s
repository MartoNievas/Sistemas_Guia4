.data
    nodo4: .word -1 0x0
    nodo3: .word 6 nodo4
    nodo2: .word 3 nodo3
    nodo1: .word -2 nodo2
    raiz: .word nodo1
#En momoria cada nodo ocupa dos palabra/word ya que tiene el valor del nodo un numero de 32 bits y la direccion de memoria del siguente elemento, lo que es igual a 8 bytes y la raiz que ocupa solo 4 bytes.
#Ocupa 4 , entonces una lista enlazada de n elementos ocuparia (n-1)*8 + 4 bytes en memoria. 
.text
.global main
.global sumarListaEnlazada

main: 
    la a0,raiz 
    jal ra, sumarListaEnlazada 
    li a1,6 
    bne a0,a1,noFunciona 
    
    funciona:
        li a1,1
        j fin 
    noFunciona: 
        li a1,0
        j fin 
    fin: j fin 
    
sumarListaEnlazada: 
    addi sp,sp,-16 
    sw ra, 0(sp) 
    sw a0, 4(sp)
    
    
    li t0, 0 # contador = 0 
    lw t2,0(a0) # puntero al primer nodo 
    while: 
    beq t2,zero, terminar # compara si la direccion del nodo no es 0 
    lw t1,0(t2) # valor del nodo i 

    #caso contrario sumo al contador 
    add t0,t0,t1 # contador += valor del nodoi 
    #ahora tengo que ir al siguente nodo 
    lw t2,4(t2) # direccion del siguente nodo  
    j while 
    
    
    
    terminar: 
        mv a0,t0
        lw ra, 0(sp) 
        addi sp,sp,16 
        ret 
    
    
    
    
