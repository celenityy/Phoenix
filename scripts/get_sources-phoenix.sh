#!/bin/bash

set -euo pipefail

# Set-up our environment
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

if [[ -z "${PHOENIX_FROM_SOURCES+x}" ]]; then
  echo_red_text "ERROR: Do not call get_sources-phoenix.sh directly. Instead, use get_sources.sh." >&1
  exit 1
fi

# Set verbosity
if [[ "${PHOENIX_VERBOSE}" == 1 ]]; then
  set -x
else
  set +x
fi

readonly target="$1"
readonly mode="$2"

# Set-up target parameters
PHOENIX_GET_SOURCE_PYTHON=0
PHOENIX_GET_SOURCE_S3CMD=0
PHOENIX_GET_SOURCE_SHELLCHECK=0
PHOENIX_GET_SOURCE_SHFMT=0
PHOENIX_GET_SOURCE_UV=0

if [[ "${target}" == 'python' ]]; then
  # Get Python
  PHOENIX_GET_SOURCE_PYTHON=1
elif [[ "${target}" == 's3cmd' ]]; then
  # Get s3cmd
  PHOENIX_GET_SOURCE_S3CMD=1
elif [[ "${target}" == 'shellcheck' ]]; then
  # Get shellcheck
  PHOENIX_GET_SOURCE_SHELLCHECK=1
elif [[ "${target}" == 'shfmt' ]]; then
  # Get shfmt
  PHOENIX_GET_SOURCE_SHFMT=1
elif [[ "${target}" == 'uv' ]]; then
  # Get + set-up uv
  PHOENIX_GET_SOURCE_UV=1
elif [[ "${target}" == 'all' ]]; then
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
  echo_red_text "ERROR: Invalid target: ${target}\n You must enter one of the following:"
  echo 'All:        all (Default)'
  echo 'Python:     python'
  echo 's3cmd:      s3cmd'
  echo 'shellcheck: shellcheck'
  echo 'shfmt:      shfmt'
  echo 'uv:         uv'
  exit 1
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
  echo_red_text "ERROR: Invalid mode: ${mode}\n You must enter one of the following:"
  echo 'Download:                     download (Default)'
  echo 'Download + update checksums:  checksum-update'
  exit 1
fi
readonly PHOENIX_GET_SOURCE_CHECKSUM_UPDATE

# Include version info
source "${PHOENIX_VERSIONS}"

