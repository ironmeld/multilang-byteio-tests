# Create performance test results for python3
TARGET_python3_idiomatic1: $(PYTHON3_IDIOMATIC1_DIR)/results.jsonl

$(PYTHON3_IDIOMATIC1_DIR)/results.jsonl:
	python $(PYTHON3_IDIOMATIC1_DIR)/perftest.py > $@

# dependencies must be installed separately, they are included here for
# convenience.
install-dependencies-internal: | install-byteio-internal

install-byteio-internal:
	(cd $(PYTHON3_IDIOMATIC1_DIR); \
     git clone --depth=1 https://github.com/ironmeld/multilang-byteio; \
     mv multilang-byteio/src/python3/idiomatic1/byteio .; \
     rm -rf multilang-byteio;)

