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

# Verify that an executable (corresponding to an environment variable) exists and is properly set-up
function verify_exec() {
  function print_usage() {
    echo "Usage: verify_exec /path/to/executable 'ENVIRONMENT_VARIABLE_FOR_EXECUTABLE'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify an executable!'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify an environment variable that corresponds to an executable!'
    print_usage
    exit 1
  fi

  local readonly exec="$1"
  local readonly exec_env="$2"

  if [[ -z "${exec_env+x}" ]]; then
    echo_red_text "ERROR: Environment variable is missing!: ${exec_env}"
    exit 1
  fi

  if [[ ! -f "${exec}" ]]; then
    echo_red_text "ERROR: ${exec} is missing!"
    echo_green_text "Please ensure that environment variable is set to a valid executable: ${exec_env}"
    return 1
  fi

  if [[ ! -s "${exec}" ]]; then
    echo_red_text "ERROR: ${exec} is empty!"
    echo_green_text "Please ensure that environment variable is set to a valid executable: ${exec_env}"
    return 1
  fi

  if [[ ! -x "${exec}" ]]; then
    echo_red_text "ERROR: ${exec} is not executable!"
    echo_green_text "Please ensure that environment variable is set to a valid executable: ${exec_env}"
    return 1
  fi
}

# Verify that a file (corresponding to an environment variable) exists and is not empty
function verify_file() {
  function print_usage() {
    echo "Usage: verify_file /path/to/file 'ENVIRONMENT_VARIABLE_FOR_FILE'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file to verify'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the environment variable that corresponds to the file to verify'
    print_usage
    exit 1
  fi

  local readonly verify_file="$1"
  local readonly verify_file_env="$2"

  if [[ ! -f "${verify_file}" ]]; then
    echo_red_text "ERROR: ${verify_file_env} is set, but ${verify_file} does not exist! Aborting..."
    exit 1
  fi

  if [[ ! -s "${verify_file}" ]]; then
    echo_red_text "ERROR: ${verify_file_env} is set, but ${verify_file} is empty! Aborting..."
    exit 1
  fi
}

# Only verify that a file exists if a designated environment variable is actually set
function maybe_verify_file() {
  function print_usage() {
    echo "Usage: maybe_verify_file /path/to/file 'ENVIRONMENT_VARIABLE_FOR_FILE'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file to verify'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the environment variable that should be used to determine whether we should verify the file'
    print_usage
    exit 1
  fi

  local readonly maybe_file="$1"
  local readonly maybe_file_env="$2"

  if [[ "${maybe_file}" != 'undefined' ]]; then
    verify_file "${maybe_file}" "${maybe_file_env}"
  fi
}
