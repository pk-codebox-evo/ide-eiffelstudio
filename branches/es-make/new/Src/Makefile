# Global Makefile for the EiffelStudio source
# 

GEANT=geant

help:
	@echo "EiffelStudio automated build scripts"
	@echo "------------------------------------"
	@echo ""
	@echo "The following targets are available:"
	@echo "    check_setup      Check if everything is correctly setup"
	@echo "    build_workbench  Setup an environment for development"
	@echo "    make_delivery    Build a delivery from the source tree"
	@echo "    clean            Clean up the tree"
	@echo ""
	@echo "'geant' has to be in your path. It is part of the GOBO tool chain."
	@echo "You can create a binary from pre-compiled C by calling:"
	@echo "cc -o geant library/gobo/svn/work/bootstrap/geant.c"

# ----------------------------------------------------------------------
# Official targets

check_setup: check_geant
	geant check_setup

build_workbench: check_geant
	geant build_workbench

make_delivery: check_geant
	geant make_delivery

clean: check_geant
	geant clean

# ----------------------------------------------------------------------
# Supporting targets

check_geant:
	@which ${GEANT} > /dev/null || (echo "geant not found, aborting, see 'make help' ..." ; exit 1)

.PHONY: help check_setup build_workbench make_delivery clean
