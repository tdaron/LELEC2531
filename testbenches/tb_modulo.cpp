#include "Vmodulo.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
  Vmodulo *dut = new Vmodulo;

  dut->a = 6;
  dut->modulant = 9;
  dut->eval();
  assert(dut->out == 6);

  dut->a = 16;
  dut->modulant = 9;
  dut->eval();
  assert(dut->out == 7);

  std::cout << "Modulo Test : done\n";
  delete dut;
  exit(EXIT_SUCCESS);
}
