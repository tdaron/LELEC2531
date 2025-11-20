#include "Vmontgomery_reduce.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
  Vmontgomery_reduce *dut = new Vmontgomery_reduce;
  
  dut->t = 22*10;
  dut->R_minus_one = 255;
  dut->modulant = 183;
  dut->modulant_inv = 249;
  dut->bit_length = 8;
  dut->eval();
  printf("%d\n",dut->out);
  
  std::cout << "Jaaj\n";
  exit(EXIT_SUCCESS);
}
