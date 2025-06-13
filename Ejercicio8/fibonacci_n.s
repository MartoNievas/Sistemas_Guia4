.text 
.global main 
.global fibonacci_n 
main:
    li a0, 5      # x = 5
    li a1, 6      # n = 6 (tribonacci)
    jal ra, fibonacci_n

    # Resultado queda en a0 (esperado: 11)
    j fin

fin:
    j fin


fibonacci_n: 
    addi sp, sp, -16 
    sw ra, 0(sp) 
    sw s0, 4(sp)
    sw s1, 8(sp) 
    sw s2, 12(sp)
    
    
    #caso base 
    blt a0,a1, casoBase # x < n caso base  
    
    #caso recursivo
    mv s0,zero 
    li s1,1 
    mv s2, a0 
    
    loop: 
    bgt s1, a1, terminar 
    sub a0,s2,s1
    mv a1,a1
    jal ra fibonacci_n
    
    add s0,s0,a0
    addi s1,s1,1
    j loop 
    terminar: 
    mv a0,s0
    j epilogo
    
  
    
    casoBase: 
        j epilogo 
        
        
    epilogo: 
        lw ra, 0(sp) 
        lw s0,4(sp)
        lw s1, 8(sp) 
        lw s2, 12(sp)
        addi sp, sp, 16 
        ret 