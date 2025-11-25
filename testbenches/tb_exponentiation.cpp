#include "Vexponentiation.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
  Vexponentiation *dut = new Vexponentiation;
  
  dut->clock = 0;
  dut->eval();
  
  dut->a = 153;
  dut->b = 206;
  dut->modulant = 245;
  dut->R_div_two = 128;
  dut->R_squared = 121;
  dut->set = 1;
  dut->clock = 1;
  dut->eval();
  
  printf("%d\n",dut->out);
 
  dut->set = 0;
  
  while(!dut->finished)
  {
  	dut->clock = 0;
  	dut->eval();
  	
  	dut->clock = 1;
  	dut->eval();
  	printf("%d\n", dut->out);
  }
  
  
  delete dut;
  exit(EXIT_SUCCESS);
}
