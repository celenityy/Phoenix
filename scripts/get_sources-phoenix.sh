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

if [ "${target}" == 'python' ]; then
  # Get Python
  PHOENIX_GET_SOURCE_PYTHON=1
elif [ "${target}" == 's3cmd' ]; then
  # Get s3cmd
  PHOENIX_GET_SOURCE_S3CMD=1
elif [ "${target}" == 'uv' ]; then
  # Get + set-up uv
  PHOENIX_GET_SOURCE_UV=1
elif [ "${target}" == 'all' ]; then
  # If no argument is specified (or argument is set to "all"), just get everything, except S3
  ## (We don't need to bother getting S3 here since it's only used in certain scenarios)
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
if [ "${mode}" == 'checksum-update' ]; then
  PHOENIX_GET_SOURCE_CHECKSUM_UPDATE=1
elif [ "${mode}" != 'download' ]; then
  echo_red_text "ERROR: Invalid mode: ${mode}\n You must enter one of the following:"
  echo 'Download:                     download (Default)'
  echo 'Download + update checksums:  checksum-update'
  exit 1
fi
readonly PHOENIX_GET_SOURCE_CHECKSUM_UPDATE

# Include version info
source "${PHOENIX_VERSIONS}"

# Function to automate updating SHA512sums of dependencies
function update_sha512sum() {
  local readonly old_sha512sum="$1"
  local readonly new_sha512sum="$2"
  local readonly file="$3"

  if [ "${old_sha512sum}" == "${PYTHON_SHA512SUM_LINUX_ARM64}" ]; then
    echo_red_text 'Updating SHA512sum for Python (Linux - ARM64)...'
    "${PHOENIX_SED}" -i -e "s|PYTHON_SHA512SUM_LINUX_ARM64='.*'|PYTHON_SHA512SUM_LINUX_ARM64='"${new_sha512sum}"'|g" "${PHOENIX_VERSIONS}"
    echo_green_text 'SUCCESS: Updated SHA512sum for Python (Linux - ARM64)'
  elif [ "${old_sha512sum}" == "${PYTHON_SHA512SUM_LINUX_X86_64}" ]; then
    echo_red_text 'Updating SHA512sum for Python (Linux - x86_64)...'
    "${PHOENIX_SED}" -i -e "s|PYTHON_SHA512SUM_LINUX_X86_64='.*'|PYTHON_SHA512SUM_LINUX_X86_64='"${new_sha512sum}"'|g" "${PHOENIX_VERSIONS}"
    echo_green_text 'SUCCESS: Updated SHA512sum for Python (Linux - x86_64)'
  elif [ "${old_sha512sum}" == "${PYTHON_SHA512SUM_OSX_ARM64}" ]; then
    echo_red_text 'Updating SHA512sum for Python (OS X - ARM64)...'
    "${PHOENIX_SED}" -i -e "s|PYTHON_SHA512SUM_OSX_ARM64='.*'|PYTHON_SHA512SUM_OSX_ARM64='"${new_sha512sum}"'|g" "${PHOENIX_VERSIONS}"
    echo_green_text 'SUCCESS: Updated SHA512sum for Python (OS X - ARM64)'
  elif [ "${old_sha512sum}" == "${PYTHON_SHA512SUM_OSX_X86_64}" ]; then
    echo_red_text 'Updating SHA512sum for Python (OS X - x86_64)...'
    "${PHOENIX_SED}" -i -e "s|PYTHON_SHA512SUM_OSX_X86_64='.*'|PYTHON_SHA512SUM_OSX_X86_64='"${new_sha512sum}"'|g" "${PHOENIX_VERSIONS}"
    echo_green_text 'SUCCESS: Updated SHA512sum for Python (OS X - x86_64)'
  elif [ "${old_sha512sum}" == "${UV_SHA512SUM_LINUX_ARM64}" ]; then
    echo_red_text 'Updating SHA512sum for uv (Linux - ARM64)...'
    "${PHOENIX_SED}" -i -e "s|UV_SHA512SUM_LINUX_ARM64='.*'|UV_SHA512SUM_LINUX_ARM64='"${new_sha512sum}"'|g" "${PHOENIX_VERSIONS}"
    echo_green_text 'SUCCESS: Updated SHA512sum for uv (Linux - ARM64)'
  elif [ "${old_sha512sum}" == "${UV_SHA512SUM_LINUX_X86_64}" ]; then
    echo_red_text 'Updating SHA512sum for uv (Linux - x86_64)...'
    "${PHOENIX_SED}" -i -e "s|UV_SHA512SUM_LINUX_X86_64='.*'|UV_SHA512SUM_LINUX_X86_64='"${new_sha512sum}"'|g" "${PHOENIX_VERSIONS}"
    echo_green_text 'SUCCESS: Updated SHA512sum for uv (Linux - x86_64)'
  elif [ "${old_sha512sum}" == "${UV_SHA512SUM_OSX_ARM64}" ]; then
    echo_red_text 'Updating SHA512sum for uv (OS X - ARM64)...'
    "${PHOENIX_SED}" -i -e "s|UV_SHA512SUM_OSX_ARM64='.*'|UV_SHA512SUM_OSX_ARM64='"${new_sha512sum}"'|g" "${PHOENIX_VERSIONS}"
    echo_green_text 'SUCCESS: Updated SHA512sum for uv (OS X - ARM64)'
  elif [ "${old_sha512sum}" == "${UV_SHA512SUM_OSX_X86_64}" ]; then
    echo_red_text 'Updating SHA512sum for uv (OS X - x86_64)...'
    "${PHOENIX_SED}" -i -e "s|UV_SHA512SUM_OSX_X86_64='.*'|UV_SHA512SUM_OSX_X86_64='"${new_sha512sum}"'|g" "${PHOENIX_VERSIONS}"
    echo_green_text 'SUCCESS: Updated SHA512sum for uv (OS X - x86_64)'
  fi

  rm "${file}"
}

