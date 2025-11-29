#include "VR_computation.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
  VR_computation *dut = new VR_computation;
  
  dut->clk = 0;
  dut->eval();
  
  dut->clk = 1;
  dut->modulant = 116;
  dut->start = 1;
  dut->eval();
  dut->clk = 0;
  dut->start = 0;
  dut->eval();
  while(!dut->done)
  {	
  	dut->clk = 1;
  	dut->eval();
  	printf("%d %d %d\n",dut->R_div_2, dut->R_square, dut->md_done);
  	dut->clk = 0;
  	dut->eval();
  }
  printf("Test Done\n\n");
  
    
  dut->clk = 1;
  dut->modulant = 53;
  dut->start = 1;
  dut->eval();
  dut->clk = 0;
  dut->start = 0;
  dut->eval();
  while(!dut->done)
  {	
  	dut->clk = 1;
  	dut->eval();
  	printf("%d %d %d\n",dut->R_div_2, dut->R_square, dut->md_done);
  	dut->clk = 0;
  	dut->eval();
  }
  printf("Test Done\n\n");

  std::cout << "Multiplicator setup Test : done\n";
  delete dut;
  exit(EXIT_SUCCESS);
}
