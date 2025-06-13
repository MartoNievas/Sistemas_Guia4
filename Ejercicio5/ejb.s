.data 
arr: .word 2,4,5,8,10,12
arr2: .word 1,3,5,7 
len: .word 6
len2: .word 4
.text 
.global main 
.global EsPotenciaDeDos 
.global PotenciasEnArreglo 

main: 
    
    #Test EsPotenciaDeDos
    #Test1  
    li a0, 2 
    jal ra, EsPotenciaDeDos 
    li a1, 1 
    bne a0,a1,noFuncionaEPDD
    
    #Test2
    
    li a0 ,3 
    jal ra ,EsPotenciaDeDos 
    li a1, 0 
    bne a0,a1,noFuncionaEPDD
    
    #Test3 
    li a0,0
    jal ra, EsPotenciaDeDos
    li a1,0
    bne a0,a1,noFuncionaEPDD
    #Test PotenciasEnArreglo 
    #Test1 
    la a0,arr
    lw a1,len
    jal ra, PotenciasEnArreglo
    li a1,3
    bne a0,a1,noFuncionaPEA
    
    #Test4 
    
    la a0,arr2
    lw a1,len2
    jal ra, PotenciasEnArreglo 
    li a1,1 
    bne a0,a1,noFuncionaPEA
    
    funcionaPEA:
        li a2, 1
    funiconaEPDD: 
        li a1, 1 
        j fin 
    
    noFuncionaEPDD: 
        li a1, 0
        j fin 
    noFuncionaPEA:
        li a2,0
        j fin    
               
    fin: j fin 
    
EsPotenciaDeDos: 
    addi sp,sp,-16 
    sw ra,0(sp) 
    
    beq a0,zero,NoEsPotenciaDeDos
    
    addi t0,a0,-1
    and a0, t0,a0
    beq a0, zero,esP2
    NoEsPotenciaDeDos: 
        li a0,0
        lw ra,0(sp)
        addi sp,sp,16
        ret
    esP2: 
        li a0,1
        lw ra,0(sp)
        addi sp,sp,16
        ret
PotenciasEnArreglo: 
    addi sp,sp,-16 
    sw ra,0(sp) 
    sw a0,4(sp)
    sw a1,8(sp)

    li t0,0        # i = 0
    li t1,0        # contador = 0  

while: 
    lw a0, 4(sp)   # base del arreglo
    lw a1, 8(sp)   # longitud
    beq t0,a1,termina

  
    slli t2, t0,2  # offset = i*4
    add t2, t2, a0 # direccion de arr[i]
    lw a0, 0(t2)   # cargar arr[i] en a0
    sw t0,12(sp)
    jal ra, EsPotenciaDeDos
    lw t0,12(sp)
    beq a0, zero, continuar

    addi t1, t1, 1 # contador++

continuar:
    addi t0, t0, 1 # i++
    j while 

termina: 
    mv a0,t1
    lw ra,0(sp)
    addi sp,sp,16
    ret 
