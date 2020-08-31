# Create performance test results for multiple languages

# The goal of the Makefile strategy for this project is that someone
# can run make at the top or in any subdirectory and it will build
# the default target for that directory. If you build in higher level
# directories it will build the lower level directories, and so on.
#
# But crucially, the Makefiles in this project do not use the technique of
# simply changing into each subdirectory and running "make" recursively.
# Recursive make considered harmful:
# http://www.real-linux.org.uk/recursivemake.pdf
#
# Instead, a single unified makefile is constructed by recursively including
# all .mk makefiles from a single .mk file located in the project top dir.
# The same makefile is created regardless of where in the directory structure
# you run make. The job of each directory Makefile is to simple include
# the top level include file (global.mk) and define a default target
# for the local directory.

# TOPDIR in each Makefile provides the location of global.mk as a
# relative path from the directory where "make" is invoked (i.e. the
# current dir). TOPDIR is a relative path because it is easier to
# specify than computing the absolute path.
TOPDIR=.
# global.mk recursively includes all .mk files in the project
include global.mk

default: global_default
