#pragma once

#include <stdint.h>

void print_str(const char *p, uint32_t *PORT);
void print_hex(uint32_t val, int digits, uint32_t *PORT);
