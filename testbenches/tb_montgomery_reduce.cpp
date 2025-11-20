#include "Vmontgomery_reduce.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
  Vmontgomery_reduce *dut = new Vmontgomery_reduce;


  std::cout << "Reductor Test: done \n";
  delete dut;
  exit(EXIT_SUCCESS);
}