# Back-up (and remove) a file if it exists
function backup_file() {
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

# Function to automate updating checksums of dependencies
function update_checksum() {
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
    echo_red_text 'ERROR: Unknown checksum type.'
    exit 1
  fi

  if [[ "${old_checksum}" == "${new_checksum}" ]]; then
    echo_red_text 'Checksums match. Skipping...'
    echo "Old checksum: ${old_checksum}"
    echo "New checksum: ${new_checksum}"
  else
    echo_red_text "Updating ${checksum_type_pretty} for ${file}..."
    "${PHOENIX_SED}" -i "s|'${old_checksum}'|'${new_checksum}'|" "${PHOENIX_VERSIONS}"
    echo_green_text "SUCCESS: Updated ${checksum_type_pretty} for ${file}"
  fi
}

function validate_checksum() {
  local -r expected_checksum="$1"
  local -r file="$2"
  local -r checksum_type="$3"

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
    echo_red_text 'ERROR: Unknown checksum type.'
    return 1
  fi

  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    update_checksum "${expected_checksum}" "${local_checksum}" "${file}" "${checksum_type}"
  elif [[ "${local_checksum}" != "${expected_checksum}" ]]; then
    echo_red_text 'ERROR: Checksum validation failed.'
    echo "Expected ${checksum_type_pretty}:   ${expected_checksum}"
    echo "Actual ${checksum_type_pretty}:     ${local_checksum}"

    # If checksum validation fails, also just remove the file
    "${PHOENIX_RM}" -f "${file}"

    return 1
  else
    echo_green_text 'SUCCESS: Checksum validated.'
    echo "${checksum_type_pretty}: ${local_checksum}"
  fi
}

function clone_repo() {
  local -r url="$1"
  local -r path="$2"
  local -r revision="$3"

  if [[ "${url}" == "" ]]; then
    echo_red_text "ERROR: URL missing for clone"
    exit 1
  fi

  if [[ "${path}" == "" ]]; then
    echo_red_text "ERROR: Path is required for cloning '${url}'"
    exit 1
  fi

  if [[ "${revision}" == "" ]]; then
    echo_red_text "ERROR: Revision is required for cloning '${url}'"
    exit 1
  fi

  if [[ -f "${path}" ]]; then
    echo_red_text "ERROR: '${path}' exists and is not a directory"
    exit 1
  fi

  if [[ -d "${path}" ]]; then
    echo_red_text "'${path}' already exists"
    read -p "Do you want to re-clone this repository? [y/N] " -n 1 -r
    echo
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      echo_red_text "Removing ${path}..."
      "${PHOENIX_RM}" -rf "${path}"
    else
      return 0
    fi
  fi

  echo_red_text "Cloning ${url}::${revision}..."
  "${PHOENIX_GIT}" clone --revision="${revision}" --depth=1 "${url}" "${path}"
}

function download() {
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

  if [[ "${url}" == "" ]]; then
    echo_red_text "ERROR: URL is required (file: '${file_in}')"
    PHOENIX_PERFORM_POST_DOWNLOAD=0
    if [[ "${PHOENIX_DOWNLOAD_EXIT}" != 1 ]]; then
      unset PHOENIX_DOWNLOAD_EXIT
      return 1
    else
      exit 1
    fi
  fi

  # If we're doing a checksum update, we download the file to a separate temporary directory, instead of our standard one
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp/chksm"
    local -r file="${PHOENIX_EXTERNAL}/temp/chksm/${file_name}"
  else
    local -r file="${file_in}"
  fi

  if [[ -f "${file}" ]]; then
    echo_red_text "${file} already exists."
    read -p "Do you want to re-download? [y/N] " -n 1 -r
    echo
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      # Back-up (in case something goes wrong - ex. checksum validation fails) and remove our file
      echo_red_text "Removing ${file}..."
      backup_file "${file}"
    else
      unset PHOENIX_DOWNLOAD_EXIT
      PHOENIX_PERFORM_POST_DOWNLOAD=0
      return 0
    fi
  fi

  # By default, we know nothing has failed...
  local PHOENIX_CHECKSUM_FAILED=0
  local PHOENIX_DOWNLOAD_FAILED=0

  if [[ ! -d "$("${PHOENIX_DIRNAME}" "${file}")" ]]; then
    "${PHOENIX_MKDIR}" -vp "$("${PHOENIX_DIRNAME}" "${file}")"
    local -r CREATED_DIR_FOR_DL=1
  else
    local -r CREATED_DIR_FOR_DL=0
  fi

  echo_red_text "Downloading ${url}..."
  "${PHOENIX_CURL}" ${PHOENIX_CURL_FLAGS} --location "${url}" --output "${file}" || local PHOENIX_DOWNLOAD_FAILED=1

  # Verify (or update) SHA512sum
  validate_checksum "${expected_sha512sum}" "${file}" 'sha512sum' || local PHOENIX_CHECKSUM_FAILED=1

  # If we're just updating the checksum, we're done, so go ahead and exit
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    if [[ "${PHOENIX_DOWNLOAD_FAILED}" == 1 ]]; then
      echo_red_text 'ERROR: Download failed! Exiting...'
      exit 1
    elif [[ "${PHOENIX_CHECKSUM_FAILED}" == 1 ]]; then
      echo_red_text 'ERROR: Failed to update checksum! Exiting...'
      exit 1
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
    # If a directory was created just for this download, remove it
    if [[ "${CREATED_DIR_FOR_DL}" == 1 ]]; then
      "${PHOENIX_RM}" -rf "$("${PHOENIX_DIRNAME}" "${file}")"
    fi
    if [[ "${PHOENIX_DOWNLOAD_EXIT}" != 1 ]]; then
      unset PHOENIX_DOWNLOAD_EXIT
      return 1
    else
      echo_red_text 'ERROR: Download failed! Exiting...'
      exit 1
    fi
  fi
}

# Extract archives
function extract() {
  local -r archive_path="$1"
  local -r target_path="$2"
  local -r temp_repo_name="$3"

  if [[ ! -f "${archive_path}" ]]; then
    echo_red_text "ERROR: Archive '${archive_path}' does not exist!"
  fi

  # If our temporary directory for extraction already exists, delete it
  if [[ -d "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}" ]]; then
    "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}"
  fi

  # Create temporary directory for extraction
  "${PHOENIX_MKDIR}" -p "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}"

  # Extract based on file extension
  case "${archive_path}" in
    *.zip)
      "${PHOENIX_UNZIP}" -q "${archive_path}" -d "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}"
      ;;
    *.tar.gz)
      "${PHOENIX_TAR}" xzf "${archive_path}" -C "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}"
      ;;
    *.tar.xz)
      "${PHOENIX_TAR}" xJf "${archive_path}" -C "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}"
      ;;
    *.tar.zst)
      "${PHOENIX_TAR}" --zstd -xvf "${archive_path}" -C "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}"
      ;;
    *)
      echo_red_text "ERROR: Unsupported archive format: ${archive_path}"
      "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}"
      exit 1
      ;;
  esac

  local -r top_input_dir=$("${PHOENIX_LS}" "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}")
  "${PHOENIX_CP}" -rf "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}/${top_input_dir}/" "${target_path}"
  "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}"
}

