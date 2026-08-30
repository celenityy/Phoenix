#!/bin/bash

set -euo pipefail

# File utility functions

# Set-up our environment
if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
  /bin/bash $(dirname $0)/env.sh || exit 1
fi
source $(dirname $0)/env.sh || exit 1

# Include utilities
source "${PHOENIX_UTILS}" || exit 1

# Produce a (reproducible) archive from a directory
## For reference/details on this process, see...
## https://codeberg.org/celenity/Phoenix/issues/314
## https://www.gnu.org/software/tar/manual/html_node/Reproducibility.html
## https://wiki.debian.org/ReproducibleBuilds/TimestampsInZip
## https://stackoverflow.com/questions/52668432/tar-package-has-different-checksum-for-exactly-the-same-content
function create_archive() {
  function print_usage() {
    echo 'Usage: create_archive '/path/to/dir' '/path/to/output_archive''
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a directory!'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to the desired output archive!'
    print_usage
    exit 1
  fi

  # Ensure we have dirname
  verify_exec "${PHOENIX_DIRNAME}" 'PHOENIX_DIRNAME' || exit 1

  # Ensure we have dot_clean
  if [[ "${PHOENIX_OS}" == 'osx' ]]; then
    verify_exec "${PHOENIX_DOT_CLEAN}" 'PHOENIX_DOT_CLEAN' || exit 1
  fi

  # Ensure we have find
  verify_exec "${PHOENIX_FIND}" 'PHOENIX_FIND' || exit 1

  # Ensure we have GNU date
  verify_exec "${PHOENIX_DATE}" 'PHOENIX_DATE' || exit 1

  # Ensure we have head
  verify_exec "${PHOENIX_HEAD}" 'PHOENIX_HEAD' || exit 1

  # Ensure we have ls
  verify_exec "${PHOENIX_LS}" 'PHOENIX_LS' || exit 1

  # Ensure we have mkdir
  verify_exec "${PHOENIX_MKDIR}" 'PHOENIX_MKDIR' || exit 1

  # Ensure we have rm
  verify_exec "${PHOENIX_RM}" 'PHOENIX_RM' || exit 1

  # Ensure we have touch
  verify_exec "${PHOENIX_TOUCH}" 'PHOENIX_TOUCH' || exit 1

  # Ensure we have xargs
  verify_exec "${PHOENIX_XARGS}" 'PHOENIX_XARGS' || exit 1

  # Ensure we have `PHOENIX_VERSION_DATE`
  if [[ -z "${PHOENIX_VERSION_DATE+x}" ]] || [[ "${PHOENIX_VERSION_DATE}" == "" ]]; then
    echo_red_text "ERROR: 'PHOENIX_VERSION_DATE' is missing!"
    exit 1
  fi

  local -r target_dir="$1"
  local -r output_archive="$2"

  # Determine the archive format
  case "${output_archive}" in
    *.zip)
      # Ensure we have zip
      verify_exec "${PHOENIX_ZIP}" 'PHOENIX_ZIP' || exit 1

      local -r archive_format='zip'
      ;;
    *.tar.xz)
      # Ensure we have GNU tar
      verify_exec "${PHOENIX_TAR}" 'PHOENIX_TAR' || exit 1

      local -r archive_format='tar'
      ;;
    *)
      echo_red_text "ERROR: Unsupported archive format: '${output_archive}'!"
      exit 1
      ;;
  esac

  if [[ ! -d "${target_dir}" ]]; then
    echo_red_text "ERROR: Target directory ('${target_dir}') does not exist! Aborting..."
    exit 1
  fi

  # Check if the output archive already exists
  if [[ -f "${output_archive}" ]]; then
    echo_red_text "'${output_archive}' already exists"
    echo_red_text 'Continuing WILL override this archive'
    read -p "Are you sure you want to proceed? [y/N] " -n 1 -r
    echo
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      echo_red_text "Removing '${output_archive}'..."
      "${PHOENIX_RM}" -f "${output_archive}"
    else
      exit 1
    fi
  fi

  # Set timezone to UTC for consistency
  unset TZ
  export TZ='UTC'

  # If the directory for our output archive doesn't exist, create it
  local -r output_archive_dir="$("${PHOENIX_DIRNAME}" "${output_archive}")"
  if [[ ! -d "${output_archive_dir}" ]]; then
    "${PHOENIX_MKDIR}" -p "${output_archive_dir}"
  fi

  # If we're on OS X, clean the target directory
  if [[ "${PHOENIX_OS}" == 'osx' ]]; then
    "${PHOENIX_DOT_CLEAN}" -mv "${target_dir}"
  fi

  # Set the file timestamp
  ## (This is derived from PHOENIX_VERSION_DATE at `versions.sh`)
  local -r PHOENIX_STAMP="${PHOENIX_VERSION_DATE//./-}"
  local -r PHOENIX_FIND_STAMP="$("${PHOENIX_DATE}" -d "${PHOENIX_STAMP}" +"%a, %d %b %Y %T %z")"
  local -r PHOENIX_TIMESTAMP="$("${PHOENIX_DATE}" -d "${PHOENIX_STAMP}" +"%Y-%m-%dT%H:%M:%SZ")"

  # Override the timestamps for each file to match our stamp above
  "${PHOENIX_FIND}" "${target_dir}" -newermt "${PHOENIX_FIND_STAMP}" -print0 |
    "${PHOENIX_XARGS}" -0r "${PHOENIX_TOUCH}" -h -d "${PHOENIX_TIMESTAMP}"

  # Override the timestamps for each directory to match our stamp above
  for dir in $("${PHOENIX_FIND}" "${target_dir}" -type d); do
    "${PHOENIX_TOUCH}" -r "${dir}/$("${PHOENIX_LS}" -At "${dir}" | "${PHOENIX_HEAD}" -n 1)" "${dir}"
  done

  # By default, we know the archive creation has not failed...
  local archive_failed=0

  # Finally create our archive
  echo_red_text "Creating archive: ${output_archive} from path: ${target_dir}..."
  pushd "${target_dir}"
  if [[ "${archive_format}" == 'zip' ]]; then
    # shellcheck disable=SC2035
    "${PHOENIX_ZIP}" -X -r "${output_archive}" * -x '.DS_Store' || local archive_failed=1
  elif [[ "${archive_format}" == 'tar' ]]; then
    # shellcheck disable=SC2035
    "${PHOENIX_TAR}" -cJv --exclude-vcs --group=0 --mode='go+u,go-w' --no-acls --no-selinux --no-xattrs --numeric-owner --owner=0 --pax-option='delete=atime,delete=ctime' --pax-option='exthdr.name=%d/PaxHeaders/%f' --restrict --sort=name --utc --clamp-mtime --mtime="${PHOENIX_TIMESTAMP}" --exclude ".DS_Store" -f "${output_archive}" * || local archive_failed=1
  else
    echo_red_text "ERROR: Invalid archive format: '${archive_format}'!"
    exit 1
  fi
  popd

  # Ensure the archive we just created is valid
  if [[ "${archive_failed}" != 1 ]]; then
    verify_file "${output_archive}" || local archive_failed=1
  fi

  # If the archive creation failed, return
  if [[ "${archive_failed}" == 1 ]]; then
    echo_red_text "ERROR: Unable to create archive: '${output_archive}' from path: '${target_dir}'!"
    return 1
  else
    echo_green_text "SUCCESS: Created archive: '${output_archive}' from path: '${target_dir}'!"
  fi
}

