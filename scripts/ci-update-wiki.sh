#!/bin/bash

# Script is used to update the Phoenix wiki repository
# (Synced with the `docs` directory)
# This script is expected to be run in a CI environment
# DO NOT execute this manually!

set -euo pipefail

# Ensure this is never ran with xtrace...
set +x || exit 1

# Set-up our environment
function setup_env() {
  if [[ -z "${PHOENIX_SET_ENVS+x}" ]] || [[ "${PHOENIX_SET_ENVS}" != 1 ]]; then
    # Find dirname
    if [[ -n "${PHOENIX_DIRNAME+x}" ]] && [[ -x "${PHOENIX_DIRNAME}" ]]; then
      local -r dirname="${PHOENIX_DIRNAME}"
    elif [[ -x '/bin/dirname' ]]; then
      local -r dirname='/bin/dirname'
    elif [[ -x '/usr/bin/dirname' ]]; then
      local -r dirname='/usr/bin/dirname'
    else
      if ! command -v dirname > /dev/null 2>&1; then
        echo "ERROR: Missing dirname!" >&2
        exit 1
      fi
      # It isn't a known location, so we sadly have to just fall-back to the PATH
      local -r dirname="$(dirname)"
    fi

    # Set-up our environment
    readonly PHOENIX_ENV_SH="$("${dirname}" $0)/env.sh"
    if [[ ! -f "${PHOENIX_ENV_SH}" ]] || [[ ! -s "${PHOENIX_ENV_SH}" ]]; then
      echo "ERROR: '${PHOENIX_ENV_SH}' is invalid!"
      exit 1
    fi
    source "${PHOENIX_ENV_SH}" || exit 1
  fi
}

# Set-up our environment
setup_env

# Include download utilities
verify_file_with_env "${PHOENIX_DOWNLOAD_UTILS}" 'PHOENIX_DOWNLOAD_UTILS' || exit 1
source "${PHOENIX_DOWNLOAD_UTILS}" || exit 1

# Ensure we have `PHOENIX_CI`
verify_env "${PHOENIX_CI}" 'PHOENIX_CI' || exit 1

if [[ "${PHOENIX_CI}" != 1 ]]; then
  echo_red_text "ERROR: '$0' should only be called from CI!"
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
  verify_env "${PHOENIX_FORGEJO_CI_API_TOKEN}" 'PHOENIX_FORGEJO_CI_API_TOKEN' || exit 1

  # Ensure we have git
  verify_exec "${PHOENIX_GIT}" 'PHOENIX_GIT' || exit 1

  # Ensure we have `PHOENIX_FORGEJO_URL`
  verify_env "${PHOENIX_FORGEJO_URL}" 'PHOENIX_FORGEJO_URL' || exit 1

  # Ensure we have `PHOENIX_WIKI_GIT_EMAIL`
  verify_env "${PHOENIX_WIKI_GIT_EMAIL}" 'PHOENIX_WIKI_GIT_EMAIL' || exit 1

  # Ensure we have `PHOENIX_WIKI_GIT_NAME`
  verify_env "${PHOENIX_WIKI_GIT_NAME}" 'PHOENIX_WIKI_GIT_NAME' || exit 1

  echo_red_text 'Configuring Git...'
  "${PHOENIX_GIT}" config --global user.email "${PHOENIX_WIKI_GIT_EMAIL}"
  "${PHOENIX_GIT}" config --global user.name "${PHOENIX_WIKI_GIT_NAME}"
  "${PHOENIX_GIT}" config --global url."https://${PHOENIX_FORGEJO_CI_API_TOKEN}@${PHOENIX_FORGEJO_URL}/".insteadOf "https://${PHOENIX_FORGEJO_URL}/"
  echo_green_text 'SUCCESS: Configured Git.'
}

# Clone the wiki repo
function clone_wiki_repo() {
  # Ensure we have an API token...
  verify_env "${PHOENIX_FORGEJO_CI_API_TOKEN}" 'PHOENIX_FORGEJO_CI_API_TOKEN' || exit 1

  # Ensure we have git
  verify_exec "${PHOENIX_GIT}" 'PHOENIX_GIT' || exit 1

  # Ensure we have `PHOENIX_FORGEJO_URL`
  verify_env "${PHOENIX_FORGEJO_URL}" 'PHOENIX_FORGEJO_URL' || exit 1

  # Ensure we have `PHOENIX_REPO_PATH`
  verify_env "${PHOENIX_REPO_PATH}" 'PHOENIX_REPO_PATH' || exit 1

  # Ensure we have `PHOENIX_WIKI_REPO`
  verify_env "${PHOENIX_WIKI_REPO}" 'PHOENIX_WIKI_REPO' || exit 1

  # Clone the wiki repo
  clone_git_repo "https://${PHOENIX_FORGEJO_CI_API_TOKEN}@${PHOENIX_FORGEJO_URL}/${PHOENIX_REPO_PATH}.wiki.git" "${PHOENIX_WIKI_REPO}" 'no-revision' --silent
}

# Update the wiki repo
function update_wiki_repo() {
  # Ensure we have an API token...
  verify_env "${PHOENIX_FORGEJO_CI_API_TOKEN}" 'PHOENIX_FORGEJO_CI_API_TOKEN' || exit 1

  # Ensure we have git
  verify_exec "${PHOENIX_GIT}" 'PHOENIX_GIT' || exit 1

  # Ensure we have rsync
  verify_exec "${PHOENIX_RSYNC}" 'PHOENIX_RSYNC' || exit 1

  # Ensure we have `PHOENIX_WIKI_BRANCH`
  verify_env "${PHOENIX_WIKI_BRANCH}" 'PHOENIX_WIKI_BRANCH' || exit 1

  # Ensure we have `PHOENIX_WIKI_REPO`
  verify_dir_with_env "${PHOENIX_WIKI_REPO}" 'PHOENIX_WIKI_REPO' || exit 1

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
