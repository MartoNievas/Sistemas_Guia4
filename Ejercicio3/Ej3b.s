.text
.global <main>
.global FUNCION
.global FUNCION_AUX
main:  
    li a0, 3 # parametro
    li a1, 10 # parametro
    li a2, -5 # parametro
    li a3, 2 # parametro
    li a4, 5 # parametro
    li a5, -1 # parametro
    jal ra, FUNCION # llamado a la funcion 
    li a2, 1 # valor esperado de retorno 
    bne a0, a2, noFunciona # compara el valor de retorno no coincide con el esperado
funciona: 
    li a1, 1 # si funciona guarda a1 = 1 
    j fin
noFunciona: 
    li a1, 0 # si no funciona a0 = 0
fin: 
    j fin
FUNCION: #difrenciaTotalPositiva
    addi sp, sp, -32 #Prologo, reserva espacio en el stack 
    sw a2, (0)sp #Prologo, guarda a2 en el stack 
    sw s0, (4)sp #Prologo, guarda s0 en el stack 
    sw ra, (8)sp #guardo la direccion de retorno en el stack
    sw a3, 12(sp)
    sw a5, 16(sp) 
    li s0, 1 # cagra 1 en s0 
    mv a2, a4 # a2 = a4 
    jal ra, FUNCION_AUX # guarda el pc actual y salta a FUNCION_AUX
    lw a3, 12(sp) # Correcion
    lw a5, 16(sp) # Correcion
    bne a0, s0, return # a0 != 1 salta a return
    lw a0, (0)sp #carga el valor en esa direccion del stack en a0 = a2 
    mv a1, a3 # se copia el valor de a3 en a1 
    mv a2, a5 # se copia el valor de a5, a2
    jal ra, FUNCION_AUX # se guarda el PC actual y se salta a la FUNCION_AUX
     lw a3, 12(sp) # Correcion
    lw a5, 16(sp) # Correcion
    bne a0, s0, return # compra si a0 != 1
    lw s0, (4)sp #Epilogo, se restaura s0 
    lw ra, (8)sp #Epilogo, se restaura la direccion de retorno
    addi sp, sp, 32 #Epilogo, se borra el espacio almacenado en el stack 
    return: 
    ret # salta a la direccion de retorno en ra
FUNCION_AUX: #nombre difrenciasPostivias
    addi sp, sp, -4 #Prologo, Reserva espacio en el stack 
    sw ra, (0)sp #Prologo, guarda la direccion de retorno en el stack 
    sub a3, a2, a0 # a3 = a2 - a0 
    blt a3, zero, afuera # compara si a3 < 0
    sub a5, a2, a1 # a5 = a2 - a1 
    bgt a5, zero, afuera # compara si a5 < zero
    adentro: 
    li a0, 1 # si la diferencia es positiva cargo 1 en a0  
    j terminar #termino
    afuera:  
    li a0, 0 # si la diferecia es negativa cargo 0 en a0 
    terminar: # termina 
    lw ra, (0)sp #restauro la direccion de retorno 
    addi sp, sp, 4 # borro el espacio almacenado en la pila 
    ret # salto al la direccion de ra 
    
#Errores no presevar los valores de entrada a3 y a5 luego de la ejecucion de FUNCION_AUX
#