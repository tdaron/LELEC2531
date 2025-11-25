#include "Vmultiplicator.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
  Vmultiplicator *dut = new Vmultiplicator;

  dut->a = 185;
  dut->b = 209;
  dut->modulant = 213;
  dut->R_div_two = 128;
  dut->R_squared = 145;
 
  dut->eval();
  
  printf("%d\n", dut->out);

  std::cout << "Multiplicator Test: done \n";
  delete dut;
  exit(EXIT_SUCCESS);
}
