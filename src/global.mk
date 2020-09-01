# Global makefile definitions
# All Makefiles in this project include this file.
#
# The default target imports and builds code if necessary.
# The test target runs func tests in parallel and then
# performance tests sequentially (top down).

# global vars and vars from subdirectories.
include $(TOPDIR)/global_vars.mk

.DEFAULT_GOAL := default

# subdirs may add their deps to this target
install-internal-dependencies:
.PHONY: install-internal-dependencies


GLOBAL_SUBDIRS = python3

# get the rules recursively for files in subdirs
$(foreach SUBDIR,$(GLOBAL_SUBDIRS),$(eval include $(TOPDIR)/$(SUBDIR)/$(SUBDIR).mk))


# Now properly sequence functional and performance tests.
# Functional dependencies can be run in parallel. Once complete,
# performance tests are run sequentially by recursively running
# make.
# (subdirs should not add deps to the following targets)

$(TOPDIR)/func_results.jsonl: $(foreach SUBDIR,$(GLOBAL_SUBDIRS),$(TOPDIR)/$(SUBDIR)/func_results.jsonl)
	cat $^ > $@

$(TOPDIR)/perf_results.jsonl:
	for SUBDIR in $(GLOBAL_SUBDIRS); do \
        cd $(TOPDIR)/$${SUBDIR}; \
        make test; \
    done
	cat $(foreach SUBDIR,$(GLOBAL_SUBDIRS),$(TOPDIR)/$(SUBDIR)/perf_results.jsonl) > $@


# To avoid these warnings, set the variables or run make like so:
# CLOUD_NAME="aws" CLOUD_INSTANCE_TYPE="m4.large" make
ifeq (${CLOUD_NAME},)
   $(warning CLOUD_NAME env. var is not set. Using 'unknown')
endif
ifeq (${CLOUD_INSTANCE_TYPE},)
   $(warning CLOUD_INSTANCE_TYPE env. var is not set. Using 'unknown')
endif
