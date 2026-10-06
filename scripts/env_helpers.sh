# shellcheck shell=bash

# Set our platform/OS
function set_platform() {
  # Set platform
  unset PHOENIX_PLATFORM
  unset PHOENIX_PLATFORM_PRETTY

  # First, leverage `PHOENIX_HOST_PLATFORM`
  if [[ -n "${PHOENIX_HOST_PLATFORM+x}" ]]; then
    if [[ "${PHOENIX_HOST_PLATFORM}" == 'android' ]] || [[ "${PHOENIX_HOST_PLATFORM}" == 'linux' ]]; then
      readonly PHOENIX_PLATFORM='linux'
    elif [[ "${PHOENIX_HOST_PLATFORM}" == 'osx' ]] || [[ "${PHOENIX_HOST_PLATFORM}" == 'osx-intel' ]]; then
      readonly PHOENIX_PLATFORM='darwin'
    elif [[ "${PHOENIX_HOST_PLATFORM}" == 'windows' ]]; then
      readonly PHOENIX_PLATFORM='windows'
    fi
  fi

  # Check `OSTYPE`
  if [[ -z "${PHOENIX_PLATFORM+x}" ]] && [[ -n "${OSTYPE+x}" ]]; then
    if [[ "${OSTYPE}" == 'cygwin' ]] || [[ "${OSTYPE}" == 'msys' ]] || [[ "${OSTYPE}" == 'win32' ]]; then
      readonly PHOENIX_PLATFORM='windows'
    elif [[ "${OSTYPE}" == "darwin"* ]]; then
      readonly PHOENIX_PLATFORM='darwin'
    elif [[ "${OSTYPE}" == 'linux-android' ]] || [[ "${OSTYPE}" == 'linux-gnu' ]]; then
      readonly PHOENIX_PLATFORM='linux'
    fi
  fi

  # Check `OS`
  if [[ -z "${PHOENIX_PLATFORM+x}" ]] && [[ -n "${OS+x}" ]] && [[ "${OS}" == 'Windows_NT' ]]; then
    readonly PHOENIX_PLATFORM='windows'
  fi

  # Not much else we can do :(
  if [[ -z "${PHOENIX_PLATFORM+x}" ]]; then
    readonly PHOENIX_PLATFORM='unknown'
  fi

  if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
    readonly PHOENIX_PLATFORM_PRETTY='Darwin'
  elif [[ "${PHOENIX_PLATFORM}" == 'linux' ]]; then
    readonly PHOENIX_PLATFORM_PRETTY='Linux'
  elif [[ "${PHOENIX_PLATFORM}" == 'windows' ]]; then
    readonly PHOENIX_PLATFORM_PRETTY='Windows'
  elif [[ "${PHOENIX_PLATFORM}" == 'unknown' ]]; then
    readonly PHOENIX_PLATFORM_PRETTY='Unknown'
  else
    echo "ERROR: Invalid platform: '${PHOENIX_PLATFORM}'!"
    exit 1
  fi

  # Set OS
  unset PHOENIX_OS
  unset PHOENIX_OS_PRETTY

  if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
    readonly PHOENIX_OS='osx'
  elif [[ "${PHOENIX_PLATFORM}" == 'windows' ]]; then
    readonly PHOENIX_OS='windows'
  elif [[ "${PHOENIX_PLATFORM}" == 'linux' ]]; then
    # First, we can check for Android with `PHOENIX_HOST_PLATFORM`
    if [[ -n "${PHOENIX_HOST_PLATFORM+x}" ]] && [[ "${PHOENIX_HOST_PLATFORM}" == 'android' ]]; then
      readonly PHOENIX_OS='android'
    fi

    # We can also check for Android with `OSTYPE`
    if [[ -z "${PHOENIX_OS+x}" ]] && [[ -n "${OSTYPE+x}" ]] && [[ "${OSTYPE}" == 'linux-android' ]]; then
      readonly PHOENIX_OS='android'
    fi

    # Otherwise, we fall back to `/etc/os-release`
    if [[ -z "${PHOENIX_OS+x}" ]] && [[ -f '/etc/os-release' ]] && [[ -s '/etc/os-release' ]]; then
      source '/etc/os-release'
      if [[ -n "${ID+x}" ]]; then
        readonly PHOENIX_OS="${ID+x}"
      fi
    fi
  fi

  # Not much else we can do :(
  if [[ -z "${PHOENIX_OS+x}" ]]; then
    readonly PHOENIX_OS='unknown'
  fi

  if [[ "${PHOENIX_OS}" == 'android' ]]; then
    readonly PHOENIX_OS_PRETTY='Android'
  elif [[ "${PHOENIX_OS}" == 'fedora' ]]; then
    readonly PHOENIX_OS_PRETTY='Fedora'
  elif [[ "${PHOENIX_OS}" == 'osx' ]]; then
    readonly PHOENIX_OS_PRETTY='OS X'
  elif [[ "${PHOENIX_OS}" == 'secureblue' ]]; then
    readonly PHOENIX_OS_PRETTY='Secureblue'
  elif [[ "${PHOENIX_OS}" == 'ubuntu' ]]; then
    readonly PHOENIX_OS_PRETTY='Ubuntu'
  elif [[ "${PHOENIX_OS}" == 'windows' ]]; then
    readonly PHOENIX_OS_PRETTY='Windows'
  elif [[ "${PHOENIX_OS}" == 'unknown' ]]; then
    readonly PHOENIX_OS_PRETTY='Unknown'
  elif [[ "${PHOENIX_PLATFORM}" == 'linux' ]] && [[ -n "${ID+x}" ]]; then
    readonly PHOENIX_OS_PRETTY="${PHOENIX_OS}"
  else
    echo "ERROR: Invalid operating system: '${PHOENIX_OS}'!"
    exit 1
  fi
}

