.text 
.global main 
.global FUNCION 

main: 
    li a0, 13             # Prologo, argumento de la funcion 
    li a1, 5              # Prologo, argumento de la funcion
    jal FUNCION           # llamada a la funcion
    li a1, 3              # 13 mod(5) = 3, valor esperado 
    bne a0, a1, noFunciona # compara si el valor esperado es igual al obtenido 

funciona: 
    li a1, 1              # si funciona 1 en a1 
    j fin 

noFunciona: 
    li a1, 0              # si no funciona 0 en a1 

fin: 
    j fin                # fin del test 

FUNCION:                 # nombre de la funcion resto 
    addi sp,sp,-16 
    sw ra,0(sp) 
    sw a0,4(sp)
    blt a0, a1, terminar  # compara a0 < a1 si es asi salta a terminar 
    sub a0, a0, a1        # a0 = a0 - a1 
    jal FUNCION           # se llama a si misma 

terminar: 
    lw ra,0(sp) 
    addi sp,sp,16
    ret

