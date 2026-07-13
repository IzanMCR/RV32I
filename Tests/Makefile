# Simulador a usar (instalamos icarus en el paso anterior)
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

COMPILE_ARGS += -g2012

# Agrega aquí el nombre de tu archivo de hardware (RTL)
VERILOG_SOURCES += ../RegFile.sv

# MODULE es el nombre de tu archivo de Python TESTBENCH (¡sin el .py!)
MODULE = RegFileTest

# Incluye la infraestructura de Cocotb para compilar todo
include $(shell cocotb-config --makefiles)/Makefile.sim