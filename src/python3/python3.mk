# The default target at each directory level is for building code.
# Each subdir should add their default targets to the parent
# default targets list. dirs are added separately because they
# are order-only - which basically means "build and then ignore"
python3_default =
python3_default_dirs =

# get the rules recursively for files in subdirs
$(foreach SUBDIR,$(PYTHON3_SUBDIRS),$(eval include $(python3_DIR)/$(SUBDIR)/$(SUBDIR).mk))

global_default += $(python3_default)
global_default_dirs += $(python3_default_dirs)

$(python3_DIR)/func_results.jsonl: $(foreach SUBDIR,$(PYTHON3_SUBDIRS),$(python3_DIR)/$(SUBDIR)/func_results.jsonl)
	cat $^ > $@

$(python3_DIR)/perf_results.jsonl: $(python3_DIR)/func_results.jsonl
	for SUBDIR in $(PYTHON3_SUBDIRS); do \
		cd $(python3_DIR)/$${SUBDIR}; \
		make test; \
	done
	cat $(foreach SUBDIR,$(PYTHON3_SUBDIRS),$(python3_DIR)/$(SUBDIR)/perf_results.jsonl) > $@
