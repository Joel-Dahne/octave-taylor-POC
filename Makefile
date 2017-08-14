## Copyright 2015-2016 CarnÃ« Draug
## Copyright 2015-2016 Oliver Heimlich
## Copyright 2017 Julien Bect <jbect@users.sf.net>
## Copyright 2017 Olaf Till <i7tiol@t-online.de>
## Copyright 2017 Joel Dahne
##
## Copying and distribution of this file, with or without modification,
## are permitted in any medium without royalty provided the copyright
## notice and this notice are preserved.  This file is offered as-is,
## without any warranty.

## Some basic tools (can be overriden using environment variables)
SED ?= sed
TAR ?= tar
GREP ?= grep
CUT ?= cut

## These can be set by environment variables which allow to easily
## test with different Octave versions.
ifndef OCTAVE
OCTAVE := octave
endif

## .PHONY indicates targets that are not filenames
## (https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html)
.PHONY: help

## make will display the command before runnning them.  Use @command
## to not display it (makes specially sense for echo).
help:
	@echo "Targets:"
	@echo "   check   - Execute test and doctest."
	@echo "   test    - Run build in self tests (BISTs)."
	@echo "   doctest - Test the help texts with the doctest package."
	@echo "   run     - Run Octave with the package installed in $(installation_dir) in the path."

##
## Recipes for testing purposes
##

.PHONY: run test doctest check

## Start an Octave session with the package directories on the path for
## interactice test of development sources.
run:
	@echo "Run GNU Octave with the development version of the package"
	@$(OCTAVE) --no-gui --silent --path "inst/" --persist --eval \
		"pkg load interval;"
	@echo

## Run build in self tests (BISTs)
test:
	$(OCTAVE) --no-gui --silent --path "inst/" \
	  --eval "pkg load interval;" \
	  --eval '__run_test_suite__ ({"inst"}, {})'

## Test example blocks in the documentation.  Needs doctest package
##  https://octave.sourceforge.io/doctest/index.html
doctest:
	$(OCTAVE) --no-gui --silent --path "inst/" \
	  --eval 'pkg load doctest;' \
	  --eval 'pkg load interval;' \
	  --eval "targets = '$(shell (ls inst; ls src | $(GREP) .oct) | $(CUT) -f2 -d@ | $(CUT) -f1 -d.)';" \
	  --eval "targets = strsplit (targets, ' ');  doctest (targets);"


check: test doctest