function download_and_extract() {
  local -r repo_name="$1"
  local -r url="$2"
  local -r path="$3"
  local -r expected_sha512sum="$4"

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
    echo_red_text "'${path}' already exists"
    read -p "Do you want to re-download? [y/N] " -n 1 -r
    echo
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      # Back-up (in case something goes wrong - ex. checksum validation fails) and remove our directory
      echo_red_text "Removing ${path}..."
      backup_dir "${path}"
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

  local -r repo_archive="${PHOENIX_DOWNLOADS}/${repo_name}${extension}"
  download "${url}" "${repo_archive}" "${expected_sha512sum}" || local PHOENIX_DOWNLOAD_FAILED=1

  # If we're just updating the checksum, we're done, so go ahead and exit
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    if [[ "${PHOENIX_DOWNLOAD_FAILED}" == 1 ]]; then
      echo_red_text 'ERROR: Download failed! Exiting...'
      exit 1
    else
      return 0
    fi
  fi

  # If the download failed, restore our back-up (if possible) and exit
  if [[ "${PHOENIX_DOWNLOAD_FAILED}" == 1 ]]; then
    restore_dir "${path}"
    if [[ "${repo_name}" == 'uv' ]]; then
      PHOENIX_PERFORM_POST_DOWNLOAD=0
      return 1
    else
      echo_red_text 'ERROR: Download failed! Exiting...'
      exit 1
    fi
  fi

  echo_red_text "Extracting ${repo_archive}..."
  extract "${repo_archive}" "${path}" "${repo_name}"

  # Clean-up
  "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp/backup/${repo_name}"
}

