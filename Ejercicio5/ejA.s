.data
# arreglo de números de 32 bits 
array:      .word 10, 20, 30, 40, 50        # Array original
esperado:   .word -10, -20, -30, -40, -50   # Inversos aditivos esperados
len:        .word 5

.text
.global main
.global inv
.global invArray

main:
    #Test INV
    li a0, 10 # argumento de entrada
    jal ra, inv
    li a1, -10  # valor esperado 
    bne a0,a1, noFuncionaInv
    # --- Llamada a invArray ---
    la a0, array      # Dirección base del arreglo original
    lw a1, len        # Largo del arreglo
    jal ra, invArray  # Ejecutar función invArray

    # --- Verificación: comparar array con esperado ---
    li t0, 0          # índice i = 0
    la t1, array      # dirección del array modificado
    la t2, esperado   # dirección del array esperado

verificar:
    lw t3, 0(t1)      # t3 = array[i]
    lw t4, 0(t2)      # t4 = esperado[i]
    bne t3, t4, noFuncionaInvArray

    addi t1, t1, 4    # avanzar en el array original
    addi t2, t2, 4    # avanzar en el array esperado
    addi t0, t0, 1
    lw t5, len
    blt t0, t5, verificar  # mientras i < len

    # Si llegó hasta acá es porque todos los valores son iguales
    funcionaInvArray:
        li a2, 1
    funcionaInv: 
        li a1,1
        j fin
noFuncionaInvArray:
    li a2, 0
    j fin
noFuncionaInv: 
    li a1,0 
    j fin 
fin:
    j fin

inv: 
    addi sp, sp,-16 # reservo 4 bytes en la pila 
    sw ra, 0(sp) # guardo la direccion de retorno en la pila 
     
    not a0,a0 # negacion bit a bit 
    addi a0,a0,1 # sumo 1 ~a0 
    
    lw ra,0(sp)  # restauro direccion de retorno 
    addi sp,sp,16 # borro espacio almacenado en la pila 
    ret  # return 
invArray: 
    addi sp,sp,-16 # reservo 4 bytes en la pila  
    sw ra,0(sp) # guardo la direccion de retorno en la pila  
    sw a0,4(sp) # guardo a0 en la pila porque tengo que restaurarlo luego de llama a inv
    li t0,0 # i = 0
    
    while: 
        beq t0,a1, terminar # si == len(arr) termina 
        slli t1,t0,2 # t1 offset 
        add t2, a0,t1 # t2 = base + offset 
        lw a0, 0(t2) # a0 = arr[i]
        jal ra, inv # llamada a funcion se pasa a0 como parametro 
        sw a0,0(t2) # arr[i] = -a0 
        lw a0,4(sp) # a0 = base del arreglo 
        addi t0,t0,1 # i += 1 
        j while  # while 
    terminar: 
        lw ra,0(sp) # direccion de retorno original 
        addi sp,sp,16  # borrar espacio reservado 
        ret  # return
    
     
    