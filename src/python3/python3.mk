PY3_SUBDIRS = idiomatic1

# subdirs should add deps to this target
python3_default:
python3_functest:
.PHONY: python3_default python3_functest

# get the default target (*_default) recursively for subdirs
$(foreach SUBDIR,$(PY3_SUBDIRS),$(eval include $(python3_DIR)/$(SUBDIR)/$(SUBDIR).mk))

python3_perftest:
	for SUBDIR in $(PY3_SUBDIRS); do \
		cd $(python3_DIR)/$${SUBDIR}; \
		make python3_$${SUBDIR}_perftest; \
	done
.PHONY: python3_perftest

list-results_python3: list-results_python3_idiomatic1
.PHONY: list-results_python3
