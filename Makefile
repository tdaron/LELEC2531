run:
	verilator --binary main.sv -CFLAGS "-std=c++20 -fcoroutines"
	./obj_dir/Vmain
