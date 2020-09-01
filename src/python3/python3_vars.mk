PYTHON3_SUBDIRS = idiomatic1

# do this for each subdir:
# python3_idiomatic1_DIR=$(python3_DIR)/idiomatic1
#
$(foreach SUBDIR,$(PYTHON3_SUBDIRS),$(eval python3_$(SUBDIR)_DIR=$(python3_DIR)/$(SUBDIR)))