# Set our architecture
function set_arch() {
  unset PHOENIX_PLATFORM_ARCH
  unset PHOENIX_PLATFORM_ARCH_PRETTY

  # First, if we're on OS X, we can actually try `PHOENIX_HOST_PLATFORM`
  if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]] && [[ -n "${PHOENIX_HOST_PLATFORM+x}" ]]; then
    if [[ "${PHOENIX_HOST_PLATFORM}" == 'osx-intel' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='x86_64'
    elif [[ "${PHOENIX_HOST_PLATFORM}" == 'osx' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='arm64'
    fi
  fi

  if [[ -z "${PHOENIX_PLATFORM_ARCH+x}" ]]; then
    # Find uname
    if [[ -n "${PHOENIX_UNAME+x}" ]] && [[ -x "${PHOENIX_UNAME}" ]]; then
      local -r uname="${PHOENIX_UNAME}"
    elif [[ -x '/bin/uname' ]]; then
      local -r uname='/bin/uname'
    elif [[ -x '/usr/bin/uname' ]]; then
      local -r uname='/usr/bin/uname'
    else
      if ! command -v uname > /dev/null 2>&1; then
        echo "ERROR: Missing uname!" >&2
        exit 1
      fi
      # It isn't a known location, so we sadly have to just fall-back to the PATH
      local -r uname="$(uname)"
    fi

    # Set architecture
    local -r arch=$("${uname}" -m)
    if [[ "${arch}" == 'aarch64' ]] || [[ "${arch}" == 'aarch64_be' ]] || [[ "${arch}" == 'arm64' ]] || [[ "${arch}" == 'armv8b' ]] ||
      [[ "${arch}" == 'armv8l' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='arm64'
    elif [[ "${arch}" == 'amd64' ]] || [[ "${arch}" == 'x86_64' ]] || [[ "${arch}" == 'x86_64-AT386' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='x86_64'
    elif [[ "${arch}" == 'armv4t' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='armv4'
    elif [[ "${arch}" == 'armv5t' ]] || [[ "${arch}" == 'armv5te' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='armv5'
    elif [[ "${arch}" == 'armv6' ]] || [[ "${arch}" == 'armv6j' ]] || [[ "${arch}" == 'armv6k' ]] || [[ "${arch}" == 'armv6kz' ]] ||
      [[ "${arch}" == 'armv6l' ]] || [[ "${arch}" == 'armv6t2' ]] || [[ "${arch}" == 'armv6z' ]] || [[ "${arch}" == 'armv6zk' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='armv6'
    elif [[ "${arch}" == 'armv7' ]] || [[ "${arch}" == 'armv7l' ]] || [[ "${arch}" == 'armv7ve' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='arm'
    elif [[ "${arch}" == 'i386' ]] || [[ "${arch}" == 'i386-AT38621' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='i386'
    elif [[ "${arch}" == 'i486' ]] || [[ "${arch}" == 'i486-AT38621' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='i486'
    elif [[ "${arch}" == 'i586' ]] || [[ "${arch}" == 'i586-AT38621' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='i586'
    elif [[ "${arch}" == 'i686' ]] || [[ "${arch}" == 'i686-64' ]] || [[ "${arch}" == 'i686-AT386' ]] || [[ "${arch}" == 'i686-AT38621' ]] ||
      [[ "${arch}" == 'i86pc' ]] || [[ "${arch}" == 'x86' ]] || [[ "${arch}" == 'x86pc' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='x86'
    elif [[ "${arch}" == 'ppc' ]] || [[ "${arch}" == 'ppcle' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='ppc'
    elif [[ "${arch}" == 'ppc64' ]] || [[ "${arch}" == 'ppc64le' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='ppc64'
    elif [[ "${arch}" == 'riscv64' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='riscv'
    elif [[ "${arch}" == 's390' ]] || [[ "${arch}" == 's390x' ]]; then
      readonly PHOENIX_PLATFORM_ARCH='s390x'
    fi
  fi

  # Not much else we can do :(
  if [[ -z "${PHOENIX_PLATFORM_ARCH+x}" ]]; then
    readonly PHOENIX_PLATFORM_ARCH='unknown'
  fi

  if [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm' ]]; then
    readonly PHOENIX_PLATFORM_ARCH_PRETTY='ARM'
  elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'arm64' ]]; then
    readonly PHOENIX_PLATFORM_ARCH_PRETTY='ARM64'
  elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'armv4' ]]; then
    readonly PHOENIX_PLATFORM_ARCH_PRETTY='ARMv4'
  elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'armv5' ]]; then
    readonly PHOENIX_PLATFORM_ARCH_PRETTY='ARMv5'
  elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'armv6' ]]; then
    readonly PHOENIX_PLATFORM_ARCH_PRETTY='ARMv6'
  elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'ppc' ]]; then
    readonly PHOENIX_PLATFORM_ARCH_PRETTY='PPC'
  elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'ppc64' ]]; then
    readonly PHOENIX_PLATFORM_ARCH_PRETTY='PPC64'
  elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'riscv' ]]; then
    readonly PHOENIX_PLATFORM_ARCH_PRETTY='RISC-V'
  elif [[ "${PHOENIX_PLATFORM_ARCH}" == 'i386' ]] || [[ "${PHOENIX_PLATFORM_ARCH}" == 'i486' ]] || [[ "${PHOENIX_PLATFORM_ARCH}" == 'i586' ]] ||
    [[ "${PHOENIX_PLATFORM_ARCH}" == 's390x' ]] || [[ "${PHOENIX_PLATFORM_ARCH}" == 'x86' ]] || [[ "${PHOENIX_PLATFORM_ARCH}" == 'x86_64' ]]; then
    readonly PHOENIX_PLATFORM_ARCH_PRETTY="${PHOENIX_PLATFORM_ARCH}"
  else
    echo "ERROR: Invalid architecture: '${PHOENIX_PLATFORM_ARCH}'!"
    exit 1
  fi
}

# Set our platform/OS
set_platform || exit 1

# Set our architecture
set_arch || exit 1

echo "Detected platform:         '${PHOENIX_PLATFORM_PRETTY}'"
echo "Detected operating system: '${PHOENIX_OS_PRETTY}'"
echo "Detected architecture:     '${PHOENIX_PLATFORM_ARCH_PRETTY}'"
