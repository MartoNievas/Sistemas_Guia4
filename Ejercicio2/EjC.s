.text 
.global main 
.global mayor 

main: 
    #Test1
    li a0, 1 # x1 
    li a1, 1 # y1
    li a2, 1 # x2 
    li a3, 1 # y2
    jal ra, mayor
    li a4, 0 
    bne a4, a0, noFunciona
    #Test2
    li a0, 2
    li a1, 3
    li a2, 1
    li a3, 1 
    jal ra,mayor 
    li a4, 1 
    bne a4,a0,noFunciona
    #Test3 
    li a0, -2
    li a1, -3
    li a2, 1
    li a3, 1 
    jal ra,mayor 
    li a4, -1 
    bne a4,a0,noFunciona 
    
    funciona: 
        li a1, 1
        j fin 
        
    noFunciona:
        li a1,0 
        j fin 
    fin:
        j fin  
mayor: 
    addi sp,sp,-16 
    sw ra,0(sp) 
    
    bgt a0,a2,casoX1 # si x1 > x2 me salto a casoX1
    bgt a2,a1,casoX2 # si x2 > x1 salto a casoX2 
    j caso0 # si x1 == x2 salto al caso0 
    
    
    casoX1: 
        bgt a1,a3,casoY1 # si y1 > y2 sato casoY1
        j caso0
    casoY1: 
        li a0,1  # como x1 > x2 y y1 > y2 entonces cargo en a0 1 
        lw ra,0(sp) #Epilgo
        addi sp,sp,16 #Epilog 
        ret  # return 
    casoX2: 
        bgt a3,a1,casoY2 # si y2 > y1 salto a casoY2
        j caso0 # si y1 >= y2 caso 0 
    
    casoY2: 
        li a0, -1 # como x2 > x1 y y2 > y1 cargo -1 en a0 
        lw ra,0(sp) #Epilogo 
        addi sp,sp,16 # Epilogo
        ret  # return 
    
    caso0: 
        li a0,0 # ninguno de los otros dos caso entonces cargo 0 en a0 
        lw ra,0(sp) # Epilogo
        addi sp,sp,16 #Epilgo 
        ret #return 
    
    
    