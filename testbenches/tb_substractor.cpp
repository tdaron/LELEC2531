#include "Vsubstractor.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
  Vsubstractor *dut = new Vsubstractor;

  dut->a = 6;
  dut->b = 7;
  dut->modulant = 9;
  dut->eval();
  assert(dut->out == 8);

  dut->a = 1;
  dut->b = 7;
  dut->modulant = 9;
  dut->eval();
  assert(dut->out == 3);

  dut->a = 6;
  dut->b = 3;
  dut->modulant = 9;
  dut->eval();
  assert(dut->out == 3);

  std::cout << "Substractor Test : done \n";
  delete dut;
  exit(EXIT_SUCCESS);
}
