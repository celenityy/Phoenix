#!/bin/bash

set -euo pipefail

# Welcome to the Phoenix Unified build script!
# This script should be ran from inside the directory where you store Phoenix, not directly from the 'archives' or `build` folder...

# Set-up our environment
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

if [[ -z "${PHOENIX_FROM_BUILD+x}" ]]; then
  echo_red_text 'ERROR: Do not call fly.sh directly. Instead, use build.sh.' >&1
  exit 1
fi

# Set-up Python venv
if [[ "${PHOENIX_NIX}" != 1 ]]; then
  source "${PHOENIX_PYENV}"
fi

# Include version info
source "${PHOENIX_VERSIONS}"

# Check if a file or directory already exists
## If the file or directory already exists, prompt the user to remove it
## If the user chooses not to remove it, we exit
## If the file or directory doesn't already exist, we just do nothing
function check_file_or_dir_exists() {
  function print_usage() {
    echo 'Usage: check_file_or_dir_exists /path/to/file_or_dir'
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file or directory to check'
    print_usage
    exit 1
  fi

  local readonly path="$1"

  if [[ -d "${path}" ]] || [[ -f "${path}" ]]; then
    echo_red_text "'${path}' already exists"
    echo_red_text 'Continuing WILL remove this file/directory'
    read -p "Are you sure you want to proceed? [y/N] " -n 1 -r
    echo
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      echo_red_text "Removing ${path}..."
      if [[ -d "${path}" ]]; then
        rm -rf "${path}"
      elif [[ -f "${path}" ]]; then
        rm -f "${path}"
      fi
    else
      exit 1
    fi
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

# Verify that extra policies files are set correctly
function check_extra_policies() {
  # All platforms
  maybe_verify_file "${PHOENIX_EXTRA_POLICIES}" 'PHOENIX_EXTRA_POLICIES'

  # Linux (Generic) - Policies
  if [[ "${PHOENIX_LINUX}" == 1 ]] || [[ "${PHOENIX_LINUX_FLATPAK}" == 1 ]]; then
    maybe_verify_file "${PHOENIX_EXTRA_POLICIES_LINUX}" 'PHOENIX_EXTRA_POLICIES_LINUX'
  fi

  # OS X (Generic) - Policies
  if [[ "${PHOENIX_OSX}" == 1 ]] || [[ "${PHOENIX_OSX_INTEL}" == 1 ]]; then
    maybe_verify_file "${PHOENIX_EXTRA_POLICIES_OSX}" 'PHOENIX_EXTRA_POLICIES_OSX'
  fi

  # Android - Policies
  if [[ "${PHOENIX_ANDROID}" == 1 ]] && [[ "${PHOENIX_ANDROID_POLICIES}" == 1 ]]; then
    maybe_verify_file "${PHOENIX_EXTRA_POLICIES_ANDROID}" 'PHOENIX_EXTRA_POLICIES_ANDROID'
  fi

  # Linux (non-Flatpak) - Policies
  if [[ "${PHOENIX_LINUX}" == 1 ]]; then
    maybe_verify_file "${PHOENIX_EXTRA_POLICIES_LINUX_NONFLATPAK}" 'PHOENIX_EXTRA_POLICIES_LINUX_NONFLATPAK'
  fi

  # Linux (Flatpak) - Policies
  if [[ "${PHOENIX_LINUX_FLATPAK}" == 1 ]]; then
    maybe_verify_file "${PHOENIX_EXTRA_POLICIES_LINUX_FLATPAK}" 'PHOENIX_EXTRA_POLICIES_LINUX_FLATPAK'
  fi

  # OS X (Silicon) - Policies
  if [[ "${PHOENIX_OSX}" == 1 ]]; then
    maybe_verify_file "${PHOENIX_EXTRA_POLICIES_OSX_SILICON}" 'PHOENIX_EXTRA_POLICIES_OSX_SILICON'
  fi

  # OS X (Intel) - Policies
  if [[ "${PHOENIX_OSX_INTEL}" == 1 ]]; then
    maybe_verify_file "${PHOENIX_EXTRA_POLICIES_OSX_INTEL}" 'PHOENIX_EXTRA_POLICIES_OSX_INTEL'
  fi

  # Windows - Policies
  if [[ "${PHOENIX_WINDOWS}" == 1 ]]; then
    maybe_verify_file "${PHOENIX_EXTRA_POLICIES_WINDOWS}" 'PHOENIX_EXTRA_POLICIES_WINDOWS'
  fi
}

# If we're adding extra policies or static pref files, ensure the variables are set correctly
function check_extra_files() {
  # Check for a file to override Phoenix-specific preferences
  maybe_verify_file "${PHOENIX_OVERRIDES_CFG}" 'PHOENIX_OVERRIDES_CFG'

  # Check for a file to append and override/set additional preferences
  maybe_verify_file "${PHOENIX_EXTRA_CFG}" 'PHOENIX_EXTRA_CFG'

  # Check policies
  if [[ "${PHOENIX_ANDROID_ONLY}" != 1 ]] || [[ "${PHOENIX_ANDROID_POLICIES}" == 1 ]]; then
    check_extra_policies
  fi

  # Check for a static prefs file to append and override/set additional preferences
  if [[ "${PHOENIX_ANDROID_ONLY}" == 1 ]]; then
    if [[ "${PHOENIX_STATIC_JS_ANDROID}" != 1 ]]; then
      local readonly check_static_prefs_js=0
    else
      local readonly check_static_prefs_js=1
    fi
  elif [[ "${PHOENIX_STATIC_JS}" == 1 ]]; then
    local readonly check_static_prefs_js=1
  else
    local readonly check_static_prefs_js=0
  fi

  if [[ "${check_static_prefs_js}" == 1 ]]; then
    maybe_verify_file "${PHOENIX_EXTRA_JS}" 'PHOENIX_EXTRA_JS'
  fi
}

# Function for combining two or more files
function combine_files() {
  function print_usage() {
    echo "Usage: combine_files /path/to/output_file /path/to/input_file_1 /path/to/input_file_2 ..."
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify a path for the output file'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the paths for each input file you would like to combine'
    print_usage
    exit 1
  fi

  local readonly output_file="$1"
  local readonly initial_input_file="$2"

  if [[ -z "${3+x}" ]]; then
    echo_red_text "ERROR: You must specify the paths for at least two or more input files to combine"
    print_usage
    exit 1
  fi

  local files_to_combine=()
  local number_of_files=0

  # First, ensure our initial input file exists
  if [[ ! -f "${initial_input_file}" ]]; then
    echo_red_text "ERROR: ${initial_input_file} does not exist!"
    exit 1
  else
    files_to_combine+=("${initial_input_file}")
    number_of_files=$((${number_of_files} + 1))
  fi

  # Determine our initial input file type
  case "${initial_input_file}" in
  *.cfg)
    local readonly initial_input_file_type='cfg'
    ;;
  *.js)
    local readonly initial_input_file_type='js'
    ;;
  *.json)
    local readonly initial_input_file_type='json'
    ;;
  *.txt)
    local readonly initial_input_file_type='txt'
    ;;
  *)
    echo_red_text "ERROR: Unsupported file type: ${initial_input_file}"
    exit 1
    ;;
  esac

  # Now, handle additional specified files
  for file in "$@"; do
    if [[ "${file}" != "${output_file}" ]] && [[ "${file}" != "${initial_input_file}" ]]; then
      # First, ensure each file exists
      if [[ ! -f "${file}" ]]; then
        echo_red_text "ERROR: ${file} does not exist!"
        exit 1
      fi

      # Determine the file type
      case "${file}" in
      *.cfg)
        local file_type='cfg'
        ;;
      *.js)
        local file_type='js'
        ;;
      *.json)
        local file_type='json'
        ;;
      *.txt)
        local file_type='txt'
        ;;
      *)
        echo_red_text "ERROR: Unsupported file type: ${file}"
        exit 1
        ;;
      esac

      # To combine files, we must ensure the file types match
      if [[ "${file_type}" != "${initial_input_file_type}" ]]; then
        echo_red_text "ERROR: File type does not match: ${file}"
        exit 1
      else
        files_to_combine+=("${file}")
        number_of_files=$((${number_of_files} + 1))
      fi
    fi
  done

  # Combine our files based on file type
  ## (It's fine to use initial_file here because we verified it matches the files to combine above)
  if [[ "${initial_input_file_type}" == 'json' ]]; then
    # First, always combine the first two files
    jq -s '.[0] * .[1]' "${files_to_combine[0]}" "${files_to_combine[1]}" >"${PHOENIX_TEMP}/tempy--1.json"

    if [[ "${number_of_files}" == 2 ]]; then
      # We're done :)
      cp -f "${PHOENIX_TEMP}/tempy--1.json" "${output_file}"
      rm -f "${PHOENIX_TEMP}/tempy--1.json"
    else
      # We now need to iterate through and combine additional files...
      local files_combined=2
      local file_index=2
      local file_temp_count=0
      until [[ "${files_combined}" == "${number_of_files}" ]]; do
        local old_file_temp_count=$((${file_temp_count} - 1))
        local file_to_combine_with="${files_to_combine[$file_index]}"
        jq -s '.[0] * .[1]' "${PHOENIX_TEMP}/tempy-${old_file_temp_count}.json" "${file_to_combine_with}" >"${PHOENIX_TEMP}/tempy-${file_temp_count}.json"
        rm -f "${PHOENIX_TEMP}/tempy-${old_file_temp_count}.json"
        file_temp_count=$((${file_temp_count} + 1))
        files_combined=$((${files_combined} + 1))
        file_index=$((${file_index} + 1))
      done
      file_temp_count=$((${file_temp_count} - 1))
      cp -f "${PHOENIX_TEMP}/tempy-${file_temp_count}.json" "${output_file}"
      rm -f "${PHOENIX_TEMP}/tempy-${file_temp_count}.json"
    fi
  else
    cat "${files_to_combine[@]}" >"${output_file}"
  fi
}

