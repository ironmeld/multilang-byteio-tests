# Create performance test results for python3
python3_idiomatic1_default: $(PYTHON3_IDIOMATIC1_DIR)/results.jsonl

PYTHON=python3

$(PYTHON3_IDIOMATIC1_DIR)/results.jsonl:
	@if ! which ${PYTHON} > /dev/null; then echo "No $(PYTHON) in path."; exit 1; fi
	$(PYTHON) $(PYTHON3_IDIOMATIC1_DIR)/perftest.py > $@

install-internal-dependencies: py3-id1-install-byteio-internally
py3-id-install-byteio-internally:
	(cd $(PYTHON3_IDIOMATIC1_DIR); \
     git clone --depth=1 https://github.com/ironmeld/multilang-byteio; \
     mv multilang-byteio/src/python3/idiomatic1/byteio .; \
     rm -rf multilang-byteio;)
.PHONY: install-internal-dependencies install-byteio-internally

list-results_python3_idiomatic1:
	@echo $(PYTHON3_IDIOMATIC1_DIR)/results.jsonl
.PHONY: list-results_python3_idiomatic1

