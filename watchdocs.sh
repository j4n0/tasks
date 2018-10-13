#!/bin/bash -e -o pipefail

source `which virtualenvwrapper.sh`
workon Tasks
make -C sources/docs html
open sources/docs/_build/html/index.html
sphinx-autobuild sources/docs sources/docs/_build/html
