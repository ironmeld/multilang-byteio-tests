# Global makefile definitions
# All Makefiles in this project include this file.
#
# The default target imports and builds code if necessary.
# The test target runs func tests in parallel and then
# performance tests sequentially (top down).

# global vars and vars from subdirectories.
include $(TOPDIR)/global_vars.mk

.DEFAULT_GOAL := default

# subdirs may add their deps to these targets
install-internal-dependencies:
global_default:
global_functest:
.PHONY: install-internal-dependencies global_default global_functest 


GLOBAL_SUBDIRS = python3

# get the default target (*_default) recursively for subdirs
$(foreach SUBDIR,$(GLOBAL_SUBDIRS),$(eval include $(TOPDIR)/$(SUBDIR)/$(SUBDIR).mk))


# Now properly sequence functional and performance tests.
# Functional dependencies can be run in parallel. Once complete,
# performance tests are run sequentially by recursively running
# make.
# (subdirs should not add deps to the following targets)

global_test: global_perftest
global_perftest: global_functest
	for SUBDIR in $(GLOBAL_SUBDIRS); do \
		cd $(TOPDIR)/$${SUBDIR}; \
		make $${SUBDIR}_perftest; \
	done
.PHONY: global_test global_perftest

# list the results file recursively for subdirs
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
