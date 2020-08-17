# Global makefile definitions
# All Makefiles in this project include this file.

# global vars and vars from subdirectories.
include $(TOPDIR)/global_vars.mk

# get the top target (TARGET_*) from each subdirectories' makefiles
include $(TOPDIR)/python3/python3.mk

# builds the top target for each top level subdirectory
TARGET_global: TARGET_python3
.PHONY: TARGET_global
