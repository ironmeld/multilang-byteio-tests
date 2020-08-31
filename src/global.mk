# Global makefile definitions
# All Makefiles in this project include this file.

# global vars and vars from subdirectories.
include $(TOPDIR)/global_vars.mk

# get the default target (*_default) from each subdirectories' makefiles
include $(TOPDIR)/python3/python3.mk

global_default: python3_default
.PHONY: global_default

# builds the top target for each top level subdirectory
list-results: list-results_python3
.PHONY: list-results

# To avoid these warnings, set the variables or run make like so:
# CLOUD_NAME="aws" CLOUD_INSTANCE_TYPE="m4.large" make
ifeq (${CLOUD_NAME},)
   $(warning CLOUD_NAME env. var is not set. Using 'unknown')
endif
ifeq (${CLOUD_INSTANCE_TYPE},)
   $(warning CLOUD_INSTANCE_TYPE env. var is not set. Using 'unknown')
endif

