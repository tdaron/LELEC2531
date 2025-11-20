SRC_DIR      := modules
TB_DIR       := testbenches
OBJ_DIR      := obj_dir

SRCS         := $(wildcard $(SRC_DIR)/*)

VERILATOR    := verilator
VERILATOR_OPTS := -Wall --trace --cc


MODULES      := montgomery_reduce

all: $(MODULES)

$(MODULES):
	@echo "=== Building and running $@ ==="
	$(VERILATOR) $(VERILATOR_OPTS) --top-module $@ -cc $(SRCS) --exe $(TB_DIR)/tb_$@.cpp
	@$(MAKE) -C $(OBJ_DIR) -f V$@.mk V$@
	@./$(OBJ_DIR)/V$@

clean:
	rm -rf $(OBJ_DIR) *.log *.vcd

# Phony targets
.PHONY: all clean $(MODULES)
