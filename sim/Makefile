SIM = icarus
TOPLEVEL_LANG = verilog

ifeq ($(SOLN), 1)
	PREFIX = solution/
endif

ifeq ($(INSTR_CHECK), 1)
	MODULE = test_instr
else
	MODULE = test_riscv
endif

VERILOG_SOURCES = $(PREFIX)../ver/processor.sv
COMPILE_ARGS += -I ../ver
TOPLEVEL = processor

include $(shell cocotb-config --makefiles)/Makefile.sim