function validate_sha512sum() {
  local readonly expected_sha512sum="$1"
  local readonly file="$2"

  local readonly local_sha512sum=$(sha512sum "${file}" | "${PHOENIX_AWK}" '{print $1}')

  if [ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]; then
    update_sha512sum "${expected_sha512sum}" "${local_sha512sum}" "${file}"
  elif [ "${local_sha512sum}" != "${expected_sha512sum}" ]; then
    echo_red_text 'ERROR: Checksum validation failed.'
    echo "Expected SHA512sum:   ${expected_sha512sum}"
    echo "Actual SHA512sum:     ${local_sha512sum}"

    # If checksum validation fails, also just remove the file
    rm -f "${file}"

    exit 1
  else
    echo_green_text 'SUCCESS: Checksum validated.'
    echo "SHA512sum: ${local_sha512sum}"
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
  local readonly filepath="$2"

  if [[ "${url}" == "" ]]; then
    echo_red_text "ERROR: URL is required (file: '${filepath}')"
    exit 1
  fi

  if [ -f "${filepath}" ]; then
    echo_red_text "${filepath} already exists."
    read -p "Do you want to re-download? [y/N] " -n 1 -r
    echo
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      echo_red_text "Removing ${filepath}..."
      rm -f "${filepath}"
    else
      return 0
    fi
  fi

  mkdir -vp "$(dirname "${filepath}")"

  echo_red_text "Downloading ${url}..."
  curl ${PHOENIX_CURL_FLAGS} -sSL "${url}" -o "${filepath}"
}

# Extract archives
function extract() {
  local readonly archive_path="$1"
  local readonly target_path="$2"
  local readonly temp_repo_name="$3"

  if ! [[ -f "${archive_path}" ]]; then
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
  cp -rf "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}/${top_input_dir}"/ "${target_path}"
  rm -rf "${PHOENIX_EXTERNAL}/temp/${temp_repo_name}"
}

function download_and_extract() {
  local readonly repo_name="$1"
  local readonly url="$2"
  local readonly path="$3"
  local readonly expected_sha512sum="$4"

  if [[ -d "${path}" ]]; then
    echo_red_text "'${path}' already exists"
    read -p "Do you want to re-download? [y/N] " -n 1 -r
    echo
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      echo_red_text "Removing ${path}..."
      rm -rf "${path}"
    else
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

  local readonly repo_archive="${PHOENIX_DOWNLOADS}/${repo_name}${extension}"

  download "${url}" "${repo_archive}"

  if [ ! -f "${repo_archive}" ]; then
    echo_red_text "ERROR: Source archive for ${repo_name} does not exist."
    exit 1
  fi

  # Before extracting, verify SHA512sum...
  validate_sha512sum "${expected_sha512sum}" "${repo_archive}"

  if [ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]; then
    echo_red_text "Extracting ${repo_archive}..."
    extract "${repo_archive}" "${path}" "${repo_name}"
    echo
  fi
}

