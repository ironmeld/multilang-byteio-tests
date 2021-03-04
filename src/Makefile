# Create performance test results for multiple languages

# The goal of the Makefile strategy for this project is that someone
# can run make at the top or in any subdirectory and it will build
# the default target for that directory. If you build in higher level
# directories it will build the lower level directories, and so on.
#
# But crucially, the Makefiles in this project do not use the technique of
# simply changing into each subdirectory and running "make" recursively.
# Recursive make considered harmful:
# http://www.real-linux.org.uk/recursivemake.pdf
#
# Instead, a single unified makefile is constructed by recursively including
# all .mk makefiles from a single .mk file located in the project top dir.
# The same makefile is created regardless of where in the directory structure
# you run make. The job of each directory Makefile is to simply include
# the top level include file (global.mk) and define a default target
# for the local directory.
# Exception: performance tests are intenionally serialized using recursive make.
# Exception: The clean target must be defined in each makefile


# TOPDIR in each Makefile provides the location of global.mk as a
# relative path from the directory where "make" is invoked (i.e. the
# current dir). TOPDIR is a relative path because it is easier to
# specify than computing the absolute path.
TOPDIR=.

# global.mk recursively includes all .mk files in the project.
# Each subdirectory must be defined in TOP_SUBDIRS in global_vars.mk
include global.mk

# global_default is all top level targets in all subdirs, recursively.
# The pipe (|) means the remaining deps are "order-only prerequisites" which
# means they build once but later timestamp updates do not rebuild dependents
default: $(global_default) | $(global_default_dirs)

# see global.mk for how perf_results.jsonl is built
test: $(TOPDIR)/func_results.jsonl
perftest: $(TOPDIR)/perf_results.jsonl
clean:
	rm -f func_results.jsonl
	rm -f perf_results.jsonl
	for SUBDIR in $(TOP_SUBDIRS); do \
		cd $${SUBDIR}; \
		make clean; \
	done
.PHONY: test perftest clean
