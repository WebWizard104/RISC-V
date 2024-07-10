SIM = icarus
TOPLEVEL_LANG = verilog

ifeq ($(TEST_MODULE),)
	top = ifu
	VERILOG_SOURCES = ../ver/$(top).sv 
else
	top = $(TEST_MODULE)
	VERILOG_SOURCES = ../ver/$(top).sv
endif

TOPLEVEL = $(top)
MODULE = test_$(top)
COMPILE_ARGS += -I ../ver
include $(shell cocotb-config --makefiles)/Makefile.sim

.PHONY: ${SIM_BUILD}/sim.vvp ${SIM_BUILD}/cocotb_iverilog_dump.v