# Get Python
function get_python() {
  # Set our platform
  if [ "${PHOENIX_PLATFORM}" == 'darwin' ]; then
    local readonly PYTHON_PLATFORM='apple-darwin'
  else
    local readonly PYTHON_PLATFORM='unknown-linux-gnu'
  fi

  # Set our platform architecture
  if [ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]; then
    local readonly PYTHON_ARCH='aarch64'
  else
    local readonly PYTHON_ARCH='x86_64'
  fi

  # Set our checksum to verify
  if [ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]; then
    if [ "${PHOENIX_PLATFORM}" == 'darwin' ]; then
      local readonly PYTHON_SHA512SUM="${PYTHON_SHA512SUM_OSX_ARM64}"
    else
      local readonly PYTHON_SHA512SUM="${PYTHON_SHA512SUM_LINUX_ARM64}"
    fi
  else
    if [ "${PHOENIX_PLATFORM}" == 'darwin' ]; then
      local readonly PYTHON_SHA512SUM="${PYTHON_SHA512SUM_OSX_X86_64}"
    else
      local readonly PYTHON_SHA512SUM="${PYTHON_SHA512SUM_LINUX_X86_64}"
    fi
  fi

  if [ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]; then
    echo_red_text 'Downloading Python (Linux - ARM64)...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-unknown-linux-gnu-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-unknown-linux-gnu-install_only_stripped.tar.gz"

    # "Validate" (Update) SHA512sum
    validate_sha512sum "${PYTHON_SHA512SUM_LINUX_ARM64}" "${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-unknown-linux-gnu-install_only_stripped.tar.gz"

    echo_red_text 'Downloading Python (Linux - x86_64)...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz"

    # "Validate" (Update) SHA512sum
    validate_sha512sum "${PYTHON_SHA512SUM_LINUX_X86_64}" "${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-unknown-linux-gnu-install_only_stripped.tar.gz"

    echo_red_text 'Downloading Python (OS X - ARM64)...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-apple-darwin-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-apple-darwin-install_only_stripped.tar.gz"

    # "Validate" (Update) SHA512sum
    validate_sha512sum "${PYTHON_SHA512SUM_OSX_ARM64}" "${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-aarch64-apple-darwin-install_only_stripped.tar.gz"

    echo_red_text 'Downloading Python (OS X - x86_64)...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-apple-darwin-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-apple-darwin-install_only_stripped.tar.gz"

    # "Validate" (Update) SHA512sum
    validate_sha512sum "${PYTHON_SHA512SUM_OSX_X86_64}" "${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-x86_64-apple-darwin-install_only_stripped.tar.gz"
  else
    echo_red_text 'Downloading Python...'
    download "https://github.com/astral-sh/python-build-standalone/releases/download/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-${PYTHON_ARCH}-${PYTHON_PLATFORM}-install_only_stripped.tar.gz" "${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-${PYTHON_ARCH}-${PYTHON_PLATFORM}-install_only_stripped.tar.gz"

    # Validate SHA512sum
    validate_sha512sum "${PYTHON_SHA512SUM}" "${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-${PYTHON_ARCH}-${PYTHON_PLATFORM}-install_only_stripped.tar.gz"

    echo_green_text "SUCCESS: Downloaded Python to ${PHOENIX_PYTHON_DIR}/${PYTHON_GIT_RELEASE}/cpython-${PYTHON_VERSION}+${PYTHON_GIT_RELEASE}-${PYTHON_ARCH}-${PYTHON_PLATFORM}-install_only_stripped.tar.gz"
  fi
}

# Get s3cmd
function get_s3cmd() {
    # If all we're doing is updating the checksum, we don't care if the environment is prepared
    if [ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]; then
        if  [ ! -d "${PHOENIX_UV_DIR}" ] || [ ! -f "${PHOENIX_PYENV}" ]; then
            echo_red_text "ERROR: You tried to download s3cmd, but you don't have a uv environment set-up yet."
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

    if [ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]; then
        source "${PHOENIX_PYENV}"
        echo_red_text 'Installing s3cmd...'
        "${PHOENIX_UV}" pip install --no-editable --strict "${PHOENIX_S3CMD_DIR}"
        echo_green_text "SUCCESS: Set-up s3cmd at ${PHOENIX_S3CMD}"
    fi
}

