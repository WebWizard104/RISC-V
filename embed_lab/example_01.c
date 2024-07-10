#include "print.h"
#include <stdint.h> /// we need standard integer definitions like uint32_t
#include <math.h>   /// we need round() function from math library

uint32_t stdout_buffer[1024];

#define STDOUT_ADDR (&stdout_buffer[0])

uint32_t *stdout_port = (uint32_t *) STDOUT_ADDR;

int main () {

    print_str("Hello World! I am here at: 0x", stdout_port);    
    return 0;
}


