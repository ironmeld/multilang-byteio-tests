PYTHON=python3

# The default target at each directory level is for building code.
# Each subdir should add their default targets to the parent
# default targets list. dirs are added separately because they
# are order-only - which basically means "build and then ignore"
python3_idiomatic1_default = 
python3_idiomatic1_default_dirs = $(python3_idiomatic1_DIR)/byteio

python3_default += $(python3_idiomatic1_default)
python3_default_dirs += $(python3_idiomatic1_default_dirs)


$(python3_idiomatic1_DIR)/func_results.jsonl:
	touch $@

$(python3_idiomatic1_DIR)/perf_results.jsonl: $(python3_idiomatic1_DIR)/func_results.jsonl
	@if ! which ${PYTHON} > /dev/null; then echo "No $(PYTHON) in path."; exit 1; fi
	$(PYTHON) $(python3_idiomatic1_DIR)/perftest.py > $@

$(python3_idiomatic1_DIR)/byteio:
	(cd $(python3_idiomatic1_DIR); \
     git clone --depth=1 https://github.com/ironmeld/multilang-byteio; \
     mv multilang-byteio/src/python3/idiomatic1/byteio .; \
     rm -rf multilang-byteio;)
