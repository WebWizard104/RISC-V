
#ifndef EMBEDDED
#include <stdio.h>
#endif
#include "print.h"
#include <stdint.h> /// we need standard integer definitions like uint32_t
#include <math.h>   /// we need round() function from math library

uint32_t stdout_buffer[1024];

#define STDOUT_ADDR (&stdout_buffer[0])

uint32_t *stdout_port = (uint32_t *) STDOUT_ADDR;


int multiply(int a, int b)
{
    //int result = 0;
    //while(b--)
    //{
    //    result += a;
    //}
	
    return a*b;
}

int multiply_n_acc(int acc, int a, int b)
{
    acc += multiply(a, b);
    return acc;
}

int scale_multiply_n_acc(int acc, int s, int *a, int *b)
{
    (*a) = multiply((*a), s);
    (*b) = multiply((*b), s);
    acc += multiply((*a), (*b));
    return acc;
}

#define VECTOR_LENGTH (100)

void test(int scalar_alpha, int *vector_a, int *vector_b)
{
    int sum_of_square = 0;
    int i;
    int vector_len = VECTOR_LENGTH;
    
    // Correct loop
    sum_of_square = 0;
    for(i = 0; i < vector_len; i++)
    {
        sum_of_square = multiply_n_acc(sum_of_square, vector_a[i], vector_b[i]);
    }

#ifndef EMBEDDED
    printf("Sum of squares is : %d\n", sum_of_square);
#endif

    // Faulty loop
    sum_of_square = 0;
    for(i = vector_len; i > 0; i--)
    {
        sum_of_square = multiply_n_acc(sum_of_square, vector_a[i], vector_b[i]);
    }

#ifndef EMBEDDED
    printf("Sum of squares is : %d\n", sum_of_square);
#endif

    // Faulty loop corrected
    sum_of_square = 0;
    for(i = (vector_len-1); i >= 0; i--)
    {
        sum_of_square = multiply_n_acc(sum_of_square, vector_a[i], vector_b[i]);
    }

#ifndef EMBEDDED
    printf("Sum of squares is : %d\n", sum_of_square);
#endif

    // Stack corruption loop
    sum_of_square = 0;
    for(i = vector_len; i > 0; i--)
    {
        sum_of_square = scale_multiply_n_acc(sum_of_square, scalar_alpha, &vector_a[i], &vector_b[i]);
    }

#ifndef EMBEDDED
    printf("Sum of squares is : %d\n", sum_of_square);
#endif

    // print_str("Sum of square numbers is: 0x", stdout_port);
    // print_hex(sum_square, 8,  stdout_port);
    // print_str("\n", stdout_port);
}

int main ()
{
    int scalar_alpha = 10;
    int vector_a[10];
    int vector_b[10];
    int sum_of_square = 0;
    int i;
    int vector_len = VECTOR_LENGTH; // sizeof(vector_a)/sizeof(vector_a[0])

    // initialize vectors
    for(i = 0; i < VECTOR_LENGTH; i++)
    {
        vector_a[i] = i;
        vector_b[i] = i;
    }

    test(scalar_alpha, vector_a, vector_b);
    
    return 0;
}


