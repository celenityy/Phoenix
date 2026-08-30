#!/bin/bash

# Script is used to update the Phoenix wiki repository
# (Synced with the `docs` directory)
# This script is expected to be run in a CI environment
# DO NOT execute this manually!

set -euo pipefail

# Ensure this is never ran with xtrace...
set +x || exit 1

# Set-up our environment
if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
  /bin/bash $(dirname $0)/env.sh || exit 1
fi
source $(dirname $0)/env.sh || exit 1

# Include utilities
source "${PHOENIX_UTILS}" || exit 1

# Include download utilities
source "${PHOENIX_DOWNLOAD_UTILS}" || exit 1

if [[ "${PHOENIX_CI}" != 1 ]]; then
  echo_red_text "ERROR: $0 should only be called from CI!"
  exit 1
fi

# Constants

# Phoenix repo
readonly PHOENIX_REPO_PATH='celenity/Phoenix'

# Phoenix wiki repo
readonly PHOENIX_WIKI_BRANCH='main'
readonly PHOENIX_WIKI_REPO="${PHOENIX_EXTERNAL}/wiki"

# Forgejo (Codeberg)
readonly PHOENIX_FORGEJO_URL='codeberg.org'

# Git
readonly PHOENIX_WIKI_GIT_EMAIL='wiki_author@noreply.codeberg.org'
readonly PHOENIX_WIKI_GIT_NAME='Wiki Author'

# Get dependencies
function get_deps() {
  echo_red_text 'Downloading dependencies...'
  /bin/sudo /bin/dnf update -y --refresh
  /bin/sudo /bin/dnf install -y bash curl git rsync
  echo_green_text 'SUCCESS: Downloaded dependencies.'
}

# Configure Git
function configure_git() {
  # Ensure we have an API token...
  if [[ -z "${PHOENIX_FORGEJO_CI_API_TOKEN+x}" ]] || [[ "${PHOENIX_FORGEJO_CI_API_TOKEN}" == "" ]]; then
    echo_red_text "ERROR: Missing Forgejo CI API Token! Please set 'PHOENIX_FORGEJO_CI_API_TOKEN'!."
    exit 1
  fi

  # Ensure we have git
  verify_exec "${PHOENIX_GIT}" 'PHOENIX_GIT' || exit 1

  # Ensure we have `PHOENIX_FORGEJO_URL`
  if [[ -z "${PHOENIX_FORGEJO_URL+x}" ]] || [[ "${PHOENIX_FORGEJO_URL}" == "" ]]; then
    echo_red_text "ERROR: 'PHOENIX_FORGEJO_URL' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_WIKI_GIT_EMAIL`
  if [[ -z "${PHOENIX_WIKI_GIT_EMAIL+x}" ]] || [[ "${PHOENIX_WIKI_GIT_EMAIL}" == "" ]]; then
    echo_red_text "ERROR: 'PHOENIX_WIKI_GIT_EMAIL' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_WIKI_GIT_NAME`
  if [[ -z "${PHOENIX_WIKI_GIT_NAME+x}" ]] || [[ "${PHOENIX_WIKI_GIT_NAME}" == "" ]]; then
    echo_red_text "ERROR: 'PHOENIX_WIKI_GIT_NAME' is missing!"
    exit 1
  fi

  echo_red_text 'Configuring Git...'
  "${PHOENIX_GIT}" config --global user.email "${PHOENIX_WIKI_GIT_EMAIL}"
  "${PHOENIX_GIT}" config --global user.name "${PHOENIX_WIKI_GIT_NAME}"
  "${PHOENIX_GIT}" config --global url."https://${PHOENIX_FORGEJO_CI_API_TOKEN}@${PHOENIX_FORGEJO_URL}/".insteadOf "https://${PHOENIX_FORGEJO_URL}/"
  echo_green_text 'SUCCESS: Configured Git.'
}

