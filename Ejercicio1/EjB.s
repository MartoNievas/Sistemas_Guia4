.text 
.global main 
.global FUNCION

main: 
    li a0, 1 # se carga como parametro de la funcion un inmediato de 32 bits
    li a1, 2 # lo mismo  
    jal ra, FUNCION # se guarda la direccion de retorno en ra y se salta a FUNCION
    li a3, 3 # se carga un inmediato de 32 bits en a3 
    bne a0, a3, noFunciona # (4*1 - 2/2) != 3 # si no son iguales salta a noFunciona
    li a0, 3 # carga un inmediato de 32 bits en a0 como parametor de la uncion
    jal ra, FUNCION # guarda la direccion de retorno en ra salta a FUNCION
    li a3, 11 # carga un inmediato de 32 bits en a3
    bne a0, a3, noFunciona # (4*3 - 2/2) != 11 # si no son iguales a0 ,a3 no funciona
    li a1, 12 # cargar un inmeditato de 32 bits es a1 
    jal ra, FUNCION # guarda la direccion de retorno en ra y salta a FUNCION
    li a3, 6 # carga un inmeidato de 32 bits en a3 
    bne a0, a3, noFunciona # (4*3 - 12/2) != 6 # si a0 y a3 no son iguales salta a noFunciona
funciona: li a1, 1 # si funciona carga 1 en a1 
    j fin # salta a fin
noFunciona: li a1, 0 # si no funciona carga 0 en a1
fin: j fin # termina la ejecucion del test
FUNCION: 
    addi sp, sp, -4 # se reserva un palabra en el stack, prologo
    sw ra, (0)sp # se guarda la direccion de retorno en el stack, prolgo 
    slli a2, a0, 2 # mutliplica por 4 al valor de a0 y lo guarda en a2 
    srai a1, a1, 1 # divide por 2 al valor de a1 y lo guarda en a1
    sub a0, a2, a1 # hace la operacion a2 - a1 y lo guarda en a0  
    lw ra, (0)sp # carga en ra la direccion de retorno almacenada en el stack, epilogo
    addi sp, sp, 4 # borra el espacio guardado en el stack, epilogo
    ret # salta a la direccion de retorno   