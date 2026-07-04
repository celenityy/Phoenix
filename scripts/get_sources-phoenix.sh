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

readonly target="$1"
readonly mode="$2"

# Set-up target parameters
PHOENIX_GET_SOURCE_PYTHON=0
PHOENIX_GET_SOURCE_S3CMD=0
PHOENIX_GET_SOURCE_UV=0

if [[ "${target}" == 'python' ]]; then
  # Get Python
  PHOENIX_GET_SOURCE_PYTHON=1
elif [[ "${target}" == 's3cmd' ]]; then
  # Get s3cmd
  PHOENIX_GET_SOURCE_S3CMD=1
elif [[ "${target}" == 'uv' ]]; then
  # Get + set-up uv
  PHOENIX_GET_SOURCE_UV=1
elif [[ "${target}" == 'all' ]]; then
  # If no argument is specified (or argument is set to "all"), just get everything, except s3cmd
  ## (We don't need to bother getting s3cmd here since it's only used in certain scenarios)
  PHOENIX_GET_SOURCE_PYTHON=1
  PHOENIX_GET_SOURCE_UV=1
else
  echo_red_text "ERROR: Invalid target: ${target}\n You must enter one of the following:"
  echo 'All:      all (Default)'
  echo 'Python:   python'
  echo 's3cmd:    s3cmd'
  echo 'uv:       uv'
  exit 1
fi
readonly PHOENIX_GET_SOURCE_PYTHON
readonly PHOENIX_GET_SOURCE_S3CMD
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
  local readonly file="$1"
  local readonly file_name="$(basename "${file}")"
  local readonly backup_file="${PHOENIX_EXTERNAL}/temp/backup/${file_name}"

  if [[ -f "${file}" ]]; then
    rm -f "${backup_file}"
    mkdir -p "$(dirname "${backup_file}")"
    cp -f "${file}" "${backup_file}"
    rm -f "${file}"
  fi
}

# Back-up (and remove) a directory if it exists
function backup_dir() {
  local readonly dir="$1"
  local readonly dir_name="$(basename "${dir}")"
  local readonly backup_dir="${PHOENIX_EXTERNAL}/temp/backup/${dir_name}"

  if [[ -d "${dir}" ]]; then
    rm -rf "${backup_dir}"
    mkdir -p "$(dirname "${backup_dir}")"
    cp -rf "${dir}/" "${backup_dir}"
    rm -rf "${dir}"
  fi
}

# Restore a backed-up file
function restore_file() {
  local readonly file="$1"
  local readonly file_name="$(basename "${file}")"
  local readonly backed_up_file="${PHOENIX_EXTERNAL}/temp/backup/${file_name}"

  if [[ -f "${backed_up_file}" ]]; then
    rm -f "${file}"
    mkdir -p "$(dirname "${file}")"
    cp -f "${backed_up_file}" "${file}"
    rm -f "${backed_up_file}"
  fi
}

# Restore a backed-up directory
function restore_dir() {
  local readonly dir="$1"
  local readonly dir_name="$(basename "${dir}")"
  local readonly backed_up_dir="${PHOENIX_EXTERNAL}/temp/backup/${dir_name}"

  if [[ -d "${backed_up_dir}" ]]; then
    rm -rf "${dir}"
    mkdir -p "$(dirname "${dir}")"
    cp -rf "${backed_up_dir}/" "${dir}"
    rm -rf "${backed_up_dir}"
  fi
}

