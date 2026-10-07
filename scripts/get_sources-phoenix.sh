#!/bin/bash

set -euo pipefail

# Set verbosity
set_verbosity

# Include download utilities
verify_file_with_env "${PHOENIX_DOWNLOAD_UTILS}" 'PHOENIX_DOWNLOAD_UTILS' || return 1
source "${PHOENIX_DOWNLOAD_UTILS}" || return 1

# Include file utilities
verify_file_with_env "${PHOENIX_FILE_UTILS}" 'PHOENIX_FILE_UTILS' || return 1
source "${PHOENIX_FILE_UTILS}" || return 1

if [[ -z "${PHOENIX_FROM_SOURCES+x}" ]]; then
  echo_red_text "ERROR: Do not call 'get_sources-phoenix.sh' directly! Instead, use 'get_sources.sh'." >&1
  return 1
fi

# Ensure we have rm
verify_exec "${PHOENIX_RM}" 'PHOENIX_RM' || return 1

verify_env "${source_target}" 'source_target' || {
  echo_red_text "ERROR: Missing target!"
  return 1
}

verify_env "${mode}" 'mode' || {
  echo_red_text "ERROR: Missing mode!"
  return 1
}

# Set-up target parameters
PHOENIX_GET_SOURCE_PYTHON=0
PHOENIX_GET_SOURCE_S3CMD=0
PHOENIX_GET_SOURCE_SHELLCHECK=0
PHOENIX_GET_SOURCE_SHFMT=0
PHOENIX_GET_SOURCE_UV=0

if [[ "${source_target}" == 'python' ]]; then
  # Get Python
  PHOENIX_GET_SOURCE_PYTHON=1
elif [[ "${source_target}" == 's3cmd' ]]; then
  # Get s3cmd
  PHOENIX_GET_SOURCE_S3CMD=1
elif [[ "${source_target}" == 'shellcheck' ]]; then
  # Get shellcheck
  PHOENIX_GET_SOURCE_SHELLCHECK=1
elif [[ "${source_target}" == 'shfmt' ]]; then
  # Get shfmt
  PHOENIX_GET_SOURCE_SHFMT=1
elif [[ "${source_target}" == 'uv' ]]; then
  # Get + set-up uv
  PHOENIX_GET_SOURCE_UV=1
elif [[ "${source_target}" == 'all' ]]; then
  # If no argument is specified (or argument is set to "all"), just get everything, except s3cmd
  ## (We don't need to bother getting s3cmd here since it's only used in certain scenarios)
  PHOENIX_GET_SOURCE_PYTHON=1
  PHOENIX_GET_SOURCE_UV=1

  # CI only uses shellcheck and shfmt in the `lint` stage (where they're retrieved directly)
  # If git is missing, we know the user isn't contributing (at least from this repo directly), so we don't need to download them in
  # those cases either
  if [[ -x "${PHOENIX_GIT}" ]] && [[ "${PHOENIX_CI}" != 1 ]]; then
    PHOENIX_GET_SOURCE_SHELLCHECK=1
    PHOENIX_GET_SOURCE_SHFMT=1
  fi
else
  echo_red_text "ERROR: Invalid target: '${source_target}'\n You must enter one of the following:"
  echo 'All:        all (Default)'
  echo 'Python:     python'
  echo 's3cmd:      s3cmd'
  echo 'shellcheck: shellcheck'
  echo 'shfmt:      shfmt'
  echo 'uv:         uv'
  return 1
fi
readonly PHOENIX_GET_SOURCE_PYTHON
readonly PHOENIX_GET_SOURCE_S3CMD
readonly PHOENIX_GET_SOURCE_SHELLCHECK
readonly PHOENIX_GET_SOURCE_SHFMT
readonly PHOENIX_GET_SOURCE_UV

# If the 'checksum-update' argument is specified, in addition to downloading the dependencies as usual,
## we're also updating their checksums
PHOENIX_GET_SOURCE_CHECKSUM_UPDATE=0
if [[ "${mode}" == 'checksum-update' ]]; then
  PHOENIX_GET_SOURCE_CHECKSUM_UPDATE=1
elif [[ "${mode}" != 'download' ]]; then
  echo_red_text "ERROR: Invalid mode: '${mode}'\n You must enter one of the following:"
  echo 'Download:                     download (Default)'
  echo 'Download + update checksums:  checksum-update'
  return 1
fi
readonly PHOENIX_GET_SOURCE_CHECKSUM_UPDATE

