#include "Vmontgomery_reduce.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
  Vmontgomery_reduce *dut = new Vmontgomery_reduce;

  dut->t = 3744;
  dut->modulant = 18;
  dut->R_div_two = 32 >> 1;
  
  dut->eval();
  
  printf("%d\n",dut->out);

  std::cout << "Reductor Test: done \n";
  delete dut;
  exit(EXIT_SUCCESS);
}
