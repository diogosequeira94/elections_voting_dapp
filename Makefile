.DEFAULT_GOAL    := help

# points to the directory of the Makefile
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

format: ## Format the files to current code standard
	flutter format . -l 120

clean: ## Clean all the cache and dependencies from dart modules.
	dart ./scripts/cli/cli.dart clean