# Back-up (and remove) a file if it exists
function backup_file() {
  function print_usage() {
    echo "Usage: backup_file 'path/to/file'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please provide the file path!'
    print_usage
    return 1
  fi

  # Ensure we have basename
  verify_exec "${PHOENIX_BASENAME}" 'PHOENIX_BASENAME' || return 1

  # Ensure we have cp
  verify_exec "${PHOENIX_CP}" 'PHOENIX_CP' || return 1

  # Ensure we have dirname
  verify_exec "${PHOENIX_DIRNAME}" 'PHOENIX_DIRNAME' || return 1

  # Ensure we have mkdir
  verify_exec "${PHOENIX_MKDIR}" 'PHOENIX_MKDIR' || return 1

  local -r file="$1"
  local -r file_name="$("${PHOENIX_BASENAME}" "${file}")"
  local -r backup_file="${PHOENIX_EXTERNAL}/temp/backup/${file_name}"

  if [[ -f "${file}" ]]; then
    "${PHOENIX_RM}" -f "${backup_file}"
    "${PHOENIX_MKDIR}" -p "$("${PHOENIX_DIRNAME}" "${backup_file}")"
    "${PHOENIX_CP}" -f "${file}" "${backup_file}"
    "${PHOENIX_RM}" -f "${file}"
  fi
}

# Back-up (and remove) a directory if it exists
function backup_dir() {
  function print_usage() {
    echo "Usage: backup_dir 'path/to/directory'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please provide the directory path!'
    print_usage
    return 1
  fi

  # Ensure we have basename
  verify_exec "${PHOENIX_BASENAME}" 'PHOENIX_BASENAME' || return 1

  # Ensure we have cp
  verify_exec "${PHOENIX_CP}" 'PHOENIX_CP' || return 1

  # Ensure we have dirname
  verify_exec "${PHOENIX_DIRNAME}" 'PHOENIX_DIRNAME' || return 1

  # Ensure we have mkdir
  verify_exec "${PHOENIX_MKDIR}" 'PHOENIX_MKDIR' || return 1

  local -r dir="$1"
  local -r dir_name="$("${PHOENIX_BASENAME}" "${dir}")"
  local -r backup_dir="${PHOENIX_EXTERNAL}/temp/backup/${dir_name}"

  if [[ -d "${dir}" ]]; then
    "${PHOENIX_RM}" -rf "${backup_dir}"
    "${PHOENIX_MKDIR}" -p "$("${PHOENIX_DIRNAME}" "${backup_dir}")"
    "${PHOENIX_CP}" -rf "${dir}/" "${backup_dir}"
    "${PHOENIX_RM}" -rf "${dir}"
  fi
}

# Restore a backed-up file
function restore_file() {
  function print_usage() {
    echo "Usage: restore_file 'path/to/file'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please provide the file path!'
    print_usage
    return 1
  fi

  # Ensure we have basename
  verify_exec "${PHOENIX_BASENAME}" 'PHOENIX_BASENAME' || return 1

  # Ensure we have cp
  verify_exec "${PHOENIX_CP}" 'PHOENIX_CP' || return 1

  # Ensure we have dirname
  verify_exec "${PHOENIX_DIRNAME}" 'PHOENIX_DIRNAME' || return 1

  # Ensure we have mkdir
  verify_exec "${PHOENIX_MKDIR}" 'PHOENIX_MKDIR' || return 1

  local -r file="$1"
  local -r file_name="$("${PHOENIX_BASENAME}" "${file}")"
  local -r backed_up_file="${PHOENIX_EXTERNAL}/temp/backup/${file_name}"

  if [[ -f "${backed_up_file}" ]]; then
    "${PHOENIX_RM}" -f "${file}"
    "${PHOENIX_MKDIR}" -p "$("${PHOENIX_DIRNAME}" "${file}")"
    "${PHOENIX_CP}" -f "${backed_up_file}" "${file}"
    "${PHOENIX_RM}" -f "${backed_up_file}"
  fi
}

# Restore a backed-up directory
function restore_dir() {
  function print_usage() {
    echo "Usage: restore_dir 'path/to/directory'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please provide the directory path!'
    print_usage
    return 1
  fi

  # Ensure we have basename
  verify_exec "${PHOENIX_BASENAME}" 'PHOENIX_BASENAME' || return 1

  # Ensure we have cp
  verify_exec "${PHOENIX_CP}" 'PHOENIX_CP' || return 1

  # Ensure we have dirname
  verify_exec "${PHOENIX_DIRNAME}" 'PHOENIX_DIRNAME' || return 1

  # Ensure we have mkdir
  verify_exec "${PHOENIX_MKDIR}" 'PHOENIX_MKDIR' || return 1

  local -r dir="$1"
  local -r dir_name="$("${PHOENIX_BASENAME}" "${dir}")"
  local -r backed_up_dir="${PHOENIX_EXTERNAL}/temp/backup/${dir_name}"

  if [[ -d "${backed_up_dir}" ]]; then
    "${PHOENIX_RM}" -rf "${dir}"
    "${PHOENIX_MKDIR}" -p "$("${PHOENIX_DIRNAME}" "${dir}")"
    "${PHOENIX_CP}" -rf "${backed_up_dir}/" "${dir}"
    "${PHOENIX_RM}" -rf "${backed_up_dir}"
  fi
}

# Update the checksum of a file
function update_checksum() {
  function print_usage() {
    echo "Usage: update_checksum 'current_checksum' 'new_checksum' 'path/to/file' 'checksum_type'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text "ERROR: Please provide the file's current checksum!"
    print_usage
    return 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text "ERROR: Please provide the file's new checksum!"
    print_usage
    return 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text 'ERROR: Please provide the file path!'
    print_usage
    return 1
  fi

  if [[ -z "${4+x}" ]]; then
    echo_red_text 'ERROR: Please provide the checksum type!'
    print_usage
    return 1
  fi

  # Ensure we have GNU sed
  verify_exec "${PHOENIX_SED}" 'PHOENIX_SED' || return 1

  local -r old_checksum="$1"
  local -r new_checksum="$2"
  local -r file="$3"
  local -r checksum_type="$4"

  if [[ "${checksum_type}" == 'md5sum' ]]; then
    local -r checksum_type_pretty='MD5sum'
  elif [[ "${checksum_type}" == 'sha1sum' ]]; then
    local -r checksum_type_pretty='SHA1sum'
  elif [[ "${checksum_type}" == 'sha256sum' ]]; then
    local -r checksum_type_pretty='SHA256sum'
  elif [[ "${checksum_type}" == 'sha512sum' ]]; then
    local -r checksum_type_pretty='SHA512sum'
  else
    echo_red_text "ERROR: Unsupported checksum type: '${checksum_type}'!"
    return 1
  fi

  if [[ "${old_checksum}" == "${new_checksum}" ]]; then
    echo_red_text "Checksums for file: '${file}' already match! Skipping..."
    echo "Old ${checksum_type_pretty}: '${old_checksum}'"
    echo "New ${checksum_type_pretty}: '${new_checksum}'"
  else
    echo_red_text "Updating ${checksum_type_pretty} for file: '${file}'..."
    "${PHOENIX_SED}" -i "s|'${old_checksum}'|'${new_checksum}'|g" "${PHOENIX_VERSIONS}"
    echo_green_text "SUCCESS: Updated ${checksum_type_pretty} for file: '${file}'!"
  fi
}

# Validate the checksum of a file
function validate_checksum() {
  function print_usage() {
    echo "Usage: validate_checksum 'expected_checksum' 'path/to/file' 'checksum_type'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text "ERROR: Please provide the file's expected checksum!"
    print_usage
    return 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please provide the file path!'
    print_usage
    return 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text 'ERROR: Please provide the checksum type!'
    print_usage
    return 1
  fi

  # Ensure we have GNU awk
  verify_exec "${PHOENIX_AWK}" 'PHOENIX_AWK' || return 1

  local -r expected_checksum="$1"
  local -r file="$2"
  local -r checksum_type="$3"

  if [[ "${checksum_type}" == 'md5sum' ]]; then
    # Ensure we have md5sum
    verify_exec "${PHOENIX_MD5SUM}" 'PHOENIX_MD5SUM' || return 1
  else
    # Ensure we have shasum
    verify_exec "${PHOENIX_SHASUM}" 'PHOENIX_SHASUM' || return 1
  fi

  # Ensure our file to validate is valid
  verify_file "${file}" || return 1

  if [[ "${checksum_type}" == 'md5sum' ]]; then
    local -r checksum_type_pretty='MD5sum'
    local -r local_checksum=$("${PHOENIX_MD5SUM}" "${file}" | "${PHOENIX_AWK}" '{print $1}')
  elif [[ "${checksum_type}" == 'sha1sum' ]]; then
    local -r checksum_type_pretty='SHA1sum'
    local -r local_checksum=$("${PHOENIX_SHASUM}" -a 1 "${file}" | "${PHOENIX_AWK}" '{print $1}')
  elif [[ "${checksum_type}" == 'sha256sum' ]]; then
    local -r checksum_type_pretty='SHA256sum'
    local -r local_checksum=$("${PHOENIX_SHASUM}" -a 256 "${file}" | "${PHOENIX_AWK}" '{print $1}')
  elif [[ "${checksum_type}" == 'sha512sum' ]]; then
    local -r checksum_type_pretty='SHA512sum'
    local -r local_checksum=$("${PHOENIX_SHASUM}" -a 512 "${file}" | "${PHOENIX_AWK}" '{print $1}')
  else
    echo_red_text "ERROR: Unsupported checksum type: '${checksum_type}'!"
    return 1
  fi

  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    update_checksum "${expected_checksum}" "${local_checksum}" "${file}" "${checksum_type}"
  elif [[ "${local_checksum}" != "${expected_checksum}" ]]; then
    echo_red_text "ERROR: Checksum (${checksum_type_pretty}) validation for file failed: '${file}'!"
    echo "Expected ${checksum_type_pretty}:   '${expected_checksum}'"
    echo "Actual ${checksum_type_pretty}:     '${local_checksum}'"

    # If checksum validation fails, also just remove the file
    "${PHOENIX_RM}" -f "${file}"

    return 1
  else
    echo_green_text "SUCCESS: Validated checksum (${checksum_type_pretty}) for file: '${file}'!"
    echo "${checksum_type_pretty}: '${local_checksum}'"
  fi
}

# Download and verify the SHA512sum of a file
function download_file() {
  function print_usage() {
    echo "Usage: download_file 'https://totally.real.url/file' 'path/to/file' 'file_sha512sum'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please provide the URL for the file to download!'
    print_usage
    return 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please provide the output file path!'
    print_usage
    return 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text "ERROR: Please provide the file's SHA512sum!"
    print_usage
    return 1
  fi

  # Ensure we have basename
  verify_exec "${PHOENIX_BASENAME}" 'PHOENIX_BASENAME' || return 1

  # Ensure we have `PHOENIX_EXTERNAL`
  verify_env "${PHOENIX_EXTERNAL}" 'PHOENIX_EXTERNAL' || return 1

  local -r url="$1"
  local -r file_in="$2"
  local -r file_name=$("${PHOENIX_BASENAME}" "${file_in}")
  local -r expected_sha512sum="$3"

  # By default, we want to exit upon an error
  if [[ -z "${PHOENIX_DOWNLOAD_EXIT+x}" ]]; then
    PHOENIX_DOWNLOAD_EXIT=1
  fi

  # By default, we want to perform post-download actions for sources
  ## (this includes things like ex. installing a dependency or creating/setting-up an environment)
  ## This isn't desired in some cases, like if we're updating checksums, or a user just cancels the download
  unset PHOENIX_PERFORM_POST_DOWNLOAD
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    ## If we're just updating a checksum, we should never perform post-download actions
    PHOENIX_PERFORM_POST_DOWNLOAD=0
  else
    PHOENIX_PERFORM_POST_DOWNLOAD=1
  fi

  # If we're doing a checksum update, we download the file to a separate temporary directory, instead of our standard one
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp/chksm"
    local -r file="${PHOENIX_EXTERNAL}/temp/chksm/${file_name}"
  else
    local -r file="${file_in}"
  fi

  if [[ -f "${file}" ]]; then
    echo_red_text "File already exists: '${file}'!"
    read -p "Do you want to re-download? [y/N] " -n 1 -r
    echo
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      # Back-up (in case something goes wrong - ex. checksum validation fails) and remove our file
      echo_red_text "Removing file: '${file}'..."
      backup_file "${file}"
      echo_green_text "SUCCESS: Removed file: '${file}'!"
    else
      unset PHOENIX_DOWNLOAD_EXIT
      PHOENIX_PERFORM_POST_DOWNLOAD=0
      return 0
    fi
  fi

  # By default, we know nothing has failed...
  local PHOENIX_CHECKSUM_FAILED=0
  local PHOENIX_DOWNLOAD_FAILED=0

  # Download our file
  download "${url}" "${file}" || local PHOENIX_DOWNLOAD_FAILED=1

  # Verify (or update) SHA512sum
  validate_checksum "${expected_sha512sum}" "${file}" 'sha512sum' || local PHOENIX_CHECKSUM_FAILED=1

  # If we're just updating the checksum, we're done, so go ahead and exit
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    if [[ "${PHOENIX_DOWNLOAD_FAILED}" == 1 ]]; then
      echo_red_text 'ERROR: Download failed!'
      return 1
    elif [[ "${PHOENIX_CHECKSUM_FAILED}" == 1 ]]; then
      echo_red_text 'ERROR: Failed to update checksum!'
      return 1
    else
      return 0
    fi
  fi

  # If the download (or checksum validation) failed, restore our back-up
  if [[ "${PHOENIX_CHECKSUM_FAILED}" == 1 ]] || [[ "${PHOENIX_DOWNLOAD_FAILED}" == 1 ]]; then
    if [[ -f "${PHOENIX_EXTERNAL}/temp/backup/${file_name}" ]]; then
      restore_file "${file}"
    fi
  fi

  # Clean-up
  "${PHOENIX_RM}" -f "${PHOENIX_EXTERNAL}/temp/backup/${file_name}"
  "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp/chksm"

  # If the download (or checksum validation) failed, exit
  if [[ "${PHOENIX_CHECKSUM_FAILED}" == 1 ]] || [[ "${PHOENIX_DOWNLOAD_FAILED}" == 1 ]]; then
    if [[ "${PHOENIX_DOWNLOAD_EXIT}" != 1 ]]; then
      unset PHOENIX_DOWNLOAD_EXIT
      return 1
    else
      echo_red_text 'ERROR: Download failed!'
      return 1
    fi
  fi
}

# Download and extract an archive
function download_and_extract() {
  function print_usage() {
    echo "Usage: download_and_extract 'https://totally.real.url/archive' 'path/to/extract/archive/to' 'archive_sha512sum'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please provide the URL for the archive to download!'
    print_usage
    return 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please provide the path that the archive should be extracted to!'
    print_usage
    return 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text "ERROR: Please provide the archive's SHA512sum!"
    print_usage
    return 1
  fi

  # Ensure we have `PHOENIX_EXTERNAL`
  verify_env "${PHOENIX_EXTERNAL}" 'PHOENIX_EXTERNAL' || return 1

  # Ensure we have `PHOENIX_DOWNLOADS`
  verify_env "${PHOENIX_DOWNLOADS}" 'PHOENIX_DOWNLOADS' || return 1

  local -r url="$1"
  local -r path="$2"
  local -r expected_sha512sum="$3"

  # By default, we want to perform post-download actions for sources
  ## (this includes things like ex. installing a dependency or creating/setting-up an environment)
  ## This isn't desired in some cases, like if we're updating checksums, or a user just cancels the download
  unset PHOENIX_PERFORM_POST_DOWNLOAD
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    ## If we're just updating a checksum, we should never perform post-download actions
    PHOENIX_PERFORM_POST_DOWNLOAD=0
  else
    PHOENIX_PERFORM_POST_DOWNLOAD=1
  fi

  if [[ -d "${path}" ]] && [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
    echo_red_text "Path already exists: '${path}'!"
    read -p "Do you want to re-download? [y/N] " -n 1 -r
    echo
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      # Back-up (in case something goes wrong - ex. checksum validation fails) and remove our directory
      echo_red_text "Removing path: '${path}'..."
      backup_dir "${path}"
      echo_green_text "SUCCESS: Removed path: '${path}'!"
    else
      PHOENIX_PERFORM_POST_DOWNLOAD=0
      return 0
    fi
  fi

  if [[ "${url}" =~ \.tar\.xz$ ]]; then
    local -r extension=".tar.xz"
  elif [[ "${url}" =~ \.tar\.gz$ ]]; then
    local -r extension=".tar.gz"
  elif [[ "${url}" =~ \.tar\.zst$ ]]; then
    local -r extension=".tar.zst"
  else
    local -r extension=".zip"
  fi

  # Tell `download` to return instead of exit upon an error
  PHOENIX_DOWNLOAD_EXIT=0

  # By default, we know the download hasn't failed...
  local PHOENIX_DOWNLOAD_FAILED=0

  # Set a temporary archive name
  local -r temp_archive_path_name=$("${PHOENIX_BASENAME}" "${path}")
  local -r temp_archive_path="${PHOENIX_DOWNLOADS}/${temp_archive_path_name}${extension}"

  # Download the archive
  download_file "${url}" "${temp_archive_path}" "${expected_sha512sum}" || local PHOENIX_DOWNLOAD_FAILED=1

  # If we're just updating the checksum, we're done, so go ahead and exit
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    if [[ "${PHOENIX_DOWNLOAD_FAILED}" == 1 ]]; then
      echo_red_text "ERROR: Download for archive failed: '${url}'!"
      return 1
    else
      return 0
    fi
  fi

  # If the download failed, restore our back-up (if possible) and exit
  if [[ "${PHOENIX_DOWNLOAD_FAILED}" == 1 ]]; then
    restore_dir "${path}"
    if [[ "${temp_archive_path_name}" == 'uv' ]]; then
      PHOENIX_PERFORM_POST_DOWNLOAD=0
    else
      echo_red_text "ERROR: Download for archive failed: '${url}'!"
    fi
    return 1
  fi

  # Extract the archive
  extract_archive "${temp_archive_path}" "${path}"

  # Clean-up
  "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp/backup/${temp_archive_path_name}"
}

# Get Python
function get_python() {
  # Ensure we have `PHOENIX_PYTHON_DIR`
  verify_env "${PHOENIX_PYTHON_DIR}" 'PHOENIX_PYTHON_DIR' || return 1

  # Ensure we have `PHOENIX_PYTHON_GIT_RELEASE`
  verify_env "${PHOENIX_PYTHON_GIT_RELEASE}" 'PHOENIX_PYTHON_GIT_RELEASE' || return 1

  # Ensure we have `PHOENIX_PYTHON_VERSION`
  verify_env "${PHOENIX_PYTHON_VERSION}" 'PHOENIX_PYTHON_VERSION' || return 1

  # If all we're doing is updating the checksum, we don't care about existing installations
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
    # Ensure we have uv
    verify_exec "${PHOENIX_UV}" 'PHOENIX_UV' || {
      echo_red_text "ERROR: Unable to download and install Python without uv!"
      return 1
    }

    # Ensure we have `PHOENIX_PYENV_DIR`
    verify_env "${PHOENIX_PYENV_DIR}" 'PHOENIX_PYENV_DIR' || return 1

    # Ensure we have `PHOENIX_UV_CACHE`
    verify_env "${PHOENIX_UV_CACHE}" 'PHOENIX_UV_CACHE' || return 1

    # Ensure we have `PHOENIX_UV_LOCAL`
    verify_env "${PHOENIX_UV_LOCAL}" 'PHOENIX_UV_LOCAL' || return 1

    # Ensure we have `PHOENIX_UV_PYTHON`
    verify_env "${PHOENIX_UV_PYTHON}" 'PHOENIX_UV_PYTHON' || return 1

    if [[ -d "${PHOENIX_PYENV_DIR}" ]]; then
      echo_red_text "The Python environment is already set-up at path: '${PHOENIX_PYENV_DIR}'!"
      read -p "Do you want to re-create it? [y/N] " -n 1 -r
      echo
      if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
        # Back-up (in case something goes wrong - ex. checksum validation fails) and remove our directory
        backup_dir "${PHOENIX_PYENV_DIR}"
      fi
    fi

    if [[ -d "${PHOENIX_PYTHON_DIR}" ]]; then
      echo_red_text "Found existing installation at path: '${PHOENIX_PYTHON_DIR}'!"
      echo 'Continuing will remove this installation and related data.'
      read -p "Do you still want to continue? [y/N] " -n 1 -r
      echo
      if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
        # Back-up (in case something goes wrong - ex. checksum validation fails) and remove our directories
        backup_dir "${PHOENIX_PYENV_DIR}"
        backup_dir "${PHOENIX_PYTHON_DIR}"
        backup_dir "${PHOENIX_UV_CACHE}"
        backup_dir "${PHOENIX_UV_LOCAL}/python-cache"
        backup_dir "${PHOENIX_UV_PYTHON}"
      else
        return 0
      fi
    fi
  fi

  # Base download URL
  local -r base_url="https://github.com/astral-sh/python-build-standalone/releases/download/${PHOENIX_PYTHON_GIT_RELEASE}"

  # Base output path
  local -r base_output="${PHOENIX_PYTHON_DIR}/${PHOENIX_PYTHON_GIT_RELEASE}"

  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    echo_red_text 'Downloading Python (Linux - ARM)...'
    download_file "${base_url}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-armv7-unknown-linux-gnueabihf-install_only_stripped.tar.gz" "${base_output}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-armv7-unknown-linux-gnueabihf-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_SHA512SUM_LINUX_ARM}"

    echo_red_text 'Downloading Python (Linux - ARM64)...'
    download_file "${base_url}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-aarch64-unknown-linux-gnu-install_only_stripped.tar.gz" "${base_output}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-aarch64-unknown-linux-gnu-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_SHA512SUM_LINUX_ARM64}"

    echo_red_text 'Downloading Python (Linux - PPC64)...'
    download_file "${base_url}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-ppc64le-unknown-linux-gnu-install_only_stripped.tar.gz" "${base_output}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-ppc64le-unknown-linux-gnu-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_SHA512SUM_LINUX_PPC64}"

    echo_red_text 'Downloading Python (Linux - RISC-V)...'
    download_file "${base_url}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-riscv64-unknown-linux-gnu-install_only_stripped.tar.gz" "${base_output}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-riscv64-unknown-linux-gnu-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_SHA512SUM_LINUX_RISCV}"

    echo_red_text 'Downloading Python (Linux - s390x)...'
    download_file "${base_url}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-s390x-unknown-linux-gnu-install_only_stripped.tar.gz" "${base_output}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-s390x-unknown-linux-gnu-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_SHA512SUM_LINUX_S390X}"

    echo_red_text 'Downloading Python (Linux - x86_64)...'
    download_file "${base_url}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz" "${base_output}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_SHA512SUM_LINUX_X86_64}"

    echo_red_text 'Downloading Python (OS X - ARM64)...'
    download_file "${base_url}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-aarch64-apple-darwin-install_only_stripped.tar.gz" "${base_output}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-aarch64-apple-darwin-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_SHA512SUM_OSX_ARM64}"

    echo_red_text 'Downloading Python (OS X - x86_64)...'
    download_file "${base_url}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-x86_64-apple-darwin-install_only_stripped.tar.gz" "${base_output}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-x86_64-apple-darwin-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_SHA512SUM_OSX_X86_64}"
  else
    # Set our platform
    if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
      local -r PHOENIX_PYTHON_PLATFORM='apple-darwin'
    elif [[ "${PHOENIX_PLATFORM}" == 'linux' ]]; then
      if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm' ]]; then
        local -r PHOENIX_PYTHON_PLATFORM='unknown-linux-gnueabihf'
      else
        local -r PHOENIX_PYTHON_PLATFORM='unknown-linux-gnu'
      fi
    else
      echo_red_text "ERROR: Unsupported platform for Python: '${PHOENIX_PLATFORM}'!"
      return 1
    fi

    # Set our platform architecture
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm' ]]; then
      local -r PHOENIX_PYTHON_ARCH='armv7'
    elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      local -r PHOENIX_PYTHON_ARCH='aarch64'
    elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'ppc64' ]]; then
      local -r PHOENIX_PYTHON_ARCH='powerpc64le'
    elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'riscv' ]]; then
      local -r PHOENIX_PYTHON_ARCH='riscv64gc'
    elif [[ "${PHOENIX_PLATFORM_ARCH}" == 's390x' ]]; then
      local -r PHOENIX_PYTHON_ARCH='s390x'
    elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'x86_64' ]]; then
      local -r PHOENIX_PYTHON_ARCH='x86_64'
    else
      echo_red_text "ERROR: Unsupported architecture for Python: '${PHOENIX_PLATFORM_ARCH}'!"
      return 1
    fi

    # Set our checksum to verify
    if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
      if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
        local -r PHOENIX_PYTHON_SHA512SUM="${PHOENIX_PYTHON_SHA512SUM_OSX_ARM64}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'x86_64' ]]; then
        local -r PHOENIX_PYTHON_SHA512SUM="${PHOENIX_PYTHON_SHA512SUM_OSX_X86_64}"
      else
        echo_red_text "ERROR: Unsupported architecture for Python on OS X: '${PHOENIX_PLATFORM_ARCH}'!"
        return 1
      fi
    elif [[ "${PHOENIX_PLATFORM}" == 'linux' ]]; then
      if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm' ]]; then
        local -r PHOENIX_PYTHON_SHA512SUM="${PHOENIX_PYTHON_SHA512SUM_LINUX_ARM}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
        local -r PHOENIX_PYTHON_SHA512SUM="${PHOENIX_PYTHON_SHA512SUM_LINUX_ARM64}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'ppc64' ]]; then
        local -r PHOENIX_PYTHON_SHA512SUM="${PHOENIX_PYTHON_SHA512SUM_LINUX_PPC64}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'riscv' ]]; then
        local -r PHOENIX_PYTHON_SHA512SUM="${PHOENIX_PYTHON_SHA512SUM_LINUX_RISCV}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 's390x' ]]; then
        local -r PHOENIX_PYTHON_SHA512SUM="${PHOENIX_PYTHON_SHA512SUM_LINUX_S390X}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'x86_64' ]]; then
        local -r PHOENIX_PYTHON_SHA512SUM="${PHOENIX_PYTHON_SHA512SUM_LINUX_X86_64}"
      else
        echo_red_text "ERROR: Unsupported architecture for Python on Linux: '${PHOENIX_PLATFORM_ARCH}'!"
        return 1
      fi
    fi

    # Tell `download` to return instead of exit upon an error
    PHOENIX_DOWNLOAD_EXIT=0

    # By default, we know nothing has failed...
    local PHOENIX_DOWNLOAD_FAILED=0
    local PHOENIX_PYENV_FAILED=0
    local PHOENIX_PYTHON_INSTALL_FAILED=0

    local -r dl_archive="cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-${PHOENIX_PYTHON_ARCH}-${PHOENIX_PYTHON_PLATFORM}-install_only_stripped.tar.gz"
    local -r dl_output="${base_output}/${dl_archive}"
    local -r dl_url="${base_url}/${dl_archive}"

    echo_red_text 'Downloading Python...'
    download_file "${dl_url}" "${dl_output}" "${PHOENIX_PYTHON_SHA512SUM}" || local PHOENIX_DOWNLOAD_FAILED=1

    # If the download failed, restore our back-ups, clean-up, and exit
    if [[ "${PHOENIX_DOWNLOAD_FAILED}" == 1 ]]; then
      echo_red_text "ERROR: Download for Python to path: '${dl_output}' failed!"
      restore_dir "${PHOENIX_PYENV_DIR}"
      restore_dir "${PHOENIX_PYTHON_DIR}"
      restore_dir "${PHOENIX_UV_CACHE}"
      restore_dir "${PHOENIX_UV_PYTHON}"
      restore_dir "${PHOENIX_UV_LOCAL}/python-cache"
      "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp"
      return 1
    elif [[ "${PHOENIX_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
      echo_green_text "SUCCESS: Downloaded Python to path: '${dl_output}'!"

      echo_red_text 'Installing Python...'
      "${PHOENIX_UV}" python install "${PHOENIX_PYTHON_VERSION}" || local PHOENIX_PYTHON_INSTALL_FAILED=1

      # If the install failed, restore our back-ups, clean-up, and exit
      if [[ "${PHOENIX_PYTHON_INSTALL_FAILED}" == 1 ]]; then
        echo_red_text "ERROR: Unable to install Python from path: '${dl_output}'!"
        restore_dir "${PHOENIX_PYENV_DIR}"
        restore_dir "${PHOENIX_PYTHON_DIR}"
        restore_dir "${PHOENIX_UV_CACHE}"
        restore_dir "${PHOENIX_UV_PYTHON}"
        restore_dir "${PHOENIX_UV_LOCAL}/python-cache"
        "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp"
        return 1
      fi

      echo_red_text "Creating Python environment at path: '${PHOENIX_PYENV_DIR}'..."
      "${PHOENIX_UV}" venv "${PHOENIX_PYENV_DIR}" || local PHOENIX_PYENV_FAILED=1

      # If the Python env set-up failed, restore our back-up, clean-up, and exit
      if [[ "${PHOENIX_PYENV_FAILED}" == 1 ]]; then
        echo_red_text "ERROR: Unable to set-up Python environment at path: '${PHOENIX_PYENV_DIR}'!"
        restore_dir "${PHOENIX_PYENV_DIR}"
        "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp"
        return 1
      else
        echo_green_text "SUCCESS: Set-up Python environment at path: '${PHOENIX_PYENV_DIR}'!"
      fi
    fi
  fi
}

# Get s3cmd
function get_s3cmd() {
  # Ensure we have `PHOENIX_S3CMD_COMMIT`
  verify_env "${PHOENIX_S3CMD_COMMIT}" 'PHOENIX_S3CMD_COMMIT' || return 1

  # Ensure we have `PHOENIX_S3CMD_DIR`
  verify_env "${PHOENIX_S3CMD_DIR}" 'PHOENIX_S3CMD_DIR' || return 1

  # Ensure we have `PHOENIX_S3CMD_SHA512SUM`
  verify_env "${PHOENIX_S3CMD_SHA512SUM}" 'PHOENIX_S3CMD_SHA512SUM' || return 1

  # If all we're doing is updating the checksum, we don't care about existing installations
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
    # Ensure we have uv
    verify_exec "${PHOENIX_UV}" 'PHOENIX_UV' || {
      echo_red_text "ERROR: Unable to download and install s3cmd without uv!"
      return 1
    }

    # Ensure we have `PHOENIX_PYENV_DIR`
    verify_env "${PHOENIX_PYENV_DIR}" 'PHOENIX_PYENV_DIR' || return 1

    # Ensure we have `PHOENIX_PYENV`
    verify_env "${PHOENIX_PYENV}" 'PHOENIX_PYENV' || return 1

    # Ensure we have `PHOENIX_UV_DIR`
    verify_env "${PHOENIX_UV_DIR}" 'PHOENIX_UV_DIR' || return 1

    if [[ ! -d "${PHOENIX_UV_DIR}" ]] || [[ ! -f "${PHOENIX_PYENV}" ]]; then
      echo_red_text "ERROR: You tried to download s3cmd, but you don't have a Python environment set-up yet!"
      return 1
    fi

    if [[ -d "${PHOENIX_PYENV_DIR}/bin/s3cmd" ]]; then
      echo_red_text "s3cmd is already installed at path: '${PHOENIX_PYENV_DIR}/bin/s3cmd'!"
      read -p "Do you want to re-download it? [y/N] " -n 1 -r
      echo
      if [[ "${REPLY}" =~ ^[Nn]$ ]]; then
        return 0
      else
        "${PHOENIX_UV}" pip uninstall s3cmd
      fi
    fi
  fi

  echo_red_text "Downloading s3cmd to path: '${PHOENIX_S3CMD_DIR}'..."
  download_and_extract "https://github.com/s3tools/s3cmd/archive/${PHOENIX_S3CMD_COMMIT}.tar.gz" "${PHOENIX_S3CMD_DIR}" "${PHOENIX_S3CMD_SHA512SUM}"

  if [[ "${PHOENIX_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
    source "${PHOENIX_PYENV}" || exit 1
    echo_red_text "Installing s3cmd to path: '${PHOENIX_S3CMD}'..."
    "${PHOENIX_UV}" pip install --no-editable --strict "${PHOENIX_S3CMD_DIR}"
    echo_green_text "SUCCESS: Set-up s3cmd at path: '${PHOENIX_S3CMD}'!"
  fi
}

# Get shellcheck
function get_shellcheck() {
  # Ensure we have `PHOENIX_SHELLCHECK_DIR`
  verify_env "${PHOENIX_SHELLCHECK_DIR}" 'PHOENIX_SHELLCHECK_DIR' || return 1

  # Ensure we have `PHOENIX_SHELLCHECK_VERSION`
  verify_env "${PHOENIX_SHELLCHECK_VERSION}" 'PHOENIX_SHELLCHECK_VERSION' || return 1

  # Base download URL
  local -r base_url="https://github.com/koalaman/shellcheck/releases/download/${PHOENIX_SHELLCHECK_VERSION}"

  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    echo_red_text 'Downloading shellcheck (Linux - ARM64)...'
    download_file "${base_url}/shellcheck-${PHOENIX_SHELLCHECK_VERSION}.linux.aarch64.tar.xz" "${PHOENIX_SHELLCHECK_DIR}" "${PHOENIX_SHELLCHECK_SHA512SUM_LINUX_ARM64}"

    echo_red_text 'Downloading shellcheck (Linux - x86_64)...'
    download_file "${base_url}/shellcheck-${PHOENIX_SHELLCHECK_VERSION}.linux.x86_64.tar.xz" "${PHOENIX_SHELLCHECK_DIR}" "${PHOENIX_SHELLCHECK_SHA512SUM_LINUX_X86_64}"

    echo_red_text 'Downloading shellcheck (OS X - ARM64)...'
    download_file "${base_url}/shellcheck-${PHOENIX_SHELLCHECK_VERSION}.darwin.aarch64.tar.xz" "${PHOENIX_SHELLCHECK_DIR}" "${PHOENIX_SHELLCHECK_SHA512SUM_OSX_ARM64}"

    echo_red_text 'Downloading shellcheck (OS X - x86_64)...'
    download_file "${base_url}/shellcheck-${PHOENIX_SHELLCHECK_VERSION}.darwin.x86_64.tar.xz" "${PHOENIX_SHELLCHECK_DIR}" "${PHOENIX_SHELLCHECK_SHA512SUM_OSX_X86_64}"
  else
    # Set our platform
    if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
      local -r PHOENIX_SHELLCHECK_PLATFORM='darwin'
    elif [[ "${PHOENIX_PLATFORM}" == 'linux' ]]; then
      local -r PHOENIX_SHELLCHECK_PLATFORM='linux'
    else
      echo_red_text "ERROR: Unsupported platform for shellcheck: '${PHOENIX_PLATFORM}'!"
      return 1
    fi

    # Set our platform architecture
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      local -r PHOENIX_SHELLCHECK_ARCH='aarch64'
    elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'x86_64' ]]; then
      local -r PHOENIX_SHELLCHECK_ARCH='x86_64'
    else
      echo_red_text "ERROR: Unsupported architecture for shellcheck: '${PHOENIX_PLATFORM_ARCH}'!"
      return 1
    fi

    # Set our checksum to verify
    if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
      if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
        local -r PHOENIX_SHELLCHECK_SHA512SUM="${PHOENIX_SHELLCHECK_SHA512SUM_OSX_ARM64}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'x86_64' ]]; then
        local -r PHOENIX_SHELLCHECK_SHA512SUM="${PHOENIX_SHELLCHECK_SHA512SUM_OSX_X86_64}"
      else
        echo_red_text "ERROR: Unsupported architecture for shellcheck on OS X: '${PHOENIX_PLATFORM_ARCH}'!"
        return 1
      fi
    elif [[ "${PHOENIX_PLATFORM}" == 'linux' ]]; then
      if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
        local -r PHOENIX_SHELLCHECK_SHA512SUM="${PHOENIX_SHELLCHECK_SHA512SUM_LINUX_ARM64}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'x86_64' ]]; then
        local -r PHOENIX_SHELLCHECK_SHA512SUM="${PHOENIX_SHELLCHECK_SHA512SUM_LINUX_X86_64}"
      else
        echo_red_text "ERROR: Unsupported architecture for shellcheck on Linux: '${PHOENIX_PLATFORM_ARCH}'!"
        return 1
      fi
    fi

    echo_red_text "Downloading shellcheck to path: '${PHOENIX_SHELLCHECK_DIR}'..."
    download_and_extract "${base_url}/shellcheck-${PHOENIX_SHELLCHECK_VERSION}.${PHOENIX_SHELLCHECK_PLATFORM}.${PHOENIX_SHELLCHECK_ARCH}.tar.xz" "${PHOENIX_SHELLCHECK_DIR}" "${PHOENIX_SHELLCHECK_SHA512SUM}"

    if [[ "${PHOENIX_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
      # Set-up the linting pre-commit hook
      if [[ "${PHOENIX_CI}" != 1 ]] && [[ -x "${PHOENIX_GIT}" ]] && [[ ! -f "${PHOENIX_BUILD}/set-hook" ]]; then
        source "${PHOENIX_SCRIPTS}/lint-hook.sh"
      fi

      echo_green_text "SUCCESS: Set-up shellcheck at path: '${PHOENIX_SHELLCHECK}'!"
    fi
  fi
}

# Get shfmt
function get_shfmt() {
  # Ensure we have `PHOENIX_SHFMT`
  verify_env "${PHOENIX_SHFMT}" 'PHOENIX_SHFMT' || return 1

  # Ensure we have `PHOENIX_SHFMT_VERSION`
  verify_env "${PHOENIX_SHFMT_VERSION}" 'PHOENIX_SHFMT_VERSION' || return 1

  # If all we're doing is updating the checksum, we don't care about existing installations
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
    # Ensure we have chmod
    verify_exec "${PHOENIX_CHMOD}" 'PHOENIX_CHMOD' || return 1
  fi

  # Base download URL
  local -r base_url="https://github.com/mvdan/sh/releases/download/${PHOENIX_SHFMT_VERSION}"

  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    echo_red_text 'Downloading shfmt (Linux - ARM64)...'
    download_file "${base_url}/shfmt_${PHOENIX_SHFMT_VERSION}_linux_arm64" "${PHOENIX_SHFMT}" "${PHOENIX_SHFMT_SHA512SUM_LINUX_ARM64}"

    echo_red_text 'Downloading shfmt (Linux - x86_64)...'
    download_file "${base_url}/shfmt_${PHOENIX_SHFMT_VERSION}_linux_amd64" "${PHOENIX_SHFMT}" "${PHOENIX_SHFMT_SHA512SUM_LINUX_X86_64}"

    echo_red_text 'Downloading shfmt (OS X - ARM64)...'
    download_file "${base_url}/shfmt_${PHOENIX_SHFMT_VERSION}_darwin_arm64" "${PHOENIX_SHFMT}" "${PHOENIX_SHFMT_SHA512SUM_OSX_ARM64}"

    echo_red_text 'Downloading shfmt (OS X - x86_64)...'
    download_file "${base_url}/shfmt_${PHOENIX_SHFMT_VERSION}_darwin_amd64" "${PHOENIX_SHFMT}" "${PHOENIX_SHFMT_SHA512SUM_OSX_X86_64}"
  else
    # Set our platform
    if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
      local -r PHOENIX_SHFMT_PLATFORM='darwin'
    elif [[ "${PHOENIX_PLATFORM}" == 'linux' ]]; then
      local -r PHOENIX_SHFMT_PLATFORM='linux'
    else
      echo_red_text "ERROR: Unsupported platform for shfmt: '${PHOENIX_PLATFORM}'!"
      return 1
    fi

    # Set our platform architecture
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      local -r PHOENIX_SHFMT_ARCH='arm64'
    elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'x86_64' ]]; then
      local -r PHOENIX_SHFMT_ARCH='amd64'
    else
      echo_red_text "ERROR: Unsupported architecture for shfmt: '${PHOENIX_PLATFORM_ARCH}'!"
      return 1
    fi

    # Set our checksum to verify
    if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
      if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
        local -r PHOENIX_SHFMT_SHA512SUM="${PHOENIX_SHFMT_SHA512SUM_OSX_ARM64}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'x86_64' ]]; then
        local -r PHOENIX_SHFMT_SHA512SUM="${PHOENIX_SHFMT_SHA512SUM_OSX_X86_64}"
      else
        echo_red_text "ERROR: Unsupported architecture for shfmt on OS X: '${PHOENIX_PLATFORM_ARCH}'!"
        return 1
      fi
    elif [[ "${PHOENIX_PLATFORM}" == 'linux' ]]; then
      if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
        local -r PHOENIX_SHFMT_SHA512SUM="${PHOENIX_SHFMT_SHA512SUM_LINUX_ARM64}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'x86_64' ]]; then
        local -r PHOENIX_SHFMT_SHA512SUM="${PHOENIX_SHFMT_SHA512SUM_LINUX_X86_64}"
      else
        echo_red_text "ERROR: Unsupported architecture for shfmt on Linux: '${PHOENIX_PLATFORM_ARCH}'!"
        return 1
      fi
    fi

    echo_red_text "Downloading shfmt to path: '${PHOENIX_SHFMT}'..."
    download_file "${base_url}/shfmt_${PHOENIX_SHFMT_VERSION}_${PHOENIX_SHFMT_PLATFORM}_${PHOENIX_SHFMT_ARCH}" "${PHOENIX_SHFMT}" "${PHOENIX_SHFMT_SHA512SUM}"

    if [[ "${PHOENIX_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
      "${PHOENIX_CHMOD}" +x "${PHOENIX_SHFMT}"

      # Set-up the linting pre-commit hook
      if [[ "${PHOENIX_CI}" != 1 ]] && [[ -x "${PHOENIX_GIT}" ]] && [[ ! -f "${PHOENIX_BUILD}/set-hook" ]]; then
        source "${PHOENIX_SCRIPTS}/lint-hook.sh"
      fi

      echo_green_text "SUCCESS: Set-up shfmt at path: '${PHOENIX_SHFMT}'!"
    fi
  fi
}

# Get + set-up uv
function get_uv() {
  # Ensure we have `PHOENIX_UV_DIR`
  verify_env "${PHOENIX_UV_DIR}" 'PHOENIX_UV_DIR' || return 1

  # Ensure we have `PHOENIX_UV_VERSION`
  verify_env "${PHOENIX_UV_VERSION}" 'PHOENIX_UV_VERSION' || return 1

  # If all we're doing is updating the checksum, we don't care about existing installations
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
    # Ensure we have `PHOENIX_UV_LOCAL`
    verify_env "${PHOENIX_UV_LOCAL}" 'PHOENIX_UV_LOCAL' || return 1

    if [[ -d "${PHOENIX_UV_DIR}" ]]; then
      echo_red_text "Found existing installation at path: '${PHOENIX_UV_DIR}'!"
      echo 'Continuing will remove this installation and related data.'
      read -p "Do you still want to continue? [y/N] " -n 1 -r
      echo
      if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
        # Back-up (in case something goes wrong - ex. checksum validation fails) and remove our directories
        backup_dir "${PHOENIX_UV_DIR}"
        backup_dir "${PHOENIX_UV_LOCAL}"
      else
        return 0
      fi
    fi
  fi

  # Base download URL
  local -r base_url="https://github.com/astral-sh/uv/releases/download/${PHOENIX_UV_VERSION}"

  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    echo_red_text 'Downloading uv (Linux - ARM)...'
    download_file "${base_url}/uv-armv7-unknown-linux-gnueabihf.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-linux-arm.tar.gz" "${PHOENIX_UV_SHA512SUM_LINUX_ARM}"

    echo_red_text 'Downloading uv (Linux - ARM64)...'
    download_file "${base_url}/uv-aarch64-unknown-linux-gnu.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-linux-arm64.tar.gz" "${PHOENIX_UV_SHA512SUM_LINUX_ARM64}"

    echo_red_text 'Downloading uv (Linux - PPC64)...'
    download_file "${base_url}/uv-powerpc64le-unknown-linux-gnu.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-linux-ppc64.tar.gz" "${PHOENIX_UV_SHA512SUM_LINUX_PPC64}"

    echo_red_text 'Downloading uv (Linux - RISC-V)...'
    download_file "${base_url}/uv-riscv64gc-unknown-linux-gnu.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-linux-riscv.tar.gz" "${PHOENIX_UV_SHA512SUM_LINUX_RISCV}"

    echo_red_text 'Downloading uv (Linux - s390x)...'
    download_file "${base_url}/uv-s390x-unknown-linux-gnu.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-linux-s390x.tar.gz" "${PHOENIX_UV_SHA512SUM_LINUX_S390X}"

    echo_red_text 'Downloading uv (Linux - x86_64)...'
    download_file "${base_url}/uv-x86_64-unknown-linux-gnu.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-linux-x86_64.tar.gz" "${PHOENIX_UV_SHA512SUM_LINUX_X86_64}"

    echo_red_text 'Downloading uv (OS X - ARM64)...'
    download_file "${base_url}/uv-aarch64-apple-darwin.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-osx-arm64.tar.gz" "${PHOENIX_UV_SHA512SUM_OSX_ARM64}"

    echo_red_text 'Downloading uv (OS X - x86_64)...'
    download_file "${base_url}/uv-x86_64-apple-darwin.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-osx-x86_64.tar.gz" "${PHOENIX_UV_SHA512SUM_OSX_X86_64}"
  else
    # Set our platform
    if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
      local -r PHOENIX_UV_PLATFORM='apple-darwin'
    elif [[ "${PHOENIX_PLATFORM}" == 'linux' ]]; then
      if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm' ]]; then
        local -r PHOENIX_UV_PLATFORM='unknown-linux-gnueabihf'
      else
        local -r PHOENIX_UV_PLATFORM='unknown-linux-gnu'
      fi
    else
      echo_red_text "ERROR: Unsupported platform for uv: '${PHOENIX_PLATFORM}'!"
      return 1
    fi

    # Set our platform architecture
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm' ]]; then
      local -r PHOENIX_UV_ARCH='armv7'
    elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      local -r PHOENIX_UV_ARCH='aarch64'
    elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'ppc64' ]]; then
      local -r PHOENIX_UV_ARCH='powerpc64le'
    elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'riscv' ]]; then
      local -r PHOENIX_UV_ARCH='riscv64gc'
    elif [[ "${PHOENIX_PLATFORM_ARCH}" == 's390x' ]]; then
      local -r PHOENIX_UV_ARCH='s390x'
    elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'x86_64' ]]; then
      local -r PHOENIX_UV_ARCH='x86_64'
    else
      echo_red_text "ERROR: Unsupported architecture for uv: '${PHOENIX_PLATFORM_ARCH}'!"
      return 1
    fi

    # Set our checksum to verify
    if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
      if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
        local -r PHOENIX_UV_SHA512SUM="${PHOENIX_UV_SHA512SUM_OSX_ARM64}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'x86_64' ]]; then
        local -r PHOENIX_UV_SHA512SUM="${PHOENIX_UV_SHA512SUM_OSX_X86_64}"
      else
        echo_red_text "ERROR: Unsupported architecture for uv on OS X: '${PHOENIX_PLATFORM_ARCH}'!"
        return 1
      fi
    elif [[ "${PHOENIX_PLATFORM}" == 'linux' ]]; then
      if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm' ]]; then
        local -r PHOENIX_UV_SHA512SUM="${PHOENIX_UV_SHA512SUM_LINUX_ARM}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
        local -r PHOENIX_UV_SHA512SUM="${PHOENIX_UV_SHA512SUM_LINUX_ARM64}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'ppc64' ]]; then
        local -r PHOENIX_UV_SHA512SUM="${PHOENIX_UV_SHA512SUM_LINUX_PPC64}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'riscv' ]]; then
        local -r PHOENIX_UV_SHA512SUM="${PHOENIX_UV_SHA512SUM_LINUX_RISCV}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 's390x' ]]; then
        local -r PHOENIX_UV_SHA512SUM="${PHOENIX_UV_SHA512SUM_LINUX_S390X}"
      elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'x86_64' ]]; then
        local -r PHOENIX_UV_SHA512SUM="${PHOENIX_UV_SHA512SUM_LINUX_X86_64}"
      else
        echo_red_text "ERROR: Unsupported architecture for uv on Linux: '${PHOENIX_PLATFORM_ARCH}'!"
        return 1
      fi
    fi

    # Tell `download` to return instead of exit upon an error
    PHOENIX_DOWNLOAD_EXIT=0

    # By default, we know the download hasn't failed...
    local PHOENIX_DOWNLOAD_FAILED=0

    echo_red_text "Downloading uv to path: '${PHOENIX_UV_DIR}'..."
    download_and_extract "${base_url}/uv-${PHOENIX_UV_ARCH}-${PHOENIX_UV_PLATFORM}.tar.gz" "${PHOENIX_UV_DIR}" "${PHOENIX_UV_SHA512SUM}" || local PHOENIX_DOWNLOAD_FAILED=1

    # If the download failed, restore our back-up, clean-up, and exit
    if [[ "${PHOENIX_DOWNLOAD_FAILED}" == 1 ]]; then
      echo_red_text "ERROR: Download for uv to path: '${PHOENIX_UV_DIR}' failed!"
      restore_dir "${PHOENIX_UV_DIR}"
      restore_dir "${PHOENIX_UV_LOCAL}"
      "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp"
      return 1
    elif [[ "${PHOENIX_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
      echo_green_text "SUCCESS: Set-up uv at path: '${PHOENIX_UV}'!"
    fi
  fi
}

# Clean-up
"${PHOENIX_RM}" -rf "${PHOENIX_DOWNLOADS}"
"${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp"

# These need to run before we get s3cmd
if [[ "${PHOENIX_GET_SOURCE_UV}" == 1 ]]; then
  get_uv
fi

if [[ "${PHOENIX_GET_SOURCE_PYTHON}" == 1 ]]; then
  get_python
fi

if [[ "${PHOENIX_GET_SOURCE_S3CMD}" == 1 ]]; then
  get_s3cmd
fi

if [[ "${PHOENIX_GET_SOURCE_SHELLCHECK}" == 1 ]]; then
  get_shellcheck
fi

if [[ "${PHOENIX_GET_SOURCE_SHFMT}" == 1 ]]; then
  get_shfmt
fi
