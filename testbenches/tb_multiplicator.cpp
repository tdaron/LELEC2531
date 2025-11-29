#include "Vmultiplicator.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
  Vmultiplicator *dut = new Vmultiplicator;

  dut->a = 17;
  dut->b = 100;
  dut->modulant = 117;
  dut->R_div_two = 64;
  dut->R_squared = 4;
 
  dut->eval();
  
  printf("%d\n", dut->out);

  std::cout << "Multiplicator Test: done \n";
  delete dut;
  exit(EXIT_SUCCESS);
}