# Clone the wiki repo
function clone_wiki_repo() {
  # Ensure we have an API token...
  if [[ -z "${PHOENIX_FORGEJO_CI_API_TOKEN+x}" ]] || [[ "${PHOENIX_FORGEJO_CI_API_TOKEN}" == "" ]]; then
    echo_red_text "ERROR: Missing Forgejo CI API Token! Please set 'PHOENIX_FORGEJO_CI_API_TOKEN'."
    exit 1
  fi

  # Ensure we have git
  verify_exec "${PHOENIX_GIT}" 'PHOENIX_GIT' || exit 1

  # Ensure we have `PHOENIX_FORGEJO_URL`
  if [[ -z "${PHOENIX_FORGEJO_URL+x}" ]] || [[ "${PHOENIX_FORGEJO_URL}" == "" ]]; then
    echo_red_text "ERROR: 'PHOENIX_FORGEJO_URL' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_REPO_PATH`
  if [[ -z "${PHOENIX_REPO_PATH+x}" ]] || [[ "${PHOENIX_REPO_PATH}" == "" ]]; then
    echo_red_text "ERROR: 'PHOENIX_REPO_PATH' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_WIKI_REPO`
  if [[ -z "${PHOENIX_WIKI_REPO+x}" ]] || [[ "${PHOENIX_WIKI_REPO}" == "" ]]; then
    echo_red_text "ERROR: 'PHOENIX_WIKI_REPO' is missing!"
    exit 1
  fi

  # Clone the wiki repo
  clone_git_repo "https://${PHOENIX_FORGEJO_CI_API_TOKEN}@${PHOENIX_FORGEJO_URL}/${PHOENIX_REPO_PATH}.wiki.git" "${PHOENIX_WIKI_REPO}" 'no-revision' --silent
}

# Update the wiki repo
function update_wiki_repo() {
  # Ensure we have an API token...
  if [[ -z "${PHOENIX_FORGEJO_CI_API_TOKEN+x}" ]] || [[ "${PHOENIX_FORGEJO_CI_API_TOKEN}" == "" ]]; then
    echo_red_text "ERROR: Missing Forgejo CI API Token! Please set 'PHOENIX_FORGEJO_CI_API_TOKEN'."
    exit 1
  fi

  # Ensure we have git
  verify_exec "${PHOENIX_GIT}" 'PHOENIX_GIT' || exit 1

  # Ensure we have rsync
  verify_exec "${PHOENIX_RSYNC}" 'PHOENIX_RSYNC' || exit 1

  # Ensure we have `PHOENIX_WIKI_BRANCH`
  if [[ -z "${PHOENIX_WIKI_BRANCH+x}" ]] || [[ "${PHOENIX_WIKI_BRANCH}" == "" ]]; then
    echo_red_text "ERROR: 'PHOENIX_WIKI_BRANCH' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_WIKI_REPO`
  if [[ -z "${PHOENIX_WIKI_REPO+x}" ]] || [[ "${PHOENIX_WIKI_REPO}" == "" ]]; then
    echo_red_text "ERROR: 'PHOENIX_WIKI_REPO' is missing!"
    exit 1
  fi

  # Ensure the wiki repo exists
  if [[ ! -d "${PHOENIX_WIKI_REPO}" ]]; then
    echo_red_text "ERROR: Missing Phoenix wiki repo: '${PHOENIX_WIKI_REPO}'!"
    exit 1
  fi

  # Sync the docs and wiki repo directories
  echo_red_text 'Syncing docs and wiki repo...'
  "${PHOENIX_RSYNC}" -av --delete "${PHOENIX_ROOT}/docs/" "${PHOENIX_WIKI_REPO}/" --exclude .git
  echo_green_text 'SUCCESS: Synced docs and wiki repo.'

  # Update the wiki repo
  echo_red_text 'Updating wiki repository...'
  pushd "${PHOENIX_WIKI_REPO}"
  "${PHOENIX_GIT}" add .
  "${PHOENIX_GIT}" diff --cached --quiet || "${PHOENIX_GIT}" commit -m 'Update wiki'
  "${PHOENIX_GIT}" push origin "HEAD:${PHOENIX_WIKI_BRANCH}"
  popd
  echo_green_text 'SUCCESS: Updated wiki repository!'
}

pushd "${PHOENIX_ROOT}"

# Get dependencies
get_deps

# Configure Git
configure_git

# Clone the wiki repo
clone_wiki_repo

# Update the wiki repo
update_wiki_repo

popd
