# get the rules recursively for files in subdirs
$(foreach SUBDIR,$(PYTHON3_SUBDIRS),$(eval include $(python3_DIR)/$(SUBDIR)/$(SUBDIR).mk))

$(python3_DIR)/func_results.jsonl: $(foreach SUBDIR,$(PYTHON3_SUBDIRS),$(python3_DIR)/$(SUBDIR)/func_results.jsonl)
	cat $^ > $@

$(python3_DIR)/perf_results.jsonl: $(python3_DIR)/func_results.jsonl
	for SUBDIR in $(PYTHON3_SUBDIRS); do \
		cd $(python3_DIR)/$${SUBDIR}; \
		make test; \
	done
	cat $(foreach SUBDIR,$(PYTHON3_SUBDIRS),$(python3_DIR)/$(SUBDIR)/perf_results.jsonl) > $@