# Function to automate updating checksums of dependencies
function update_checksum() {
  local readonly old_checksum="$1"
  local readonly new_checksum="$2"
  local readonly file="$3"
  local readonly checksum_type="$4"

  if [[ "${checksum_type}" == 'md5sum' ]]; then
    local readonly checksum_type_pretty='MD5sum'
  elif [[ "${checksum_type}" == 'sha1sum' ]]; then
    local readonly checksum_type_pretty='SHA1sum'
  elif [[ "${checksum_type}" == 'sha256sum' ]]; then
    local readonly checksum_type_pretty='SHA256sum'
  elif [[ "${checksum_type}" == 'sha512sum' ]]; then
    local readonly checksum_type_pretty='SHA512sum'
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
  local readonly expected_checksum="$1"
  local readonly file="$2"
  local readonly checksum_type="$3"

  if [[ "${checksum_type}" == 'md5sum' ]]; then
    local readonly checksum_type_pretty='MD5sum'
    local readonly local_checksum=$(md5sum "${file}" | "${PHOENIX_AWK}" '{print $1}')
  elif [[ "${checksum_type}" == 'sha1sum' ]]; then
    local readonly checksum_type_pretty='SHA1sum'
    local readonly local_checksum=$(sha1sum "${file}" | "${PHOENIX_AWK}" '{print $1}')
  elif [[ "${checksum_type}" == 'sha256sum' ]]; then
    local readonly checksum_type_pretty='SHA256sum'
    local readonly local_checksum=$(sha256sum "${file}" | "${PHOENIX_AWK}" '{print $1}')
  elif [[ "${checksum_type}" == 'sha512sum' ]]; then
    local readonly checksum_type_pretty='SHA512sum'
    local readonly local_checksum=$(sha512sum "${file}" | "${PHOENIX_AWK}" '{print $1}')
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
    rm -f "${file}"

    return 1
  else
    echo_green_text 'SUCCESS: Checksum validated.'
    echo "${checksum_type_pretty}: ${local_checksum}"
  fi
}

function clone_repo() {
  local readonly url="$1"
  local readonly path="$2"
  local readonly revision="$3"

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
      rm -rf "${path}"
    else
      return 0
    fi
  fi

  echo_red_text "Cloning ${url}::${revision}..."
  git clone --revision="${revision}" --depth=1 "${url}" "${path}"
}

function download() {
  local readonly url="$1"
  local readonly file_in="$2"
  local readonly file_name=$(basename "${file_in}")
  local readonly expected_sha512sum="$3"

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
    rm -rf "${PHOENIX_EXTERNAL}/temp/chksm"
    local readonly file="${PHOENIX_EXTERNAL}/temp/chksm/${file_name}"
  else
    local readonly file="${file_in}"
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

  if [[ ! -d "$(dirname "${file}")" ]]; then
    mkdir -vp "$(dirname "${file}")"
    local readonly CREATED_DIR_FOR_DL=1
  else
    local readonly CREATED_DIR_FOR_DL=0
  fi

  echo_red_text "Downloading ${url}..."
  curl ${PHOENIX_CURL_FLAGS} --location "${url}" --output "${file}" || local PHOENIX_DOWNLOAD_FAILED=1

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
  rm -f "${PHOENIX_EXTERNAL}/temp/backup/${file_name}"
  rm -rf "${PHOENIX_EXTERNAL}/temp/chksm"

  # If the download (or checksum validation) failed, exit
  if [[ "${PHOENIX_CHECKSUM_FAILED}" == 1 ]] || [[ "${PHOENIX_DOWNLOAD_FAILED}" == 1 ]]; then
    # If a directory was created just for this download, remove it
    if [[ "${CREATED_DIR_FOR_DL}" == 1 ]]; then
      rm -rf "$(dirname "${file}")"
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
  local readonly archive_path="$1"
  local readonly target_path="$2"
  local readonly temp_repo_name="$3"

  if [[ ! -f "${archive_path}" ]]; then
    echo_red_text "ERROR: Archive '${archive_path}' does not exist!"
  fi

  # If our temporary directory for extraction already exists, delete it
  if [[ -d "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}" ]]; then
    rm -rf "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}"
  fi

  # Create temporary directory for extraction
  mkdir -p "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}"

  # Extract based on file extension
  case "${archive_path}" in
    *.zip)
      unzip -q "${archive_path}" -d "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}"
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
      rm -rf "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}"
      exit 1
      ;;
  esac

  local readonly top_input_dir=$(ls "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}")
  cp -rf "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}/${top_input_dir}/" "${target_path}"
  rm -rf "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}"
}

