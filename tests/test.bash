#!/usr/bin/bash
set -e
set -o pipefail
set -x

nvim --version
nvim -O 1 2 3 4 5 6
