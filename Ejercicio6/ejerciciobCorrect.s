.text
.global main
.global FUNCION

main: 
    li a0, 4             # argumento de la función
    jal FUNCION          # llamada a la función
    li a1, 5             # valor esperado
    bne a0, a1, noFunciona

    li a0, 5
    jal FUNCION
    li a1, 8
    bne a0, a1, noFunciona

    li a0, 6
    jal FUNCION
    li a1, 13
    bne a0, a1, noFunciona

funciona:
    li a1, 1             # todo funcionó
    j fin

noFunciona:
    li a1, 0             # algo falló

fin:
    j fin

# FUNCION(n) = Fibonacci(n), con base: FUNCION(0) = 1, FUNCION(1) = 1
FUNCION:
    addi sp, sp, -16
    sw ra, 12(sp)        # guardar return address
    sw s0, 8(sp)         # guardar s0
    sw s1, 4(sp)         # guardar s1
    sw s2, 0(sp)         # guardar s2

    li t0, 0
    beq a0, t0, casoBase
    li t0, 1
    beq a0, t0, casoBase

    mv s0, a0            # guardar a0 en s0

    addi a0, s0, -1
    jal FUNCION
    mv s1, a0            # s1 = FUNCION(n-1)

    addi a0, s0, -2
    jal FUNCION
    mv s2, a0            # s2 = FUNCION(n-2)

    add a0, s1, s2       # a0 = s1 + s2
    j epilogo

casoBase:
    li a0, 1
    j epilogo

epilogo:
    lw ra, 12(sp)
    lw s0, 8(sp)
    lw s1, 4(sp)
    lw s2, 0(sp)
    addi sp, sp, 16
    ret
