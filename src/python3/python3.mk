include $(PYTHON3_IDIOMATIC1_DIR)/idiomatic1.mk

python3_default: python3_idiomatic1_default
.PHONY: python3_default

list-results_python3: list-results_python3_idiomatic1
.PHONY: list-results_python3
