#include "Vsubstractor.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
  Vsubstractor *dut = new Vsubstractor;
  dut->a = 9;
  dut->b = 7;
  dut->eval();
  printf("out: %d\n", dut->out);
  assert(dut->out == 2);
  std::cout << "done \n";
  delete dut;
  exit(EXIT_SUCCESS);
}
