.data

.text 
.global main 
.global f_lineal
main:
    li a0,-1
    li a1,1
    la a2, f_lineal
    jal ra, biseccion 
    li a3, 1 
    bne a0,a3, noFunciona 
    
    funciona: 
        li a1, 1 
        j fin 
        
    noFunciona: 
        li a1,0 
        j fin
    fin: j fin 
    
f_lineal:
    # Supone que x está en a0
    slli a0, a0, 1     # a0 = 2x
    addi a0, a0, -4    # a0 = 2x - 4
    ret
    


biseccion: 
    addi sp,sp,-32 
    sw ra, 0(sp) 
    sw a0,4(sp)
    sw a1,8(sp) 
    
    
    jalr a2   #calculo f(a)
    beq a0,zero,hayRaiz
    mv t0,a0 #f(a)

    sw t0, 16(sp)
    mv a0,a1  # paso b a a0  
    jalr a2  #calculo f(b)
    beq a0,zero,hayRaiz 
    mv t1,a0 # f(b) 
    sw t1,20(sp)
    li t2, 1 #epsilon 
    
    
    mul t0,t0,t1 #f(a)*f(b) 
    blt t0,zero,hayRaiz #si f(a)*f(b) < 0 entonces hay raiz 
    #caso contrario 
    
    lw a0,4(sp) #restauro valores originales 
    lw a1,8(sp) #restauro valores originales 
    
    mv t0,a0 
    mv t1,a1 
    sub t0,t1,t0 # t0 = b - a 
    
    #Ahora comparamos con epsilon 
    ble t0,t2,noHayRaiz
    #caso contrario calculemos m 
    
    add t0,a0,a1 # a + b
    srai a0,t0,1 # m = (a+b)/2
    
    sw a0,12(sp) # guardo m en el stack 
    jalr a2
    
    beq a0,zero,hayRaiz # si f(m) == 0 hay raiz 
    mv t0,a0 # t0 = f(m) 
    lw a0,16(sp) # a0 = f(a)
    
    mul t0,t0,a0 # f(m)*f(a) 
    blt t0,zero, biseccion1 #f(m)*f(a)  < 0 biseccion(a,m)
    else: 
    lw a0, 8(sp) 
    lw a1, 12(sp) 
    jal ra , biseccion
    
    
    biseccion1: 
        lw a0,4(sp) # a 
        lw a1,12(sp)  # m 
        jal ra, biseccion
        
        j epilogo
    hayRaiz: 
        li a0, 1
        j epilogo 
        
    noHayRaiz: 
        li a0, 0
        j epilogo
    
    
    epilogo: 
        lw ra, 0(sp) 
        addi sp,sp,32
        ret 
    
