.text 
.global main 
.global FUNCION


main: 
    li a0, 4 # parametro de entrada
    jal ra, FUNCION # llamado a la funcion 
    li a2, 10 # valor esperado 
    bne a0, a2, noFunciona # comparacion del valor esperado con el obtenido
funciona:  
    li a1, 1 # si funciona guardo 1 en a1 
    j fin # termino ejecucion del test 
noFunciona:  
    li a1, 0 # si no funciona guardo 0 en a1 
    fin: j fin # fin del test 
FUNCION: 
    addi sp, sp, -4 # Prologo, espacio en el stack 
    sw ra, (0)sp # prologo, se carga en memoria la direccion de retorno 
    mv a1, a0  # se mueve a0 a a1 
    mv a0, zero
    inicioCiclo: beq a1, zero, finCiclo
    add a0, a0, a1 # a0 = a0 + a1 
    addi a1, a1, -1 # se decrementa a1 
    j inicioCiclo # loop
    finCiclo: 
    lw ra, (0)sp # se restaura la direccion de retorno 
    addi sp, sp, 4 # se borra el espacio guardado en el stack 
    ret # vuelve a la direccion de retorno 
    
# errores: No se respeta la convencion del espacio del stack, ademas un uso incorrecto de los registro de argumento de funciones por parte del Progrmador B
# con cambiar el registro a3 por a0 funcionaria en la linea l1 a3, 4 por l1 a0, 4 
# nombre de la funcion sumatoriaNvecesN 
