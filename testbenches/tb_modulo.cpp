#include "Vmodulo.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
  Vmodulo *dut = new Vmodulo;
  
  dut->clk = 0;
  dut->eval();
  
  dut->clk = 1;
  dut->a = 63;
  dut->modulant = 7;
  dut->start = 1;
  dut->eval();
  dut->clk = 0;
  dut->start = 0;
  dut->eval();
  while(!dut->done)
  {	
  	dut->clk = 1;
  	dut->eval();
  	printf("%d\n",dut->out);
  	dut->clk = 0;
  	dut->eval();
  }
  printf("\n");
  
  dut->clk = 1;
  dut->a = 63;
  dut->modulant = 8;
  dut->start = 1;
  dut->eval();
  dut->clk = 0;
  dut->start = 0;
  dut->eval();
  while(!dut->done)
  {	
  	dut->clk = 1;
  	dut->eval();
  	printf("%d\n",dut->out);
  	dut->clk = 0;
  	dut->eval();
  }
  printf("\n");
  
  

  std::cout << "Modulo Test : done\n";
  delete dut;
  exit(EXIT_SUCCESS);
}
