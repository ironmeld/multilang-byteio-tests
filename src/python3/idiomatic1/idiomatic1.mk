# Create performance test results for python3
python3_idiomatic1_default: $(PYTHON3_IDIOMATIC1_DIR)/results.jsonl

PYTHON=python3

$(PYTHON3_IDIOMATIC1_DIR)/results.jsonl:
	@if ! which ${PYTHON} > /dev/null; then echo "No $(PYTHON) in path."; exit 1; fi
	$(PYTHON) $(PYTHON3_IDIOMATIC1_DIR)/perftest.py > $@

install-dependencies-internal: | install-byteio-internal
install-byteio-internal:
	(cd $(PYTHON3_IDIOMATIC1_DIR); \
     git clone --depth=1 https://github.com/ironmeld/multilang-byteio; \
     mv multilang-byteio/src/python3/idiomatic1/byteio .; \
     rm -rf multilang-byteio;)
.PHONY: install-dependencies-internal install-byteio-internal

list-results_python3_idiomatic1:
	@echo $(PYTHON3_IDIOMATIC1_DIR)/results.jsonl
.PHONY: list-results_python3_idiomatic1

