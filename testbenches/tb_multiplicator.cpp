#include "Vmultiplicator.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
  Vmultiplicator *dut = new Vmultiplicator;

  dut->a = 6;
  dut->b = 7;
  dut->modulant = 9;
  dut->eval();
  assert(dut->out == 6);

  dut->a = 1;
  dut->b = 7;
  dut->modulant = 9;
  dut->eval();
  assert(dut->out == 7);

  dut->a = 6;
  dut->b = 3;
  dut->modulant = 9;
  dut->eval();
  assert(dut->out == 0);

  std::cout << "Multiplicator Test: done \n";
  delete dut;
  exit(EXIT_SUCCESS);
}