# Extract an archive
function extract_archive() {
  function print_usage() {
    echo "Usage: extract_archive 'path/to/archive' 'path/to/extract/archive/to'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please provide the path to an archive to extract!'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please provide the path that the archive should be extracted to!'
    print_usage
    exit 1
  fi

  # Ensure we have basename
  verify_exec "${PHOENIX_BASENAME}" 'PHOENIX_BASENAME' || exit 1

  # Ensure we have cp
  verify_exec "${PHOENIX_CP}" 'PHOENIX_CP' || exit 1

  # Ensure we have ls
  verify_exec "${PHOENIX_LS}" 'PHOENIX_LS' || exit 1

  # Ensure we have mkdir
  verify_exec "${PHOENIX_MKDIR}" 'PHOENIX_MKDIR' || exit 1

  # Ensure we have rm
  verify_exec "${PHOENIX_RM}" 'PHOENIX_RM' || exit 1

  local -r archive_path="$1"
  local -r target_path="$2"

  if [[ ! -f "${archive_path}" ]]; then
    echo_red_text "ERROR: Archive does not exist: '${archive_path}'!"
    exit 1
  fi

  # Set a temporary archive name
  local -r temp_archive_path_name=$("${PHOENIX_BASENAME}" "${target_path}")
  local -r temp_archive_path="${PHOENIX_EXTERNAL}/temp/${temp_archive_path}"

  # If our temporary directory for extraction already exists, delete it
  if [[ -d "${temp_archive_path}" ]]; then
    "${PHOENIX_RM}" -rf "${temp_archive_path}"
  fi

  # Extract based on file extension
  case "${archive_path}" in
    *.zip)
      local -r archive_format='zip'
      ;;
    *.tar.gz)
      local -r archive_format='tar.gz'
      ;;
    *.tar.xz)
      local -r archive_format='tar.xz'
      ;;
    *.tar.zst)
      local -r archive_format='tar.zst'
      ;;
    *)
      echo_red_text "ERROR: Unsupported archive format: '${archive_path}'!"
      exit 1
      ;;
  esac

  if [[ "${archive_format}" == 'zip' ]]; then
    # Ensure we have unzip
    verify_exec "${PHOENIX_UNZIP}" 'PHOENIX_UNZIP' || exit 1
  else
    # Ensure we have GNU tar
    verify_exec "${PHOENIX_TAR}" 'PHOENIX_TAR' || exit 1
  fi

  # Create temporary directory for extraction
  "${PHOENIX_MKDIR}" -p "${temp_archive_path}"

  # By default, we know the extraction has not failed...
  local extraction_failed=0

  # Extract our archive
  echo_red_text "Extracting archive: '${archive_path}' to path: '${target_path}'..."
  if [[ "${archive_format}" == 'zip' ]]; then
    "${PHOENIX_UNZIP}" -q "${archive_path}" -d "${temp_archive_path}" || local extraction_failed=1
  elif [[ "${archive_format}" == 'tar.gz' ]]; then
    "${PHOENIX_TAR}" xzf "${archive_path}" -C "${temp_archive_path}" || local extraction_failed=1
  elif [[ "${archive_format}" == 'tar.xz' ]]; then
    "${PHOENIX_TAR}" xJf "${archive_path}" -C "${temp_archive_path}" || local extraction_failed=1
  elif [[ "${archive_format}" == 'tar.zst' ]]; then
    "${PHOENIX_TAR}" --zstd -xvf "${archive_path}" -C "${temp_archive_path}" || local extraction_failed=1
  else
    echo_red_text "ERROR: Invalid archive format: '${archive_format}'!"
    exit 1
  fi

  local -r top_input_dir=$("${PHOENIX_LS}" "${temp_archive_path}")
  "${PHOENIX_CP}" -rf "${temp_archive_path}/${top_input_dir}/" "${target_path}" || local extraction_failed=1

  # Ensure the directory we just extracted the archive to is valid
  if [[ "${extraction_failed}" != 1 ]] && [[ ! -d "${target_path}" ]]; then
    local extraction_failed=1
  fi

  # Clean-up
  "${PHOENIX_RM}" -rf "${temp_archive_path}"

  # If the extraction failed, return
  if [[ "${extraction_failed}" == 1 ]]; then
    echo_red_text "ERROR: Unable to extract archive: '${archive_path}' to path: '${target_path}'!"
    return 1
  else
    echo_green_text "SUCCESS: Extracted archive: '${archive_path}' to path: '${target_path}'!"
  fi
}
