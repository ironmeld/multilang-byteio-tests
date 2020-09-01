TOP_SUBDIRS = python3

# The following loops basically do this for every subdir:
# python3_DIR=$(TOPDIR)/python3
# include $(python3_DIR)/python3_vars.mk

$(foreach SUBDIR,$(TOP_SUBDIRS),$(eval $(SUBDIR)_DIR=$(TOPDIR)/$(SUBDIR)))
$(foreach SUBDIR,$(TOP_SUBDIRS),$(eval include $($(SUBDIR)_DIR)/$(SUBDIR)_vars.mk))

