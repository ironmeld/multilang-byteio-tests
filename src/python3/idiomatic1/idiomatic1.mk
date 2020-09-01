PYTHON=python3


$(python3_idiomatic1_DIR)/func_results.jsonl:
	touch $@

$(python3_idiomatic1_DIR)/perf_results.jsonl: $(python3_idiomatic1_DIR)/func_results.jsonl
	@if ! which ${PYTHON} > /dev/null; then echo "No $(PYTHON) in path."; exit 1; fi
	$(PYTHON) $(python3_idiomatic1_DIR)/perftest.py > $@

py3-id1-install-byteio-internally:
	(cd $(python3_idiomatic1_DIR); \
     git clone --depth=1 https://github.com/ironmeld/multilang-byteio; \
     mv multilang-byteio/src/python3/idiomatic1/byteio .; \
     rm -rf multilang-byteio;)
.PHONY: py3-id1-install-byteio-internally
# add my internal dependency to top target
install-internal-dependencies: py3-id1-install-byteio-internally


