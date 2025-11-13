#include "Vadder.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
  Vadder *dut = new Vadder;
  dut->a = 6;
  dut->b = 7;
  dut->eval();
  assert(dut->out == 13);
  std::cout << "done \n";
  delete dut;
  exit(EXIT_SUCCESS);
}