function download_and_extract() {
  local readonly repo_name="$1"
  local readonly url="$2"
  local readonly path="$3"
  local readonly expected_sha512sum="$4"

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

  local readonly extension
  if [[ "${url}" =~ \.tar\.xz$ ]]; then
    local readonly extension=".tar.xz"
  elif [[ "${url}" =~ \.tar\.gz$ ]]; then
    local readonly extension=".tar.gz"
  elif [[ "${url}" =~ \.tar\.zst$ ]]; then
    local readonly extension=".tar.zst"
  else
    local readonly extension=".zip"
  fi

  # Tell `download` to return instead of exit upon an error
  PHOENIX_DOWNLOAD_EXIT=0

  # By default, we know the download hasn't failed...
  local PHOENIX_DOWNLOAD_FAILED=0

  local readonly repo_archive="${PHOENIX_DOWNLOADS}/${repo_name}${extension}"
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
  rm -rf "${PHOENIX_EXTERNAL}/temp/backup/${repo_name}"
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
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-unknown-linux-gnu-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-unknown-linux-gnu-install_only_stripped.tar.gz" "${PYTHON_SHA512SUM_LINUX_ARM64}"

    echo_red_text 'Downloading Python (Linux - x86_64)...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz" "${PYTHON_SHA512SUM_LINUX_X86_64}"

    echo_red_text 'Downloading Python (OS X - ARM64)...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-apple-darwin-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-apple-darwin-install_only_stripped.tar.gz" "${PYTHON_SHA512SUM_OSX_ARM64}"

    echo_red_text 'Downloading Python (OS X - x86_64)...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-apple-darwin-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-apple-darwin-install_only_stripped.tar.gz" "${PYTHON_SHA512SUM_OSX_X86_64}"
  else
    # Set our platform
    if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
      local readonly PYTHON_PLATFORM='apple-darwin'
    else
      local readonly PYTHON_PLATFORM='unknown-linux-gnu'
    fi

    # Set our platform architecture
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      local readonly PYTHON_ARCH='aarch64'
    else
      local readonly PYTHON_ARCH='x86_64'
    fi

    # Set our checksum to verify
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
        local readonly PYTHON_SHA512SUM="${PYTHON_SHA512SUM_OSX_ARM64}"
      else
        local readonly PYTHON_SHA512SUM="${PYTHON_SHA512SUM_LINUX_ARM64}"
      fi
    else
      if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
        local readonly PYTHON_SHA512SUM="${PYTHON_SHA512SUM_OSX_X86_64}"
      else
        local readonly PYTHON_SHA512SUM="${PYTHON_SHA512SUM_LINUX_X86_64}"
      fi
    fi

    # Tell `download` to return instead of exit upon an error
    PHOENIX_DOWNLOAD_EXIT=0

    # By default, we know nothing has failed...
    local PHOENIX_DOWNLOAD_FAILED=0
    local PHOENIX_PYENV_FAILED=0
    local PHOENIX_PYTHON_INSTALL_FAILED=0

    echo_red_text 'Downloading Python...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-${PYTHON_ARCH}-${PYTHON_PLATFORM}-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-${PYTHON_ARCH}-${PYTHON_PLATFORM}-install_only_stripped.tar.gz" "${PYTHON_SHA512SUM}" || local PHOENIX_DOWNLOAD_FAILED=1

    # If the download failed, restore our back-ups, clean-up, and exit
    if [[ "${PHOENIX_DOWNLOAD_FAILED}" == 1 ]]; then
      restore_dir "${PHOENIX_PYENV_DIR}"
      restore_dir "${PHOENIX_PYTHON_DIR}"
      restore_dir "${PHOENIX_UV_CACHE}"
      restore_dir "${PHOENIX_UV_PYTHON}"
      restore_dir "${PHOENIX_UV_LOCAL}/python-cache"
      rm -rf "${PHOENIX_EXTERNAL}/temp"
      exit 1
    elif [[ "${PHOENIX_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
      echo_green_text "SUCCESS: Downloaded Python to ${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-${PYTHON_ARCH}-${PYTHON_PLATFORM}-install_only_stripped.tar.gz"

      echo_red_text 'Installing Python...'
      "${PHOENIX_UV}" python install "${PYTHON_VERSION}" || local PHOENIX_PYTHON_INSTALL_FAILED=1

      # If the install failed, restore our back-ups, clean-up, and exit
      if [[ "${PHOENIX_PYTHON_INSTALL_FAILED}" == 1 ]]; then
        restore_dir "${PHOENIX_PYENV_DIR}"
        restore_dir "${PHOENIX_PYTHON_DIR}"
        restore_dir "${PHOENIX_UV_CACHE}"
        restore_dir "${PHOENIX_UV_PYTHON}"
        restore_dir "${PHOENIX_UV_LOCAL}/python-cache"
        rm -rf "${PHOENIX_EXTERNAL}/temp"
        exit 1
      fi

      echo_red_text 'Creating Python environment...'
      "${PHOENIX_UV}" venv "${PHOENIX_PYENV_DIR}" || local PHOENIX_PYENV_FAILED=1

      # If the Python env set-up failed, restore our back-up, clean-up, and exit
      if [[ "${PHOENIX_PYENV_FAILED}" == 1 ]]; then
        echo_red_text 'ERROR: Download failed! Exiting...'
        restore_dir "${PHOENIX_PYENV_DIR}"
        rm -rf "${PHOENIX_EXTERNAL}/temp"
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
  download_and_extract 's3cmd' "https://github.com/s3tools/s3cmd/archive/${S3CMD_COMMIT}.tar.gz" "${PHOENIX_S3CMD_DIR}" "${S3CMD_SHA512SUM}"

  if [[ "${PHOENIX_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
    source "${PHOENIX_PYENV}"
    echo_red_text 'Installing s3cmd...'
    "${PHOENIX_UV}" pip install --no-editable --strict "${PHOENIX_S3CMD_DIR}"
    echo_green_text "SUCCESS: Set-up s3cmd at ${PHOENIX_S3CMD}"
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
    download "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-aarch64-unknown-linux-gnu.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-linux-arm64.tar.gz" "${UV_SHA512SUM_LINUX_ARM64}"

    echo_red_text 'Downloading uv (Linux - x86_64)...'
    download "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-x86_64-unknown-linux-gnu.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-linux-x86_64.tar.gz" "${UV_SHA512SUM_LINUX_X86_64}"

    echo_red_text 'Downloading uv (OS X - ARM64)...'
    download "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-aarch64-apple-darwin.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-osx-arm64.tar.gz" "${UV_SHA512SUM_OSX_ARM64}"

    echo_red_text 'Downloading uv (OS X - x86_64)...'
    download "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-x86_64-apple-darwin.tar.gz" "${PHOENIX_EXTERNAL}/temp/uv-checksum-update-osx-x86_64.tar.gz" "${UV_SHA512SUM_OSX_X86_64}"
  else
    # Set our platform
    if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
      local readonly UV_PLATFORM='apple-darwin'
    else
      local readonly UV_PLATFORM='unknown-linux-gnu'
    fi

    # Set our platform architecture
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      local readonly UV_ARCH='aarch64'
    else
      local readonly UV_ARCH='x86_64'
    fi

    # Set our checksum to verify
    if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
      if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
        local readonly UV_SHA512SUM="${UV_SHA512SUM_OSX_ARM64}"
      else
        local readonly UV_SHA512SUM="${UV_SHA512SUM_LINUX_ARM64}"
      fi
    else
      if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
        local readonly UV_SHA512SUM="${UV_SHA512SUM_OSX_X86_64}"
      else
        local readonly UV_SHA512SUM="${UV_SHA512SUM_LINUX_X86_64}"
      fi
    fi

    # Tell `download` to return instead of exit upon an error
    PHOENIX_DOWNLOAD_EXIT=0

    # By default, we know the download hasn't failed...
    local PHOENIX_DOWNLOAD_FAILED=0

    echo_red_text 'Downloading uv...'
    download_and_extract 'uv' "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-${UV_ARCH}-${UV_PLATFORM}.tar.gz" "${PHOENIX_UV_DIR}" "${UV_SHA512SUM}" || local PHOENIX_DOWNLOAD_FAILED=1

    # If the download failed, restore our back-up, clean-up, and exit
    if [[ "${PHOENIX_DOWNLOAD_FAILED}" == 1 ]]; then
      echo_red_text 'ERROR: Download failed! Exiting...'
      restore_dir "${PHOENIX_UV_DIR}"
      restore_dir "${PHOENIX_UV_LOCAL}"
      rm -rf "${PHOENIX_EXTERNAL}/temp"
      exit 1
    elif [[ "${PHOENIX_PERFORM_POST_DOWNLOAD}" == 1 ]]; then
      echo_green_text "SUCCESS: Set-up uv at ${PHOENIX_UV}"
    fi
  fi
}

# Clean-up
rm -rf "${PHOENIX_EXTERNAL}/downloads"
rm -rf "${PHOENIX_EXTERNAL}/temp"

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
