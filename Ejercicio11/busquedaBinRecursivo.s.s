.data 
arr: .word  1,2,3,4,5,6 


.text 
.global main 
.global busquedaBinRec 

main: 
    la a0,arr #direccion  
    li a1 6  # elemento e 
    li a2, 0 # izq = 0 
    li a3, 5 # der = len(arr) - 1 
    jal ra, busquedaBinRec
    li a1, 1
    bne a0,a1,noFunciona 
    
    funciona: 
    li a1,1
    j fin 
    
    noFunciona: 
    li a1, 0 
    j fin 
    
    fin: j fin 
    
    
    
busquedaBinRec: 
    addi sp,sp,-16 
    sw ra, 0(sp) 
    sw a0, 4(sp) 
    
    bgt a2,a3,noEsta # si izq >= der entonces no esta  
    #caso contrario 
    #calculo mid 
    add t0,a2,a3 # t0 = izq + der 
    srai t4,t0,1 # t0 = (izq + der) // 2 calculo el mid 
    
    #Ahora buscamos la posicione de memoria del mid 
    
    slli t3,t4,2 # offset = t0 * 4 
    add t2,a0,t3 # direccion arr[i] = base + offset 
    lw t1,0(t2) # ti = arr[mid] 
    
    beq t1,a1,esta # si arr[mid] == e entonces esta  
    # caso contrario me fijo 
    bgt t1,a1, izquierda  # arr[mid] > e entonces esta a la izquierda 
    #si no se cumple entonces esta en la derecha por lo que 
    #izq = mid + 1 y der = der 
 
    addi a2,t4,1 # a2 = mid + 1 
    jal ra, busquedaBinRec 
    
    j epilogo
    
    izquierda: 
    #Entonces izq = 0, der = mid - 1      
 
    addi a3,t4,-1 # a3 = mid - 1 
    jal ra, busquedaBinRec 
    j epilogo 
    esta: 
        li a0, 1
        j epilogo 
    
    noEsta: 
        li a0,0 
 
        
    epilogo: 
        lw ra,0(sp) 
        addi sp,sp,16 
        ret 
    
