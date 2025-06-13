.text
.globl main
.globl FUNCION

main: 
    li a0, 4               # argumento de la funcion
    jal FUNCION            # llamado 
    li a1, 10              # valor esperado 
    bne a0, a1, noFunciona # compara resultado obtenido con el esperado 

funciona: 
    li a1, 1               # si funciona 1 en a1 
    j fin

noFunciona: 
    li a1, 0               # si no funciona 0 en a1 

fin: 
    j fin

FUNCION:                  # sumatoriaHastaN  
    addi sp, sp, -8        # prologo 
    sw a0, 0(sp)           # prologo 
    sw ra, 4(sp)           # prologo 

    beq a0, zero, casoBase # caso base 


    addi a0, a0, -1        # a0 = a0 - 1
    jal FUNCION            # llamado recursivo 

    lw t0, 0(sp)           # restaura el valor de a0 pero en a1 
    add a0, t0, a0         # FUNCION(a0) = a0 + FUNCION(a0 - 1)

    j epilogo              # salta al epilogo 

casoBase: 
    li a0, 0

epilogo: 
    lw ra, 4(sp)           # epilogo  
    addi sp, sp, 8         # epilogo 
    ret                    # return 
