setup:
	verilator -Wall --trace -cc modules/*.sv --exe testbenches/*.cpp

adder:
	make -C obj_dir -f Vadder.mk Vadder
	./obj_dir/Vadder

