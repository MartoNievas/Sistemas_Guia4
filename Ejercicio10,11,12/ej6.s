.data 
tablaCalificaciones: .half 4321 #Id
                     .byte 5    #Nota
                     .half 9823 #Id
                     .byte 10   #Nota
                     .half 3458 #Id
                     .byte 7    #Nota
                     .half 2341 #Id 
                     .byte 3    #Nota 
                     .half 0 
 tablaCalificaciones1:.half 4322 #Id
                     .byte 5    #Nota
                     .half 9824 #Id
                     .byte 10   #Nota
                     .half 3456 #Id
                     .byte 7    #Nota
                     .half 2340 #Id 
                     .byte 3    #Nota 
                     .half 0 
.text 
.global main 
.global sumarNotasImpares 
.global esImpar 
#Calcular cuantos bytes ocupa en memoria la estructura InformacionAlumno
#La cantidad de bytes que ocupa la estructructura InformacionAlumno es 3 bytes 
#1 byte para la nota y 2 bytes para la id del alumno.
main:
    #Test1  
    la a0,tablaCalificaciones 
    jal ra, sumarNotasImpares 
    li a1,18 
    bne a0,a1, noFunciona 
    
    #Test2 
    la a0,tablaCalificaciones1
    jal ra, sumarNotasImpares
    li a1,0
    bne a0,a1,noFunciona
    funciona: 
        li a1,1 
        j fin 
    noFunciona: 
        li a1, 0 
        j fin 
    fin: j fin 
    
esImpar: # si a0 = 1 es impar, si a0 = 0 es par 
    addi sp,sp,-16 
    sw ra,0(sp) 
    
    andi a0,a0,1
    
    lw ra,0(sp)
    addi sp,sp,16
    ret     
    
sumarNotasImpares: 
     addi sp,sp,-16
     sw ra,0(sp) 
     sw a0,4(sp) 
     
     li t0,0 # i = 0 
     li t1,0 #contador= 0 
     mv t2,a0 # copiamos la direccion base del arreglo en t2 
     while: 

     lh t3,0(t2) #
     beq t3,zero, terminar # si el id es nulo salto a terminar 
     mv a0,t3 # si no lo paso como parametro a a0 
     jal ra, esImpar # compruebo si es par 
     
     bne a0,zero, casoImpar
     #caso par 
     
     addi t0,t0,3 
     add t2,t2, t0 
     j while 
     
     casoImpar: 
         lb t4, 2(t2) #cargamos la nota en t4
         add t1,t1,t4 # contador += nota 
         addi t0,t0,3 # i += 3 
         add t2,t2,t0 # direccion = offset + base  
         j while 
     terminar: 
     mv a0,t1
     lw ra ,0(sp) 
     addi sp,sp,16 
     ret 
     
     
     
