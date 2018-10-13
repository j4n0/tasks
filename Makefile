#!/bin/bash -e -o pipefail

usage:
	@printf "\033[1;35mUsage\033[0m\n"
	@printf "sphinx Open the docs\n"

sphinx:
	sh -C watchdocs.sh
