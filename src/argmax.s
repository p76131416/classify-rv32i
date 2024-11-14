.globl argmax

.text
# =================================================================
# FUNCTION: Maximum Element First Index Finder
#
# Scans an integer array to find its maximum value and returns the
# position of its first occurrence. In cases where multiple elements
# share the maximum value, returns the smallest index.
#
# Arguments:
#   a0 (int *): Pointer to the first element of the array
#   a1 (int):  Number of elements in the array
#
# Returns:
#   a0 (int):  Position of the first maximum element (0-based index)
#
# Preconditions:
#   - Array must contain at least one element
#
# Error Cases:
#   - Terminates program with exit code 36 if array length < 1
# =================================================================
argmax:
    li t6, 1
    blt a1, t6, handle_error

    lw t0, 0(a0)    #the first biggest element

    li t1, 0    # answer pos
    li t2, 1    # number of elements till current
loop_start:
    # TODO: Add your own implementation below
    # code start
    beq t2, a1, done
    addi a0, a0, 4
    lw t4, 0(a0)
    blt t0, t4, greater
    addi t2, t2, 1
    j loop_start
greater:
    mv t1, t2
    mv t0, t4
    addi t2, t2, 1
    j loop_start
done:
    mv a0, t1
    jr ra
    # code end
handle_error:
    li a0, 36
    j exit
