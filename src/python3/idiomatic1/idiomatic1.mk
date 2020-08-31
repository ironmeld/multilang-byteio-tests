PYTHON=python3

python3_idiomatic1_default:
python3_idiomatic1_functest:
.PHONY: python3_idiomatic1_default python3_idiomatic1_functest

# add myself to parent deps
python3_default: python3_idiomatic1_default
python3_functest: python3_idiomatic1_default


# Create performance test results for python3
python3_idiomatic1_perftest: $(python3_idiomatic1_DIR)/results.jsonl

$(python3_idiomatic1_DIR)/results.jsonl:
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

list-results_python3_idiomatic1:
	@echo $(python3_idiomatic1_DIR)/results.jsonl
.PHONY: list-results_python3_idiomatic1

