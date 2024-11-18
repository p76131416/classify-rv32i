# Assignment 2: Classify

This is a project and assignment focused on building an Artificial Neural Network (ANN) for recognizing handwritten digits.
As part of this, I will implement various functions such as dot product, matrix multiplication, and file operations.

Next, I will explain the functionality of each implemented function and discuss the challenges encountered during their
implementation.

## abs.s

This is a function designed to calculate the absolute value.

The input is the memory address of an integer.

First, the value at the address is loaded into a register. If the value is greater than 0, it is returned as is; otherwise,
it is converted to its positive equivalent, stored back at the memory address, and then returned.

## argmax.s
This is a function designed to scan an integer array to find its maximum value and returns the position of its first
occurrence.

The inputs are the pointer to the first element of the array and number of elements in the array.

First, the function checks whether all numbers have been processed. If so, it jumps to the `done` label, storing the final answer in the return register. Otherwise, it loads the next number and compares it with the current maximum. If the current number is greater, the function jumps to the `greater` label, updates the maximum value to the current number, stores its position, and then returns to the `loop_start` label. This process continues until all numbers have been checked.

## relu.s
This is a function designed to find each element x in array where x equal to max(0, x).

The inputs are the pointer to integer array and number of elements in array.

First, the function checks if the counter has iterated through all the numbers. If true, it branches to the `done` label and returns to the address  stored at the return address. Otherwise, it loads the next number and evaluates whether it is less than 0. If the condition is met, it branches to the `get_max` label, writes 0 to the memory location currently pointed to, and updates both the pointer and the counter. If the number is not less than 0, it directly increments the pointer and counter. This loop continues until all numbers are processed.

## dot.s
This is a function designed to operate strided dot product.

The input includes the number of elements to process and the starting addresses of two arraies, along with their skip distance.

First, the function checks if `t3` is less than `t2`. If `t3` is greater than `t2`, their values are swapped. Otherwise, it jumps to the `check` label to evaluate the relationship between `t2` and `zero`. If `t2` equals `zero`, the current pair of numbers is skipped. If `t2` is greater than `zero`, the function directly proceeds to the `mul` label for multiplication. If `t2` is less than `zero`, both values are negated before performing the multiplication. Finally, the function updates the numbers to be loaded based on the specified stride for each input, continuing the process until the entire array is processed.

- **Problem encountered**

Initially, I used a counter to track the number of times the multiplicand was accumulated. However, because I didn't account for negative numbers, the loop would get stuck during the multiplication process.

- **overcome**

To debug this, I used `print_int_array` to print the matrices step by step, which eventually led me to identify that the issue was in the dot product implementation. I resolved this by ensuring that the multiplier was greater than or equal to the multiplicand for multiplication to proceed. If the multiplier was non-negative, the multiplication proceeded directly. If the multiplier was negative, both values were negated before performing the multiplication. I also changed the test cases in `unittests.py` related to dot product calculations to verify the correctness of the newly implemented function.

## matmul.s
This is a function designed to operate matrix multiplication.

The input includes the starting addresses of two matrices, along with their number of rows and columns.

The output is the starting address of the result address.

This function uses a nested loop structure to perform matrix multiplication. The `outer_loop` iterates through the rows of the multiplier matrix, exiting the function once all rows have been processed. Otherwise, it proceeds to the `inner_loop`. Within the `inner_loop`, the rows of the multiplier matrix and the columns of the multiplicand matrix are multiplied using the previously implemented dot function. This continues until every column of the multiplicand matrix has been multiplied with each row of the multiplier matrix.

## read_matrix.s
This is a function designed to load matrix data from a binary file into dynamically allocated memory.

The inputs are pointer to filename string and address to write row and column count.

The output is base address of loaded matrix.

This function calls multiple routines, such as `fopen`, `fread`, and `fclose`, to read matrix data from a binary file.


## write_matrix.s
This is a function designed to write a matrix of integers to a binary file

The input includes pointer to a string representing the filename, pointer to the matrix's starting location in memory and number of rows and columns in the matrix.

This function calls multiple routines, such as `fopen`, `fwrite`, and `fclose`, to write matrix data to a binary file.