# Get + set-up uv
function get_uv() {
  # If all we're doing is updating the checksum, we don't care if the environment is prepared
  if [ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" != 1 ]; then
    if [ ! -d "${PHOENIX_PYTHON_DIR}" ]; then
      echo_red_text "ERROR: You tried to download uv, but you don't have Python downloaded yet."
      exit 1
    fi

    if [[ -d "${PHOENIX_PYENV_DIR}" ]]; then
      echo_red_text "The uv environment is already set-up at ${PHOENIX_PYENV_DIR}"
      read -p "Do you want to re-create it? [y/N] " -n 1 -r
      echo
      if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
        rm -rf "${PHOENIX_PYENV_DIR}" "${PHOENIX_UV_DIR}" "${PHOENIX_UV_LOCAL}"
      fi
    fi
  fi

  # Set our platform
  if [ "${PHOENIX_PLATFORM}" == 'darwin' ]; then
    local readonly UV_PLATFORM='apple-darwin'
  else
    local readonly UV_PLATFORM='unknown-linux-gnu'
  fi

  # Set our platform architecture
  if [ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]; then
    local readonly UV_ARCH='aarch64'
  else
    local readonly UV_ARCH='x86_64'
  fi

  # Set our checksum to verify
  if [ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]; then
    if [ "${PHOENIX_PLATFORM}" == 'darwin' ]; then
      local readonly UV_SHA512SUM="${UV_SHA512SUM_OSX_ARM64}"
    else
      local readonly UV_SHA512SUM="${UV_SHA512SUM_LINUX_ARM64}"
    fi
  else
    if [ "${PHOENIX_PLATFORM}" == 'darwin' ]; then
      local readonly UV_SHA512SUM="${UV_SHA512SUM_OSX_X86_64}"
    else
      local readonly UV_SHA512SUM="${UV_SHA512SUM_LINUX_X86_64}"
    fi
  fi

  if [ "${PHOENIX_GET_SOURCE_CHECKSUM_UPDATE}" == 1 ]; then
    echo_red_text 'Downloading uv (Linux - ARM64)...'
    download_and_extract 'uv' "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-aarch64-unknown-linux-gnu.tar.gz" "${PHOENIX_UV_DIR}" "${UV_SHA512SUM_LINUX_ARM64}"

    echo_red_text 'Downloading uv (Linux - x86_64)...'
    download_and_extract 'uv' "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-x86_64-unknown-linux-gnu.tar.gz" "${PHOENIX_UV_DIR}" "${UV_SHA512SUM_LINUX_X86_64}"

    echo_red_text 'Downloading uv (OS X - ARM64)...'
    download_and_extract 'uv' "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-aarch64-apple-darwin.tar.gz" "${PHOENIX_UV_DIR}" "${UV_SHA512SUM_OSX_ARM64}"

    echo_red_text 'Downloading uv (OS X - x86_64)...'
    download_and_extract 'uv' "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-x86_64-apple-darwin.tar.gz" "${PHOENIX_UV_DIR}" "${UV_SHA512SUM_OSX_X86_64}"
  else
    echo_red_text 'Downloading uv...'
    download_and_extract 'uv' "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-${UV_ARCH}-${UV_PLATFORM}.tar.gz" "${PHOENIX_UV_DIR}" "${UV_SHA512SUM}"

    echo_red_text 'Installing Python...'
    "${PHOENIX_UV}" python install "${PYTHON_VERSION}"

    echo_red_text 'Creating uv environment...'
    "${PHOENIX_UV}" venv "${PHOENIX_PYENV_DIR}"
    echo_green_text "SUCCESS: Set-up uv environment at ${PHOENIX_PYENV_DIR}"
  fi
}

# These need to run before we get s3cmd
if [ "${PHOENIX_GET_SOURCE_PYTHON}" == 1 ]; then
  get_python
fi

if [ "${PHOENIX_GET_SOURCE_UV}" == 1 ]; then
  get_uv
fi

if [ "${PHOENIX_GET_SOURCE_S3CMD}" == 1 ]; then
  get_s3cmd
fi
