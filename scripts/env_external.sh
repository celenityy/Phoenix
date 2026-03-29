# Phoenix external environment variables

## This is used for converting Phoenix-specific environment variables to ones used in external projects.

## CAUTION: Do NOT source this directly!
## Source 'env.sh' instead.

## CAUTION: Do NOT try to configure any of these environment variables directly!
## Use the Phoenix equivalent variables (at `env_common.sh`) instead.

# Python
## https://docs.python.org/3/using/cmdline.html#environment-variables

## Disable JIT
readonly PYTHON_JIT=0
readonly PYTHON_PERF_JIT_SUPPORT=0
export PYTHON_JIT
export PYTHON_PERF_JIT_SUPPORT

## Disable remote debugging
readonly PYTHON_DISABLE_REMOTE_DEBUG=1
export PYTHON_DISABLE_REMOTE_DEBUG

## Enable performance optimizations
readonly PYTHONOPTIMIZE=1
export PYTHONOPTIMIZE

# UV
## https://docs.astral.sh/uv/reference/environment/

## Cache directory
export UV_CACHE_DIR="${PHOENIX_UV_LOCAL}/cache"

## Disable cache
export UV_NO_CACHE=1

## Disable the system CA root store
export UV_SYSTEM_CERTS='false'

## Exclude development dependencies
export UV_NO_DEV=1

## Executables directory
export UV_PYTHON_BIN_DIR="${PHOENIX_UV_LOCAL}/bin"
export UV_PYTHON_INSTALL_BIN=1

## Ignore configuration files
export UV_NO_CONFIG=1

## Ignore env files
export UV_NO_ENV_FILE=1

## Location
export UV_INSTALL_DIR="${PHOENIX_UV_DIR}"

## Prevent automatic downloads/updates
export UV_DISABLE_UPDATE=1
export UV_PYTHON_DOWNLOADS='manual'

## Prevent modifying the system PATH
export INSTALLER_NO_MODIFY_PATH=1
export UV_NO_MODIFY_PATH=1
export UV_UNMANAGED_INSTALL="${PHOENIX_UV_DIR}"

## Prevent using the system Python
export UV_MANAGED_PYTHON=1
export UV_SYSTEM_PYTHON='false'

## Python
export UV_PYTHON_CACHE_DIR="${PHOENIX_UV_LOCAL}/python-cache"
export UV_PYTHON_INSTALL_MIRROR="file://${PHOENIX_PYTHON_DIR}"
export UV_PYTHON_INSTALL_DIR="${PHOENIX_UV_LOCAL}/python"

## Python environment
export UV_PROJECT_ENVIRONMENT="${PHOENIX_PYENV_DIR}"
export VIRTUAL_ENV="${PHOENIX_PYENV_DIR}"

## Tools directory
export UV_TOOL_BIN_DIR="${PHOENIX_UV_LOCAL}/tools/bin"
export UV_TOOL_DIR="${PHOENIX_UV_LOCAL}/tools"

# Include version info
source "${PHOENIX_VERSIONS}"

## Pin Python version
export UV_PYTHON_CPYTHON_BUILD="${PYTHON_GIT_RELEASE}"
