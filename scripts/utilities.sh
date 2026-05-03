#!/bin/bash

set -euo pipefail

# Utility functions for frequently performed tasks
# This file MUST NOT contain anything other than function definitions.

function echo_red_text() {
  echo -e "\033[31m$1\033[0m"
}

function echo_green_text() {
  echo -e "\033[32m$1\033[0m"
}

function error_fn() {
  echo
  echo_red_text 'Something went wrong! The script failed.'
  echo_red_text 'Please report this (with the output message) to https://phoenix.celenity.dev/issues'
  echo
  exit 1
}
