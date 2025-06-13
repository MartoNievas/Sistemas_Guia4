.text
.global <main>
.global FUNCION
.global FUNCION_AUX
main: 
    #Test 1 
    li a0, 4 # parametro 1 
    li a1, 87 # parametro 2 
    li a2, -124 # parametro 3
    li a3, -14 # parametro 4 
    jal ra, FUNCION # llamado a la funcion FUNCION
    li a2, -124 # valor esperado 
    bne a0, a2, noFunciona # si el valor de retorno es distinto al esperado no funciona
funciona: 
    li a1, 1 # si funciona a1 = 1 
    j fin # termina 
    noFunciona:  
    li a1, 0 # si no funciona a1 = 0 
    fin:  
    j fin # termina 
FUNCION: #nombre elMenorDeLos4
    addi sp, sp, -16 #Prologo, guarda 12 bytes en el stack 
    sw a2, (0)sp  #Prologo, se guarda en el stack a2 
    sw a3, (4)sp  #Prologo, se guarda en el stack a3
    sw ra, (8)sp  #Prologo, se guarda direccion de retorno en el stack
    sw s1, (12)sp #Prologo, se guarda la direccion de retorno de FUNCION
    jal ra, FUNCION_AUX # guarda el pc actual en ra y salta a FUNCION_AUX
    mv s1, a0 # copiamos el valor de s1 en a0
    lw a0, (0)sp # se guarda a0 en el stack 
    lw a1, (4)sp # se gurada a1 en el stack 
    jal ra, FUNCION_AUX # gurada la direccion de retorno actual 
    mv a1, s1
    jal ra, FUNCION_AUX # guarda la direccion de retorno actual 
    lw ra, (8)sp #Epilogo, se carga la direccion de retorno original 
    lw s1, 12(sp) #Epilogo, Correccion 
    addi sp, sp, 12 #Epilogo, se borra el espacio reservado de la pila 
    ret # se salta a la direccion de retorno 
FUNCION_AUX: #nombre menor
    addi sp, sp, -4 #Prologo, se guarda 4 bytes mas en el stack 
    sw ra, (0)sp #Prologo, se guarda el pc de jal ra, FUNCION_AUX en el stack 
    bgt a1, a0, terminar # si a1 > a0 salta a terminar 
    mv a0, a1 # copia el valor de a1 en a0 
    terminar: 
    lw ra, 0(sp) #Epilogo 
    addi sp,sp,4 # Epilogo 
    ret # salta 
    
    

#Errores en la funcion auxiliar cuando se reserva espacio en el stack antes de finalizar
# no se borra el espacio reservado
# En la funcion no se conserva el valor de s1 


