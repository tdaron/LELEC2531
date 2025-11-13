setup:
	verilator -Wall --trace -cc modules/adder.sv --exe testbenches/tb_adder.cpp
	verilator -Wall --trace --top-module substractor -cc modules/substractor.sv modules/adder.sv --exe testbenches/tb_substractor.cpp

substractor:
	make -C obj_dir -f Vsubstractor.mk Vsubstractor
	./obj_dir/Vsubstractor

adder:
	make -C obj_dir -f Vadder.mk Vadder
	./obj_dir/Vadder

