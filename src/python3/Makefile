TOPDIR=..
# global.mk recursively includes all .mk files in the project
# including the ones in the current directory.
include $(TOPDIR)/global.mk

# the pipe (|) means the remaining deps are "order-only prerequisites"
# which means they build once but later timestamp updates do not rebuild dependents
default: $(python3_default) | $(python3_default_dirs)
test: $(python3_DIR)/func_results.jsonl
perftest: $(python3_DIR)/perf_results.jsonl
clean:
	rm -f func_results.jsonl
	rm -f perf_results.jsonl
	for SUBDIR in $(PYTHON3_SUBDIRS); do \
		cd $${SUBDIR}; \
		make clean; \
	done
.PHONY: test perftest clean
