# Create performance test results
TOPDIR=../..
# global.mk recursively includes all .mk files in the project
# including the ones in the current directory.
include $(TOPDIR)/global.mk

default:
functest: $(python3_idiomatic1_DIR)/func_results.jsonl
test: $(python3_idiomatic1_DIR)/perf_results.jsonl
clean:
	rm -f func_results.jsonl
	rm -f perf_results.jsonl
.PHONY: functest test clean
