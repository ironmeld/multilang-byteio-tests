# Global makefile definitions
# All Makefiles in this project include this file.
#
# The default target imports and builds code if necessary.
# The test target runs func tests in parallel and then
# performance tests sequentially (top down).

# global vars and vars from subdirectories.
include $(TOPDIR)/global_vars.mk

.DEFAULT_GOAL := default

# The default target at each directory level is for building code.
# Each subdir should add their default targets to the parent
# default targets list. dirs are added separately because they
# are order-only - which basically means "build and then ignore"
global_default =
global_default_dirs =

# get the rules recursively for files in subdirs
$(foreach SUBDIR,$(TOP_SUBDIRS),$(eval include $(TOPDIR)/$(SUBDIR)/$(SUBDIR).mk))

# Important:
# Performance tests are run sequentially by recursively running  make test.
# However, before that functional tests must be completed. (Perf results depends on func results)
# Rules for functional tests are designed to be run in parallel.

$(TOPDIR)/func_results.jsonl: $(foreach SUBDIR,$(TOP_SUBDIRS),$(TOPDIR)/$(SUBDIR)/func_results.jsonl)
	cat $^ > $@

$(TOPDIR)/perf_results.jsonl: $(TOPDIR)/func_results.jsonl
	for SUBDIR in $(TOP_SUBDIRS); do \
		cd $(TOPDIR)/$${SUBDIR}; \
		make test; \
	done
	cat $(foreach SUBDIR,$(TOP_SUBDIRS),$(TOPDIR)/$(SUBDIR)/perf_results.jsonl) > $@


# To avoid these warnings, set the variables or run make like so:
# CLOUD_NAME="aws" CLOUD_INSTANCE_TYPE="m4.large" make
ifeq (${CLOUD_NAME},)
   $(warning CLOUD_NAME env. var is not set. Using 'unknown')
endif
ifeq (${CLOUD_INSTANCE_TYPE},)
   $(warning CLOUD_INSTANCE_TYPE env. var is not set. Using 'unknown')
endif