# Get Python
function get_python() {
  # If all we're doing is updating the checksum, we don't care about existing installations
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
    if [[ ! -x "${PHOENIX_UV}" ]]; then
      echo_red_text "ERROR: You tried to download Python, but you're missing uv!"
      exit 1
    fi

    if [[ -d "${PHOENIX_PYENV_DIR}" ]]; then
      echo_red_text "The Python environment is already set-up at ${PHOENIX_PYENV_DIR}"
      read -p "Do you want to re-create it? [y/N] " -n 1 -r
      echo
      if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
        # Back-up (in case something goes wrong - ex. checksum validation fails) and remove our directory
        backup_dir "${PHOENIX_PYENV_DIR}"
      fi
    fi

    if [[ -d "${PHOENIX_PYTHON_DIR}" ]]; then
      echo_red_text "Found existing installation at ${PHOENIX_PYTHON_DIR}"
      echo 'Continuing will remove this installation and related data'
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

  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    echo_red_text 'Downloading Python (Linux - ARM64)...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${PHOENIX_PYTHON_GIT_RELEASE}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-aarch64-unknown-linux-gnu-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_DIR}/${PHOENIX_PYTHON_GIT_RELEASE}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-aarch64-unknown-linux-gnu-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_SHA512SUM_LINUX_ARM64}"

    echo_red_text 'Downloading Python (Linux - x86_64)...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${PHOENIX_PYTHON_GIT_RELEASE}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_DIR}/${PHOENIX_PYTHON_GIT_RELEASE}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_SHA512SUM_LINUX_X86_64}"

    echo_red_text 'Downloading Python (OS X - ARM64)...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${PHOENIX_PYTHON_GIT_RELEASE}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-aarch64-apple-darwin-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_DIR}/${PHOENIX_PYTHON_GIT_RELEASE}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-aarch64-apple-darwin-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_SHA512SUM_OSX_ARM64}"

    echo_red_text 'Downloading Python (OS X - x86_64)...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${PHOENIX_PYTHON_GIT_RELEASE}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-x86_64-apple-darwin-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_DIR}/${PHOENIX_PYTHON_GIT_RELEASE}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-x86_64-apple-darwin-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_SHA512SUM_OSX_X86_64}"
  else
    # Set our platform
    if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
      local -r PHOENIX_PYTHON_PLATFORM='apple-darwin'
    else
      local -r PHOENIX_PYTHON_PLATFORM='unknown-linux-gnu'
    fi

    # Set our platform architecture
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      local -r PHOENIX_PYTHON_ARCH='aarch64'
    else
      local -r PHOENIX_PYTHON_ARCH='x86_64'
    fi

    # Set our checksum to verify
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
        local -r PHOENIX_PYTHON_SHA512SUM="${PHOENIX_PYTHON_SHA512SUM_OSX_ARM64}"
      else
        local -r PHOENIX_PYTHON_SHA512SUM="${PHOENIX_PYTHON_SHA512SUM_LINUX_ARM64}"
      fi
    else
      if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
        local -r PHOENIX_PYTHON_SHA512SUM="${PHOENIX_PYTHON_SHA512SUM_OSX_X86_64}"
      else
        local -r PHOENIX_PYTHON_SHA512SUM="${PHOENIX_PYTHON_SHA512SUM_LINUX_X86_64}"
      fi
    fi

    # Tell `download` to return instead of exit upon an error
    PHOENIX_DOWNLOAD_EXIT=0

    # By default, we know nothing has failed...
    local PHOENIX_DOWNLOAD_FAILED=0
    local PHOENIX_PYENV_FAILED=0
    local PHOENIX_PYTHON_INSTALL_FAILED=0

    echo_red_text 'Downloading Python...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${PHOENIX_PYTHON_GIT_RELEASE}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-${PHOENIX_PYTHON_ARCH}-${PHOENIX_PYTHON_PLATFORM}-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_DIR}/${PHOENIX_PYTHON_GIT_RELEASE}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-${PHOENIX_PYTHON_ARCH}-${PHOENIX_PYTHON_PLATFORM}-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_SHA512SUM}" || local PHOENIX_DOWNLOAD_FAILED=1

    # If the download failed, restore our back-ups, clean-up, and exit
    if [[ "${PHOENIX_DOWNLOAD_FAILED}" == 1 ]]; then
      restore_dir "${PHOENIX_PYENV_DIR}"
      restore_dir "${PHOENIX_PYTHON_DIR}"
      restore_dir "${PHOENIX_UV_CACHE}"
      restore_dir "${PHOENIX_UV_PYTHON}"
      restore_dir "${PHOENIX_UV_LOCAL}/python-cache"
      "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp"
      exit 1
    elif [[ "${PHOENIX_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
      echo_green_text "SUCCESS: Downloaded Python to ${PHOENIX_PYTHON_DIR}/${PHOENIX_PYTHON_GIT_RELEASE}/cpython-${PHOENIX_PYTHON_VERSION}+${PHOENIX_PYTHON_GIT_RELEASE}-${PHOENIX_PYTHON_ARCH}-${PHOENIX_PYTHON_PLATFORM}-install_only_stripped.tar.gz"

      echo_red_text 'Installing Python...'
      "${PHOENIX_UV}" python install "${PHOENIX_PYTHON_VERSION}" || local PHOENIX_PYTHON_INSTALL_FAILED=1

      # If the install failed, restore our back-ups, clean-up, and exit
      if [[ "${PHOENIX_PYTHON_INSTALL_FAILED}" == 1 ]]; then
        restore_dir "${PHOENIX_PYENV_DIR}"
        restore_dir "${PHOENIX_PYTHON_DIR}"
        restore_dir "${PHOENIX_UV_CACHE}"
        restore_dir "${PHOENIX_UV_PYTHON}"
        restore_dir "${PHOENIX_UV_LOCAL}/python-cache"
        "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp"
        exit 1
      fi

      echo_red_text 'Creating Python environment...'
      "${PHOENIX_UV}" venv "${PHOENIX_PYENV_DIR}" || local PHOENIX_PYENV_FAILED=1

      # If the Python env set-up failed, restore our back-up, clean-up, and exit
      if [[ "${PHOENIX_PYENV_FAILED}" == 1 ]]; then
        echo_red_text 'ERROR: Download failed! Exiting...'
        restore_dir "${PHOENIX_PYENV_DIR}"
        "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp"
        exit 1
      else
        echo_green_text "SUCCESS: Set-up Python environment at ${PHOENIX_PYENV_DIR}"
      fi
    fi
  fi
}

# Get s3cmd
function get_s3cmd() {
  # If all we're doing is updating the checksum, we don't care about existing installations
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]]; then
    if [[ ! -d "${PHOENIX_UV_DIR}" ]] || [[ ! -f "${PHOENIX_PYENV}" ]]; then
      echo_red_text "ERROR: You tried to download s3cmd, but you don't have a Python environment set-up yet."
      exit 1
    fi

    if [[ -d "${PHOENIX_PYENV_DIR}/bin/s3cmd" ]]; then
      echo_red_text "s3cmd is already installed at ${PHOENIX_PYENV_DIR}/bin/s3cmd"
      read -p "Do you want to re-download it? [y/N] " -n 1 -r
      echo
      if [[ "${REPLY}" =~ ^[Nn]$ ]]; then
        return 0
      else
        source "${PHOENIX_PYENV}"
        "${PHOENIX_UV}" pip uninstall s3cmd
      fi
    fi
  fi

  echo_red_text "Downloading s3cmd..."
  download_and_extract 's3cmd' "https://github.com/s3tools/s3cmd/archive/${PHOENIX_S3CMD_COMMIT}.tar.gz" "${PHOENIX_S3CMD_DIR}" "${PHOENIX_S3CMD_SHA512SUM}"

  if [[ "${PHOENIX_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
    source "${PHOENIX_PYENV}"
    echo_red_text 'Installing s3cmd...'
    "${PHOENIX_UV}" pip install --no-editable --strict "${PHOENIX_S3CMD_DIR}"
    echo_green_text "SUCCESS: Set-up s3cmd at ${PHOENIX_S3CMD}"
  fi
}

# Get shellcheck
function get_shellcheck() {
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    echo_red_text 'Downloading shellcheck (Linux - ARM64)...'
    download "https://github.com/koalaman/shellcheck/releases/download/${PHOENIX_SHELLCHECK_VERSION}/shellcheck-${PHOENIX_SHELLCHECK_VERSION}.linux.aarch64.tar.xz" "${PHOENIX_SHELLCHECK_DIR}" "${PHOENIX_SHELLCHECK_SHA512SUM_LINUX_ARM64}"

    echo_red_text 'Downloading shellcheck (Linux - x86_64)...'
    download "https://github.com/koalaman/shellcheck/releases/download/${PHOENIX_SHELLCHECK_VERSION}/shellcheck-${PHOENIX_SHELLCHECK_VERSION}.linux.x86_64.tar.xz" "${PHOENIX_SHELLCHECK_DIR}" "${PHOENIX_SHELLCHECK_SHA512SUM_LINUX_X86_64}"

    echo_red_text 'Downloading shellcheck (OS X - ARM64)...'
    download "https://github.com/koalaman/shellcheck/releases/download/${PHOENIX_SHELLCHECK_VERSION}/shellcheck-${PHOENIX_SHELLCHECK_VERSION}.darwin.aarch64.tar.xz" "${PHOENIX_SHELLCHECK_DIR}" "${PHOENIX_SHELLCHECK_SHA512SUM_OSX_ARM64}"

    echo_red_text 'Downloading shellcheck (OS X - x86_64)...'
    download "https://github.com/koalaman/shellcheck/releases/download/${PHOENIX_SHELLCHECK_VERSION}/shellcheck-${PHOENIX_SHELLCHECK_VERSION}.darwin.x86_64.tar.xz" "${PHOENIX_SHELLCHECK_DIR}" "${PHOENIX_SHELLCHECK_SHA512SUM_OSX_X86_64}"
  else
    # Set our platform
    if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
      local -r PHOENIX_SHELLCHECK_PLATFORM='darwin'
    else
      local -r PHOENIX_SHELLCHECK_PLATFORM='linux'
    fi

    # Set our platform architecture
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      local -r PHOENIX_SHELLCHECK_ARCH='aarch64'
    else
      local -r PHOENIX_SHELLCHECK_ARCH='x86_64'
    fi

    # Set our checksum to verify
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
        local -r PHOENIX_SHELLCHECK_SHA512SUM="${PHOENIX_SHELLCHECK_SHA512SUM_OSX_ARM64}"
      else
        local -r PHOENIX_SHELLCHECK_SHA512SUM="${PHOENIX_SHELLCHECK_SHA512SUM_LINUX_ARM64}"
      fi
    else
      if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
        local -r PHOENIX_SHELLCHECK_SHA512SUM="${PHOENIX_SHELLCHECK_SHA512SUM_OSX_X86_64}"
      else
        local -r PHOENIX_SHELLCHECK_SHA512SUM="${PHOENIX_SHELLCHECK_SHA512SUM_LINUX_X86_64}"
      fi
    fi

    echo_red_text 'Downloading shellcheck...'
    download_and_extract 'shellcheck' "https://github.com/koalaman/shellcheck/releases/download/${PHOENIX_SHELLCHECK_VERSION}/shellcheck-${PHOENIX_SHELLCHECK_VERSION}.${PHOENIX_SHELLCHECK_PLATFORM}.${PHOENIX_SHELLCHECK_ARCH}.tar.xz" "${PHOENIX_SHELLCHECK_DIR}" "${PHOENIX_SHELLCHECK_SHA512SUM}"

    if [[ "${PHOENIX_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
      # Set-up the linting pre-commit hook
      if [[ "${PHOENIX_CI}" != 1 ]] && [[ -x "${PHOENIX_GIT}" ]] && [[ ! -f "${PHOENIX_BUILD}/set-hook" ]]; then
        /bin/bash "${PHOENIX_SCRIPTS}/lint-hook.sh"
      fi

      echo_green_text "SUCCESS: Set-up shellcheck at ${PHOENIX_SHELLCHECK}"
    fi
  fi
}

# Get shfmt
function get_shfmt() {
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    echo_red_text 'Downloading shfmt (Linux - ARM64)...'
    download "https://github.com/mvdan/sh/releases/download/${PHOENIX_SHFMT_VERSION}/shfmt_${PHOENIX_SHFMT_VERSION}_linux_arm64" "${PHOENIX_SHFMT}" "${PHOENIX_SHFMT_SHA512SUM_LINUX_ARM64}"

    echo_red_text 'Downloading shfmt (Linux - x86_64)...'
    download "https://github.com/mvdan/sh/releases/download/${PHOENIX_SHFMT_VERSION}/shfmt_${PHOENIX_SHFMT_VERSION}_linux_amd64" "${PHOENIX_SHFMT}" "${PHOENIX_SHFMT_SHA512SUM_LINUX_X86_64}"

    echo_red_text 'Downloading shfmt (OS X - ARM64)...'
    download "https://github.com/mvdan/sh/releases/download/${PHOENIX_SHFMT_VERSION}/shfmt_${PHOENIX_SHFMT_VERSION}_darwin_arm64" "${PHOENIX_SHFMT}" "${PHOENIX_SHFMT_SHA512SUM_OSX_ARM64}"

    echo_red_text 'Downloading shfmt (OS X - x86_64)...'
    download "https://github.com/mvdan/sh/releases/download/${PHOENIX_SHFMT_VERSION}/shfmt_${PHOENIX_SHFMT_VERSION}_darwin_amd64" "${PHOENIX_SHFMT}" "${PHOENIX_SHFMT_SHA512SUM_OSX_X86_64}"
  else
    # Set our platform
    if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
      local -r PHOENIX_SHFMT_PLATFORM='darwin'
    else
      local -r PHOENIX_SHFMT_PLATFORM='linux'
    fi

    # Set our platform architecture
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      local -r PHOENIX_SHFMT_ARCH='arm64'
    else
      local -r PHOENIX_SHFMT_ARCH='amd64'
    fi

    # Set our checksum to verify
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
        local -r PHOENIX_SHFMT_SHA512SUM="${PHOENIX_SHFMT_SHA512SUM_OSX_ARM64}"
      else
        local -r PHOENIX_SHFMT_SHA512SUM="${PHOENIX_SHFMT_SHA512SUM_LINUX_ARM64}"
      fi
    else
      if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
        local -r PHOENIX_SHFMT_SHA512SUM="${PHOENIX_SHFMT_SHA512SUM_OSX_X86_64}"
      else
        local -r PHOENIX_SHFMT_SHA512SUM="${PHOENIX_SHFMT_SHA512SUM_LINUX_X86_64}"
      fi
    fi

    echo_red_text 'Downloading shfmt...'
    download "https://github.com/mvdan/sh/releases/download/${PHOENIX_SHFMT_VERSION}/shfmt_${PHOENIX_SHFMT_VERSION}_${PHOENIX_SHFMT_PLATFORM}_${PHOENIX_SHFMT_ARCH}" "${PHOENIX_SHFMT}" "${PHOENIX_SHFMT_SHA512SUM}"

    if [[ "${PHOENIX_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
      "${PHOENIX_CHMOD}" +x "${PHOENIX_SHFMT}"

      # Set-up the linting pre-commit hook
      if [[ "${PHOENIX_CI}" != 1 ]] && [[ -x "${PHOENIX_GIT}" ]] && [[ ! -f "${PHOENIX_BUILD}/set-hook" ]]; then
        /bin/bash "${PHOENIX_SCRIPTS}/lint-hook.sh"
      fi

      echo_green_text "SUCCESS: Set-up shfmt at ${PHOENIX_SHFMT}"
    fi
  fi
}

# Get + set-up uv
function get_uv() {
  # If all we're doing is updating the checksum, we don't care about existing installations
  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]] && [[ -d "${PHOENIX_UV_DIR}" ]]; then
    echo_red_text "Found existing installation at ${PHOENIX_UV_DIR}"
    echo 'Continuing will remove this installation and related data'
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

  if [[ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]]; then
    echo_red_text 'Downloading uv (Linux - ARM64)...'
    download "https://github.com/astral-sh/uv/releases/download/${PHOENIX_UV_VERSION}/uv-aarch64-unknown-linux-gnu.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-linux-arm64.tar.gz" "${PHOENIX_UV_SHA512SUM_LINUX_ARM64}"

    echo_red_text 'Downloading uv (Linux - x86_64)...'
    download "https://github.com/astral-sh/uv/releases/download/${PHOENIX_UV_VERSION}/uv-x86_64-unknown-linux-gnu.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-linux-x86_64.tar.gz" "${PHOENIX_UV_SHA512SUM_LINUX_X86_64}"

    echo_red_text 'Downloading uv (OS X - ARM64)...'
    download "https://github.com/astral-sh/uv/releases/download/${PHOENIX_UV_VERSION}/uv-aarch64-apple-darwin.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-osx-arm64.tar.gz" "${PHOENIX_UV_SHA512SUM_OSX_ARM64}"

    echo_red_text 'Downloading uv (OS X - x86_64)...'
    download "https://github.com/astral-sh/uv/releases/download/${PHOENIX_UV_VERSION}/uv-x86_64-apple-darwin.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-osx-x86_64.tar.gz" "${PHOENIX_UV_SHA512SUM_OSX_X86_64}"
  else
    # Set our platform
    if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
      local -r PHOENIX_UV_PLATFORM='apple-darwin'
    else
      local -r PHOENIX_UV_PLATFORM='unknown-linux-gnu'
    fi

    # Set our platform architecture
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      local -r PHOENIX_UV_ARCH='aarch64'
    else
      local -r PHOENIX_UV_ARCH='x86_64'
    fi

    # Set our checksum to verify
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
        local -r PHOENIX_UV_SHA512SUM="${PHOENIX_UV_SHA512SUM_OSX_ARM64}"
      else
        local -r PHOENIX_UV_SHA512SUM="${PHOENIX_UV_SHA512SUM_LINUX_ARM64}"
      fi
    else
      if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
        local -r PHOENIX_UV_SHA512SUM="${PHOENIX_UV_SHA512SUM_OSX_X86_64}"
      else
        local -r PHOENIX_UV_SHA512SUM="${PHOENIX_UV_SHA512SUM_LINUX_X86_64}"
      fi
    fi

    # Tell `download` to return instead of exit upon an error
    PHOENIX_DOWNLOAD_EXIT=0

    # By default, we know the download hasn't failed...
    local PHOENIX_DOWNLOAD_FAILED=0

    echo_red_text 'Downloading uv...'
    download_and_extract 'uv' "https://github.com/astral-sh/uv/releases/download/${PHOENIX_UV_VERSION}/uv-${PHOENIX_UV_ARCH}-${PHOENIX_UV_PLATFORM}.tar.gz" "${PHOENIX_UV_DIR}" "${PHOENIX_UV_SHA512SUM}" || local PHOENIX_DOWNLOAD_FAILED=1

    # If the download failed, restore our back-up, clean-up, and exit
    if [[ "${PHOENIX_DOWNLOAD_FAILED}" == 1 ]]; then
      echo_red_text 'ERROR: Download failed! Exiting...'
      restore_dir "${PHOENIX_UV_DIR}"
      restore_dir "${PHOENIX_UV_LOCAL}"
      "${PHOENIX_RM}" -rf "${PHOENIX_EXTERNAL}/temp"
      exit 1
    elif [[ "${PHOENIX_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
      echo_green_text "SUCCESS: Set-up uv at ${PHOENIX_UV}"
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