# Function that only combines two files if the file to add actually exists
## If the file to add does not exist, the initial file is simply copied
function maybe_combine_files() {
  function print_usage() {
    echo "Usage: maybe_combine_files /path/to/output_file /path/to/input_file_1 /path/to/input_file_2"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify a path for the output file'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path for the input file you would like to combine with an additional file'
    print_usage
    exit 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path for the second input file you would like to combine with the first input file (if this file exists)'
    print_usage
    exit 1
  fi

  local readonly output_file="$1"
  local readonly initial_file="$2"
  local readonly file_to_add="$3"

  if [[ -f "${file_to_add}" ]]; then
    combine_files "${output_file}" "${initial_file}" "${file_to_add}"
  else
    cp -f "${initial_file}" "${output_file}"
  fi
}

# Parse a static prefs .js file
function parse_js_file() {
  function print_usage() {
    echo "Usage: parse_js_file /path/to/input_js_file /path/to/output_js_file 'TAG_TO_REMOVE'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path for the input prefs .js file you would like to parse'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify a path for the output (parsed) prefs .js file'
    print_usage
    exit 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text 'ERROR: Please specify a tag that should be removed from the input prefs .js file'
    print_usage
    exit 1
  fi

  local readonly input_js_file="$1"
  local readonly output_js_file="$2"
  local readonly tags_to_remove="$3"

  if [[ ! -f "${input_js_file}" ]]; then
    echo_red_text "ERROR: File does not exist: ${input_js_file}"
    exit 1
  fi

  grep -vE "${tags_to_remove}" "${input_js_file}" >"${output_js_file}"
}

# Common Phoenix build logic
function build_phoenix_common() {
  cp "${PHOENIX_ROOT}/phoenix-core.cfg" "${PHOENIX_TEMP}/phoenix-core.cfg"
  cp "${PHOENIX_ROOT}/phoenix-unified.cfg" "${PHOENIX_TEMP}/phoenix-unified.cfg"

  # Set PHOENIX_APPLY_EXTENDED
  if [[ "${PHOENIX_EXTENDED}" == 1 ]] || [[ "${PHOENIX_MAIL}" == 1 ]]; then
    "${PHOENIX_SED}" -i "s|{PHOENIX_APPLY_EXTENDED}|true|" "${PHOENIX_TEMP}/phoenix-core.cfg"
  else
    "${PHOENIX_SED}" -i "s|{PHOENIX_APPLY_EXTENDED}|false|" "${PHOENIX_TEMP}/phoenix-core.cfg"
  fi

  # Set PHOENIX_FORCE_RESET_REMOTE_DEBUGGING
  if [[ "${PHOENIX_FORCE_RESET_REMOTE_DEBUGGING}" == 1 ]]; then
    "${PHOENIX_SED}" -i "s|{PHOENIX_FORCE_RESET_REMOTE_DEBUGGING}|true|" "${PHOENIX_TEMP}/phoenix-core.cfg"
  else
    "${PHOENIX_SED}" -i "s|{PHOENIX_FORCE_RESET_REMOTE_DEBUGGING}|false|" "${PHOENIX_TEMP}/phoenix-core.cfg"
  fi

  # Set PHOENIX_MAIL
  if [[ "${PHOENIX_MAIL}" == 1 ]]; then
    "${PHOENIX_SED}" -i "s|{PHOENIX_MAIL}|true|" "${PHOENIX_TEMP}/phoenix-core.cfg"
  else
    "${PHOENIX_SED}" -i "s|{PHOENIX_MAIL}|false|" "${PHOENIX_TEMP}/phoenix-core.cfg"
  fi

  # Set PHOENIX_NO_SPEC
  if [[ "${PHOENIX_NO_SPEC}" == 1 ]]; then
    "${PHOENIX_SED}" -i "s|{PHOENIX_NO_SPEC}|true|" "${PHOENIX_TEMP}/phoenix-core.cfg"
  else
    "${PHOENIX_SED}" -i "s|{PHOENIX_NO_SPEC}|false|" "${PHOENIX_TEMP}/phoenix-core.cfg"
  fi

  # Update the version
  "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|" "${PHOENIX_TEMP}/phoenix-unified.cfg"

  # If necessary, apply overrides for Phoenix-specific preferences
  if [[ "${PHOENIX_OVERRIDES_CFG}" != 'undefined' ]]; then
    echo '' >>"${PHOENIX_TEMP}/phoenix-core.cfg"
    combine_files "${PHOENIX_TEMP}/phoenix.cfg" "${PHOENIX_TEMP}/phoenix-core.cfg" "${PHOENIX_OVERRIDES_CFG}" "${PHOENIX_TEMP}/phoenix-unified.cfg"
  else
    combine_files "${PHOENIX_TEMP}/phoenix.cfg" "${PHOENIX_TEMP}/phoenix-core.cfg" "${PHOENIX_TEMP}/phoenix-unified.cfg"
  fi

  # If necessary, append the contents of an additional .cfg file
  maybe_combine_files "${PHOENIX_TEMP}/phoenix-parsed.cfg" "${PHOENIX_TEMP}/phoenix.cfg" "${PHOENIX_EXTRA_CFG}"

  # Clean-up files
  rm -f "${PHOENIX_TEMP}/phoenix-unified.cfg"
  rm -f "${PHOENIX_TEMP}/phoenix-core.cfg"
  rm -f "${PHOENIX_TEMP}/phoenix.cfg"

  # Create enterprise policies
  if [[ "${PHOENIX_ANDROID_ONLY}" != 1 ]] || [[ "${PHOENIX_ANDROID_POLICIES}" == 1 ]]; then
    # Create our directory
    mkdir -p "${PHOENIX_TEMP}/policies"
    # First, create policies that always apply everywhere, regardless of platform
    combine_files "${PHOENIX_TEMP}/policies/phoenix-all-platforms-without-extra-policies-if-specified.json" "${PHOENIX_ROOT}/policies/blocklist.json" "${PHOENIX_ROOT}/policies/cookies.json" "${PHOENIX_ROOT}/policies/phoenix-core.json"

    # If we're not targetting Thunderbird, create policies that always apply everywhere EXCEPT Thunderbird
    if [[ "${PHOENIX_ANDROID_ONLY}" != 1 ]] && [[ "${PHOENIX_MAIL}" == 1 ]]; then
      cp -f "${PHOENIX_TEMP}/policies/phoenix-all-platforms-without-extra-policies-if-specified.json" "${PHOENIX_TEMP}/policies/phoenix-all-platforms-no-mail-if-specified.json"
    else
      combine_files "${PHOENIX_TEMP}/policies/phoenix-all-platforms-no-mail-if-specified.json" "${PHOENIX_TEMP}/policies/phoenix-all-platforms-without-extra-policies-if-specified.json" "${PHOENIX_ROOT}/policies/phoenix-no-mail.json"
    fi

    # If necessary, append the contents of an additional policies.json file
    maybe_combine_files "${PHOENIX_TEMP}/policies/phoenix-all-platforms.json" "${PHOENIX_TEMP}/policies/phoenix-all-platforms-no-mail-if-specified.json" "${PHOENIX_EXTRA_POLICIES}"
  fi
}

# Platform-specific build logic
function build_phoenix() {
  function print_usage() {
    echo "Usage: build_phoenix 'platform'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the platform you would like to build Phoenix for'
    print_usage
    exit 1
  fi

  local readonly phoenix_platform="$1"
  local readonly phoenix_output_dir="${PHOENIX_OUTPUTS}/${phoenix_platform}"

  if [[ "${phoenix_platform}" == 'windows' ]]; then
    local readonly phoenix_output_archive="${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-${phoenix_platform}.zip"
  else
   local readonly phoenix_output_archive="${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-${phoenix_platform}.tar.xz"
  fi

  # Ensure existing outputs don't already exist
  check_file_or_dir_exists "${phoenix_output_dir}"
  check_file_or_dir_exists "${phoenix_output_archive}"

  # Create our output directory
  mkdir -p "${phoenix_output_dir}/assets"

  # Copy our bootstrap phoenix.js
  if [[ "${phoenix_platform}" != 'android' ]]; then
    mkdir -p "${phoenix_output_dir}/defaults/pref"
    cp "${PHOENIX_ROOT}/phoenix.js" "${phoenix_output_dir}/defaults/pref/phoenix.js"
  fi

  # Copy our parsed phoenix.cfg
  if [[ "${phoenix_platform}" == 'osx' ]]; then
    # To ensure installs continue working as expected, this must be placed in the `macos` directory
    local readonly phoenix_cfg_output_dir="${phoenix_output_dir}/macos"
  else
    local readonly phoenix_cfg_output_dir="${phoenix_output_dir}"
  fi
  mkdir -p "${phoenix_cfg_output_dir}"
  cp "${PHOENIX_TEMP}/phoenix-parsed.cfg" "${phoenix_cfg_output_dir}/phoenix.cfg"

  # If necessary, set our platform (for phoenix.cfg)
  if [[ "${PHOENIX_HARDCODE_PLATFORM}" == 1 ]]; then
    if [[ "${phoenix_platform}" == 'osx-intel' ]]; then
      local readonly phoenix_platform_to_hardcode='osx'
    elif [[ "${phoenix_platform}" == 'linux-flatpak' ]]; then
      local readonly phoenix_platform_to_hardcode='linux'
    else
      local readonly phoenix_platform_to_hardcode="${phoenix_platform}"
    fi
    "${PHOENIX_SED}" -i "s|{PHOENIX_PLATFORM_TO_HARDCODE}|${phoenix_platform_to_hardcode}|" "${phoenix_cfg_output_dir}/phoenix.cfg"

    # Set our platform *type*
    if [[ "${phoenix_platform}" != 'osx' ]] && [[ "${phoenix_platform}" != 'osx-intel' ]]; then
      # For now, this is only used on OS X distinguish between Silicon and Intel
      local readonly phoenix_platform_type_to_hardcode='generic'
    elif [[ "${phoenix_platform}" == 'osx-intel' ]]; then
      local readonly phoenix_platform_type_to_hardcode='intel'
    else
      local readonly phoenix_platform_type_to_hardcode='silicon'
    fi
    "${PHOENIX_SED}" -i "s|{PHOENIX_PLATFORM_TYPE_TO_HARDCODE}|${phoenix_platform_type_to_hardcode}|" "${phoenix_cfg_output_dir}/phoenix.cfg"
  else
    "${PHOENIX_SED}" -i "s|{PHOENIX_PLATFORM_TO_HARDCODE}|none|" "${phoenix_cfg_output_dir}/phoenix.cfg"
    "${PHOENIX_SED}" -i "s|{PHOENIX_PLATFORM_TYPE_TO_HARDCODE}|none|" "${phoenix_cfg_output_dir}/phoenix.cfg"
  fi

  # Copy icon
  cp "${PHOENIX_ROOT}/assets/phoenix.png" "${phoenix_output_dir}/assets/phoenix.png"

  # Copy license
  cp "${PHOENIX_ROOT}/COPYING.txt" "${phoenix_output_dir}/COPYING.txt"

  # Copy README
  cp "${PHOENIX_ROOT}/README.md" "${phoenix_output_dir}/README.md"

  # Copy resources for specialized configs
  if [[ "${phoenix_platform}" != 'android' ]] && [[ "${PHOENIX_MAIL}" != 1 ]] &&
    [[ "${PHOENIX_NO_SPEC}" != 1 ]]; then
    cp -r "${PHOENIX_SPECS}" "${phoenix_output_dir}/"
  fi

  # Copy assets for Phoenix's custom `about:` pages
  if [[ "${phoenix_platform}" != 'android' ]] && [[ "${PHOENIX_MAIL}" != 1 ]]; then
    cp -r "${PHOENIX_ROOT}/assets/about" "${phoenix_output_dir}/assets/"
  fi

  # Copy generic platform files
  if [[ "${phoenix_platform}" == 'osx' ]] || [[ "${phoenix_platform}" == 'osx-intel' ]]; then
    cp -r "${PHOENIX_ROOT}/osx/shared/Library" "${phoenix_output_dir}/"
  fi

  # Copy platform-specific files
  if [[ "${phoenix_platform}" == 'android' ]]; then
    cp "${PHOENIX_ROOT}/android/phoenix-unextend.js" "${phoenix_output_dir}/"
  elif [[ "${phoenix_platform}" == 'linux' ]]; then
    cp -r "${PHOENIX_ROOT}/linux/etc" "${phoenix_output_dir}/"
  elif [[ "${phoenix_platform}" == 'osx' ]]; then
    cp -r "${PHOENIX_ROOT}/osx/osx-silicon/Library/" "${phoenix_output_dir}/Library/"
  elif [[ "${phoenix_platform}" == 'osx-intel' ]]; then
    cp -r "${PHOENIX_ROOT}/osx/osx-intel/Library/" "${phoenix_output_dir}/Library/"
  fi

  # If necessary, create enterprise policies
  if [[ "${phoenix_platform}" != 'android' ]] || [[ "${PHOENIX_ANDROID_POLICIES}" == 1 ]]; then
    build_policies "${phoenix_platform}" "${phoenix_output_dir}"
  fi

  # If necessary, create platform-specific static .js files
  if [[ "${phoenix_platform}" == 'android' ]] && [[ "${PHOENIX_STATIC_JS_ANDROID}" == 1 ]]; then
    local readonly phoenix_build_js=1
  elif [[ "${phoenix_platform}" != 'android' ]] && [[ "${PHOENIX_STATIC_JS}" == 1 ]]; then
    local readonly phoenix_build_js=1
  else
    local readonly phoenix_build_js=0
  fi

  if [[ "${phoenix_build_js}" == 1 ]]; then
    build_phoenix_js "${phoenix_platform}" "${phoenix_output_dir}"
  fi

  # Finally, create our platform-specific archives
  if [[ "${PHOENIX_OS}" == 'osx' ]]; then
    /usr/sbin/dot_clean -mv "${phoenix_output_dir}"
  fi

  pushd "${phoenix_output_dir}"
  if [[ "${phoenix_platform}" == 'windows' ]]; then
    zip -r "${phoenix_output_archive}" * -x '.DS_Store'
  else
    "${PHOENIX_TAR}" -cJv --no-xattrs --exclude ".DS_Store" -f "${phoenix_output_archive}" *
  fi
  popd
}

function build_phoenix_js() {
  function print_usage() {
    echo "Usage: build_phoenix_js 'platform'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the platform you would like to build Phoenix (in the static prefs .js format) for'
    print_usage
    exit 1
  fi

  local readonly phoenix_js_platform="$1"

  # First, set the designated location for our file
  if [[ "${phoenix_js_platform}" == 'android' ]]; then
    local readonly phoenix_js_file="${phoenix_output_dir}/phoenix-${PHOENIX_VERSION}-${phoenix_js_platform}.js"
    local readonly phoenix_extended_js_file="${phoenix_output_dir}/phoenix-extended-${PHOENIX_VERSION}-${phoenix_js_platform}.js"
  else
    local readonly phoenix_js_file="${phoenix_output_dir}/phoenix-static-${PHOENIX_VERSION}-${phoenix_js_platform}.js"
    local readonly phoenix_extended_js_file="${phoenix_output_dir}/phoenix-extended-static-${PHOENIX_VERSION}-${phoenix_js_platform}.js"
  fi

  # Convert phoenix.cfg
  "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert-cfg-to-js.py" "${phoenix_output_dir}/phoenix.cfg" "${PHOENIX_TEMP}/phoenix-static-temp-${phoenix_js_platform}.js"

  # If necessary, append the contents of an additional .js file
  maybe_combine_files "${PHOENIX_TEMP}/phoenix-static-temp-${phoenix_js_platform}-with-extra-file-if-necessary.js" "${PHOENIX_TEMP}/phoenix-static-temp-${phoenix_js_platform}.js" "${PHOENIX_EXTRA_JS}"

  # If we're targetting Thunderbird, remove preferences that should NOT be set there
  if [[ "${phoenix_js_platform}" != 'android' ]] && [[ "${PHOENIX_MAIL}" == 1 ]]; then
    parse_js_file "${PHOENIX_TEMP}/phoenix-static-temp-${phoenix_js_platform}-with-extra-file-if-necessary.js" "${PHOENIX_TEMP}/phoenix-static-temp-without-no-mail-if-necessary-${phoenix_js_platform}.js" 'NO-MAIL'
  else
    cp "${PHOENIX_TEMP}/phoenix-static-temp-${phoenix_js_platform}-with-extra-file-if-necessary.js" "${PHOENIX_TEMP}/phoenix-static-temp-without-no-mail-if-necessary-${phoenix_js_platform}.js"
  fi

  # Handle generic platform logic
  if [[ "${phoenix_js_platform}" == 'linux' ]] || [[ "${phoenix_js_platform}" == 'linux-flatpak' ]]; then
    parse_js_file "${PHOENIX_TEMP}/phoenix-static-temp-without-no-mail-if-necessary-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-generic-linux-parsed-${phoenix_js_platform}.js" 'NO-LINUX'
  else
    parse_js_file "${PHOENIX_TEMP}/phoenix-static-temp-without-no-mail-if-necessary-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-generic-linux-parsed-${phoenix_js_platform}.js" 'LINUX-ONLY'
  fi
  if [[ "${phoenix_js_platform}" == 'osx' ]] || [[ "${phoenix_js_platform}" == 'osx-intel' ]]; then
    parse_js_file "${PHOENIX_TEMP}/phoenix-static-temp-without-no-mail-if-necessary-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-generic-parsed-${phoenix_js_platform}.js" 'NO-OSX'
  else
    parse_js_file "${PHOENIX_TEMP}/phoenix-static-temp-without-no-mail-if-necessary-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-generic-parsed-${phoenix_js_platform}.js" 'OSX-ONLY'
  fi

  # Finally, handle platform-specific logic

  ## Android
  if [[ "${phoenix_js_platform}" == 'android' ]]; then
    parse_js_file "${PHOENIX_TEMP}/phoenix-with-generic-parsed-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-android-parsed-${phoenix_js_platform}.js" 'NO-ANDROID'
  else
    parse_js_file "${PHOENIX_TEMP}/phoenix-with-generic-parsed-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-android-parsed-${phoenix_js_platform}.js" 'ANDROID-ONLY'
  fi

  ## Linux (non-Flatpak)
  if [[ "${phoenix_js_platform}" == 'linux' ]]; then
    parse_js_file "${PHOENIX_TEMP}/phoenix-with-android-parsed-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-linux-nonflatpak-parsed-${phoenix_js_platform}.js" 'NO-NON-FLATPAK-LINUX'
  else
    parse_js_file "${PHOENIX_TEMP}/phoenix-with-android-parsed-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-linux-nonflatpak-parsed-${phoenix_js_platform}.js" 'LINUX-NON-FLATPAK-ONLY'
  fi

  ## Linux (Flatpak)
  if [[ "${phoenix_js_platform}" == 'linux-flatpak' ]]; then
    parse_js_file "${PHOENIX_TEMP}/phoenix-with-linux-nonflatpak-parsed-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-linux-flatpak-parsed-${phoenix_js_platform}.js" 'NO-FLATPAK-LINUX'
  else
    parse_js_file "${PHOENIX_TEMP}/phoenix-with-linux-nonflatpak-parsed-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-linux-flatpak-parsed-${phoenix_js_platform}.js" 'FLATPAK-LINUX-ONLY'
  fi

  ## OS X (Silicon)
  if [[ "${phoenix_js_platform}" == 'osx' ]]; then
    parse_js_file "${PHOENIX_TEMP}/phoenix-with-linux-flatpak-parsed-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-osx-silicon-parsed-${phoenix_js_platform}.js" 'NO-SILICON-OSX'
  else
    parse_js_file "${PHOENIX_TEMP}/phoenix-with-linux-flatpak-parsed-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-osx-silicon-parsed-${phoenix_js_platform}.js" 'SILICON-OSX-ONLY'
  fi

  ## OS X (Intel)
  if [[ "${phoenix_js_platform}" == 'osx-intel' ]]; then
    parse_js_file "${PHOENIX_TEMP}/phoenix-with-osx-silicon-parsed-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-osx-intel-parsed-${phoenix_js_platform}.js" 'NO-INTEL-OSX'
  else
    parse_js_file "${PHOENIX_TEMP}/phoenix-with-osx-silicon-parsed-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-osx-intel-parsed-${phoenix_js_platform}.js" 'INTEL-OSX-ONLY'
  fi

  ## Windows
  if [[ "${phoenix_js_platform}" == 'windows' ]]; then
    parse_js_file "${PHOENIX_TEMP}/phoenix-with-osx-intel-parsed-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-windows-parsed-${phoenix_js_platform}.js" 'NO-WINDOWS'
  else
    parse_js_file "${PHOENIX_TEMP}/phoenix-with-osx-intel-parsed-${phoenix_js_platform}.js" "${PHOENIX_TEMP}/phoenix-with-windows-parsed-${phoenix_js_platform}.js" 'WINDOWS-ONLY'
  fi

  # Create our phoenix.js output file
  parse_js_file "${PHOENIX_TEMP}/phoenix-with-windows-parsed-${phoenix_js_platform}.js" "${phoenix_js_file}" 'EXTENDED-ONLY'

  # If PHOENIX_EXTENDED is 1, we also need to create our phoenix-extended.js output file
  if [[ "${PHOENIX_EXTENDED}" == 1 ]]; then
    parse_js_file "${PHOENIX_TEMP}/phoenix-with-windows-parsed-${phoenix_js_platform}.js" "${phoenix_extended_js_file}" 'NO-EXTENDED'
  fi
}

# Platform-specific policies build logic
function build_policies() {
  function print_usage() {
    echo "Usage: build_policies 'platform' '/path/to/output_dir'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the platform you would like to build Phoenix policies for'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify an output directory for your Phoenix policies'
    print_usage
    exit 1
  fi

  local readonly phoenix_policies_platform="$1"
  local readonly phoenix_policies_output_dir="$2"

  # If we're not targetting Android, create policies that always apply everywhere EXCEPT Android
  if [[ "${phoenix_policies_platform}" == 'android' ]]; then
    cp -f "${PHOENIX_TEMP}/policies/phoenix-all-platforms.json" "${PHOENIX_TEMP}/policies/phoenix-no-android-if-necessary-${phoenix_policies_platform}.json"
  else
    combine_files "${PHOENIX_TEMP}/policies/phoenix-no-android-if-necessary-without-no-mail-if-specified-${phoenix_policies_platform}.json" "${PHOENIX_TEMP}/policies/phoenix-all-platforms.json" "${PHOENIX_ROOT}/policies/phoenix-no-android.json"

    # If we're not targetting Thunderbird, then create policies that apply everywhere EXCEPT Android AND Thunderbird
    if [[ "${PHOENIX_MAIL}" == 1 ]]; then
      cp -f "${PHOENIX_TEMP}/policies/phoenix-no-android-if-necessary-without-no-mail-if-specified-${phoenix_policies_platform}.json" "${PHOENIX_TEMP}/policies/phoenix-no-android-if-necessary-${phoenix_policies_platform}.json"
    else
      combine_files "${PHOENIX_TEMP}/policies/phoenix-no-android-if-necessary-${phoenix_policies_platform}.json" "${PHOENIX_TEMP}/policies/phoenix-no-android-if-necessary-without-no-mail-if-specified-${phoenix_policies_platform}.json" "${PHOENIX_ROOT}/policies/phoenix-no-android-no-mail.json"
    fi
  fi

  # Handle generic platform policies
  if [[ "${phoenix_policies_platform}" == 'linux' ]] || [[ "${phoenix_policies_platform}" == 'linux-flatpak' ]]; then
    combine_files "${PHOENIX_TEMP}/policies/phoenix-linux-generic-without-extra-policies-if-specified-${phoenix_policies_platform}.json" "${PHOENIX_TEMP}/policies/phoenix-no-android-if-necessary-${phoenix_policies_platform}.json" "${PHOENIX_ROOT}/policies/phoenix-linux.json"

    # If we're not targetting Thunderbird, create generic policies that do NOT apply to it
    if [[ "${PHOENIX_MAIL}" == 1 ]]; then
      cp -f "${PHOENIX_TEMP}/policies/phoenix-linux-generic-without-extra-policies-if-specified-${phoenix_policies_platform}.json" "${PHOENIX_TEMP}/policies/phoenix-linux-generic-no-mail-if-specified-${phoenix_policies_platform}.json"
    else
      combine_files "${PHOENIX_TEMP}/policies/phoenix-linux-generic-no-mail-if-specified-${phoenix_policies_platform}.json" "${PHOENIX_TEMP}/policies/phoenix-linux-generic-without-extra-policies-if-specified-${phoenix_policies_platform}.json" "${PHOENIX_ROOT}/policies/phoenix-linux-no-mail.json"
    fi

    # If necessary, append the contents of an additional policies.json file
    maybe_combine_files "${PHOENIX_TEMP}/policies/phoenix-with-generic-if-necessary-${phoenix_policies_platform}.json" "${PHOENIX_TEMP}/policies/phoenix-linux-generic-no-mail-if-specified-${phoenix_policies_platform}.json" "${PHOENIX_EXTRA_POLICIES_LINUX}"
  elif [[ "${phoenix_policies_platform}" == 'osx' ]] || [[ "${phoenix_policies_platform}" == 'osx-intel' ]]; then
    combine_files "${PHOENIX_TEMP}/policies/phoenix-osx-generic-without-extra-policies-if-specified-${phoenix_policies_platform}.json" "${PHOENIX_TEMP}/policies/phoenix-no-android-if-necessary-${phoenix_policies_platform}.json" "${PHOENIX_ROOT}/policies/phoenix-osx.json"

    # If we're not targetting Thunderbird, create generic policies that do NOT apply to it
    if [[ "${PHOENIX_MAIL}" == 1 ]]; then
      cp -f "${PHOENIX_TEMP}/policies/phoenix-osx-generic-without-extra-policies-if-specified-${phoenix_policies_platform}.json" "${PHOENIX_TEMP}/policies/phoenix-osx-generic-no-mail-if-specified-${phoenix_policies_platform}.json"
    else
      combine_files "${PHOENIX_TEMP}/policies/phoenix-osx-generic-no-mail-if-specified-${phoenix_policies_platform}.json" "${PHOENIX_TEMP}/policies/phoenix-osx-generic-without-extra-policies-if-specified-${phoenix_policies_platform}.json" "${PHOENIX_ROOT}/policies/phoenix-osx-no-mail.json"
    fi

    # If necessary, append the contents of an additional policies.json file
    maybe_combine_files "${PHOENIX_TEMP}/policies/phoenix-with-generic-if-necessary-${phoenix_policies_platform}.json" "${PHOENIX_TEMP}/policies/phoenix-osx-generic-no-mail-if-specified-${phoenix_policies_platform}.json" "${PHOENIX_EXTRA_POLICIES_OSX}"
  else
    cp -f "${PHOENIX_TEMP}/policies/phoenix-no-android-if-necessary-${phoenix_policies_platform}.json" "${PHOENIX_TEMP}/policies/phoenix-with-generic-if-necessary-${phoenix_policies_platform}.json"
  fi

  # Handle platform-specific policies
  maybe_combine_files "${PHOENIX_TEMP}/policies/phoenix-${phoenix_policies_platform}-without-no-mail-if-necessary.json" "${PHOENIX_TEMP}/policies/phoenix-with-generic-if-necessary-${phoenix_policies_platform}.json" "${PHOENIX_ROOT}/policies/phoenix-${phoenix_policies_platform}.json"

  # If we're not targeting Thunderbird, handle platform-specific policies that do NOT apply to it
  if [[ "${PHOENIX_MAIL}" == 1 ]]; then
    cp -f "${PHOENIX_TEMP}/policies/phoenix-with-generic-if-necessary-${phoenix_policies_platform}.json" "${PHOENIX_TEMP}/policies/phoenix-${phoenix_policies_platform}.json"
  else
    maybe_combine_files "${PHOENIX_TEMP}/policies/phoenix-${phoenix_policies_platform}.json" "${PHOENIX_TEMP}/policies/phoenix-with-generic-if-necessary-${phoenix_policies_platform}.json" "${PHOENIX_ROOT}/policies/phoenix-${phoenix_policies_platform}-no-mail.json"
  fi

  # Set our final policies.json output directory
  if [[ "${phoenix_policies_platform}" == 'android' ]]; then
    local readonly policies_output_path="${phoenix_policies_output_dir}"
  elif [[ "${phoenix_policies_platform}" == 'linux' ]] ||
    [[ "${phoenix_policies_platform}" == 'linux-flatpak' ]]; then
    local readonly policies_output_path="${phoenix_policies_output_dir}/policies"
  elif [[ "${phoenix_policies_platform}" == 'osx' ]] ||
    [[ "${phoenix_policies_platform}" == 'osx-intel' ]]; then
    local readonly policies_output_path="${phoenix_policies_output_dir}/unused"
  elif [[ "${phoenix_policies_platform}" == 'windows' ]]; then
    local readonly policies_output_path="${phoenix_policies_output_dir}/distribution"
  fi
  mkdir -p "${policies_output_path}"

  # Finally, handle platform-specific extra policies if necessary
  if [[ "${phoenix_policies_platform}" == 'android' ]]; then
    local readonly extra_policies_file="${PHOENIX_EXTRA_POLICIES_ANDROID}"
  elif [[ "${phoenix_policies_platform}" == 'linux' ]]; then
    local readonly extra_policies_file="${PHOENIX_EXTRA_POLICIES_LINUX_NONFLATPAK}"
  elif [[ "${phoenix_policies_platform}" == 'linux-flatpak' ]]; then
    local readonly extra_policies_file="${PHOENIX_EXTRA_POLICIES_LINUX_FLATPAK}"
  elif [[ "${phoenix_policies_platform}" == 'osx' ]]; then
    local readonly extra_policies_file="${PHOENIX_EXTRA_POLICIES_OSX_SILICON}"
  elif [[ "${phoenix_policies_platform}" == 'osx-intel' ]]; then
    local readonly extra_policies_file="${PHOENIX_EXTRA_POLICIES_OSX_INTEL}"
  elif [[ "${phoenix_policies_platform}" == 'windows' ]]; then
    local readonly extra_policies_file="${PHOENIX_EXTRA_POLICIES_WINDOWS}"
  fi
  maybe_combine_files "${policies_output_path}/policies.json" "${PHOENIX_TEMP}/policies/phoenix-${phoenix_policies_platform}.json" "${extra_policies_file}"

  # For OS X, we also need to convert policies to the plist format
  if [[ "${phoenix_policies_platform}" == 'osx' ]]; then
    # To ensure installs continue working as expected, this must be placed in the `macos` directory
    ## (See osx/osx-silicon/Library/celenity/Phoenix/phoenix-apply.sh)
    local readonly policies_plist_output_path="${phoenix_policies_output_dir}/macos"
  elif [[ "${phoenix_policies_platform}" == 'osx-intel' ]]; then
    local readonly policies_plist_output_path="${phoenix_policies_output_dir}"
  fi

  if [[ "${phoenix_policies_platform}" == 'osx' ]] ||
    [[ "${phoenix_policies_platform}" == 'osx-intel' ]]; then
    mkdir -p "${policies_plist_output_path}"
    "${PHOENIX_PYTHON}" "${PHOENIX_SCRIPTS}/convert_json_to_plist.py" "${policies_output_path}/policies.json" "${policies_plist_output_path}/org.mozilla.firefox.plist"
  fi
}

# First, if necessary, verify that variables specifying additional configuration/policies files are configured correctly
## This is ran first because we want to run these checks early, and we don't need to run them repeatedly
check_extra_files

# Create our temporary file directory
if [[ -d "${PHOENIX_TEMP}" ]]; then
    rm -rf "${PHOENIX_TEMP}"
fi
mkdir -p "${PHOENIX_TEMP}"

# Build Phoenix (platform-generic logic)
build_phoenix_common

# Build Phoenix for Android
if [[ "${PHOENIX_ANDROID}" == 1 ]]; then
  build_phoenix 'android'
fi

# Build Phoenix for Linux (non-Flatpak)
if [[ "${PHOENIX_LINUX}" == 1 ]]; then
  build_phoenix 'linux'
fi

# Build Phoenix for Linux (Flatpak)
if [[ "${PHOENIX_LINUX_FLATPAK}" == 1 ]]; then
  build_phoenix 'linux-flatpak'
fi

# Build Phoenix for OS X (Silicon)
if [[ "${PHOENIX_OSX}" == 1 ]]; then
  build_phoenix 'osx'
fi

# Build Phoenix for OS X (Intel)
if [[ "${PHOENIX_OSX_INTEL}" == 1 ]]; then
  build_phoenix 'osx-intel'
fi

# Build Phoenix for Windows
if [[ "${PHOENIX_WINDOWS}" == 1 ]]; then
  build_phoenix 'windows'
fi

# Clean-up temporary files
rm -rf "${PHOENIX_TEMP}"
