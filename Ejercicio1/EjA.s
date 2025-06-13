.text 
.global main 
.global FUNCION

main: 
li s1, 2024 # se carga un inmediato de 32 bits al registro s1 
mv a0, s1 # se mueve el valor de s1 a a0 
jal ra, FUNCION # se guarda en ra el pc actual y salta a la funcion 
add a0, s1, a0 # cuando retorna se suma el valor de retorno con s1 y se guarda en a0
bnez a0, noFunciona # si el resultado es distinto de 0 salta el pc de noFunciona
funciona: li a1, 1 # se carga 1 en a1 simbolizando que funciono 
j fin  # termina la ejecucion del test
noFunciona: li a1, 0 # se carga 0 en a1 simbolizando que no funciona 
fin: j fin # por utlimo se queda en un loop infinito 
# en el test se evalua si el resultado de la funcion + el parametro de entrada es
# igual a 0 
FUNCION: 
    addi sp, sp, -4  # prologo se reservan espacio en el stack 
    sw ra, (0)sp # se guarda la direccion de retorno en el stack, prologo
    not s1, a0 # se calcula ~a0 y se guarda en s1, error no se esta guardando en el stack
    addi a0, s1, 1 # se suma a ~a0 y se guarda en a0 
    lw ra, (0)sp # se carga la direccion de retorno en ra, epilogo
    addi sp, sp, 4 # se borra el espacio reservado, epilgo 
    ret # se retorno el valor de salida en a0 y se salta a ra,epilogo


# Nombre declarativo para la funcion inverso aditivo
# Error: no se preserva el valor del registro s1 en la funcion, por lo tanto es culpa 
# del porgramador A

# El error se soluciona reservando mas espacio en la pila addi sp, sp, -8, luego
# poniendo sw s1, 4(sp), por ultimo antes del res hacer lw s1,4(sp) 
    
    
            