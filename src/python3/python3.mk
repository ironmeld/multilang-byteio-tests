PY3_SUBDIRS = idiomatic1

# get the rules recursively for files in subdirs
$(foreach SUBDIR,$(PY3_SUBDIRS),$(eval include $(python3_DIR)/$(SUBDIR)/$(SUBDIR).mk))

$(python3_DIR)/func_results.jsonl: $(foreach SUBDIR,$(PY3_SUBDIRS),$(python3_DIR)/$(SUBDIR)/func_results.jsonl)
	cat $^ > $@

$(python3_DIR)/perf_results.jsonl: $(python3_DIR)/func_results.jsonl
	for SUBDIR in $(PY3_SUBDIRS); do \
		cd $(python3_DIR)/$${SUBDIR}; \
		make test; \
	done
	cat $(foreach SUBDIR,$(PY3_SUBDIRS),$(python3_DIR)/$(SUBDIR)/perf_results.jsonl) > $@
