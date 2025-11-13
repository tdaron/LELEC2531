#include "Vmodulo.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
  Vmodulo *dut = new Vmodulo;
  dut->eval();
  std::cout << "done \n";
  delete dut;
  exit(EXIT_SUCCESS);
}
