.globl dot      # eixst negative multiple positive

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate   
    blt a4, t0, error_terminate  

    li t0, 0    # sum
    li t1, 0    # number of dot product processing

loop_start:
    bge t1, a2, loop_end
    # TODO: Add your own implementation
    # code start
    lw t2, 0(a0)
    lw t3, 0(a1)
    blt t3, t2, check   # t3 < t2 --> no need to change, go to check  |  else t3 >= t2 switch 
    mv t4, t2
    mv t2, t3
    mv t3, t4
check:
    beq t2, zero, next
    bge t2, zero, mul   # t2 >= 0 start mul, else both neg
    neg t2, t2
    neg t3, t3
mul:
    add t0, t0, t3
    addi t2, t2, -1
    bne t2, zero, mul
next:    
    slli t2, a3, 2
    slli t3, a4, 2
    add a0, a0, t2
    add a1, a1, t3
    addi t1, t1, 1
    j loop_start
    # code end
loop_end:
    mv a0, t0
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit
