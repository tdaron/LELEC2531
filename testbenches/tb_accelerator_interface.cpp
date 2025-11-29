#include "Vaccelerator_interface.h"
#include <iostream>
#include <stdlib.h>
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, char **argv, char **env) {
  Vaccelerator_interface *dut = new Vaccelerator_interface;
  
  dut->clk = 0;
  dut->eval();
  dut->a = 5;
  dut->b = 6;
  dut->modulant = 7;
  dut->start = 0;
  dut->control = 0;
  dut->clk = 1;
  dut->eval();
  printf("%d %d\n",dut->result,dut->finished);
  std::cout << "Interface Adder Test : done \n";
  
  dut->clk = 0;
  dut->eval();
  dut->a = 5;
  dut->b = 6;
  dut->modulant = 7;
  dut->start = 0;
  dut->control = 1;
  dut->clk = 1;
  dut->eval();
  printf("%d %d\n",dut->result,dut->finished);
  std::cout << "Interface Sub Test : done \n";
  
  dut->clk = 0;
  dut->eval();
  
  dut->clk = 1;
  dut->modulant = 185;
  dut->a = 3;
  dut->b = 249,
  dut->control = 2;
  dut->start = 1;
  dut->eval();
  dut->clk = 0;
  dut->start = 0;
  dut->eval();
  while(!dut->finished)
  {	
  	dut->clk = 1;
  	dut->eval();
  	printf("%d %d\n",dut->result,dut->finished);
  	dut->clk = 0;
  	dut->eval();
  }
  std::cout << "Interface Mod Test : done \n";
  
  dut->modulant = 117;
  dut->start = 1;
  dut->control = 3;
  dut->clk = 1;
  dut->eval();
  dut->clk = 0;
  dut->start = 0;
  dut->eval();
  while(!dut->finished)
  {
    dut->clk = 1;
  	dut->eval();
  	dut->clk = 0;
  	dut->eval();
  }
  std::cout << "Interface R steup Test : done \n";
  
  dut->a = 100;
  dut->b = 17;
  dut->control = 4;
  dut->eval();
  printf("%d %d\n",dut->result, dut->finished);
  std::cout << "Interface Mult Test : done \n";
  
  dut->clk = 1;
  dut->start = 1;
  dut->control = 5;
  dut->eval();
  dut->clk = 0;
  dut->start = 0;
  dut->eval();
  while(!dut->finished)
  {	
  	dut->clk = 1;
  	dut->eval();
  	printf("%d %d\n",dut->result,dut->finished);
  	dut->clk = 0;
  	dut->eval();
  }
  std::cout << "Interface Exp Test : done \n";
  
  
  delete dut;
  exit(EXIT_SUCCESS);
}
