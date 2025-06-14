busquedaBinariaIterativa: 
    addi sp,sp,-16 
    sw ra, 0(sp) 
    
    li t0, 0         # izq = 0 
    lw t1, len       # der = len
    addi t1, t1, -1  # der = len - 1
    
    mv t3, a0        # t3 = base del arreglo
    
while: 
    bgt t0, t1, noEsta    # salir si izq > der
    
    add t2, t0, t1        # t2 = izq + der
    srai t2, t2, 1        # t2 = (izq + der) / 2
    sw t2, 4(sp)          # guardar mid
    
    slli t4, t2, 2        # t4 = mid * 4
    add t4, t3, t4        # t4 = dirección arr[mid]
    lw t5, 0(t4)          # t5 = arr[mid]
    
    beq t5, a1, Esta      # si arr[mid] == elem, éxito
    blt t5, a1, Derecha   # si arr[mid] < elem, buscar derecha
    
Izq:
    lw t2, 4(sp)
    addi t1, t2, -1       # der = mid - 1
    j while

Derecha:
    lw t2, 4(sp)
    addi t0, t2, 1        # izq = mid + 1
    j while

noEsta:
    li a0, -1
    j epilogo

Esta:
    li a0, 1

epilogo:
    lw ra, 0(sp)
    addi sp, sp, 16
    ret
