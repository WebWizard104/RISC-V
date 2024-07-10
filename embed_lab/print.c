#include "print.h"

void print_str(const char *p, uint32_t *PORT)
{
  while (*p != 0){
    *PORT = *(p);
    p++ ;
  }
}

void print_hex(uint32_t val, int digits, uint32_t *PORT)
{
  for (int i = (4*digits)-4; i >= 0; i -= 4)
    *PORT = "0123456789ABCDEF"[(val >> i) % 16];
}
