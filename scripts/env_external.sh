# shellcheck shell=bash
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

# s3cmd

## Avoid installing manual pages/doc files
### https://github.com/s3tools/s3cmd/blob/master/INSTALL.md#note-to-distributions-package-maintainers
readonly S3CMD_PACKAGING='yes'
export S3CMD_PACKAGING

# uv
## https://docs.astral.sh/uv/reference/environment/

## Cache directory
readonly UV_CACHE_DIR="${PHOENIX_UV_LOCAL}/cache"
export UV_CACHE_DIR

## Disable cache
readonly UV_NO_CACHE=1
export UV_NO_CACHE

## Disable the system CA root store
readonly UV_SYSTEM_CERTS='false'
export UV_SYSTEM_CERTS

## Exclude development dependencies
readonly UV_NO_DEV=1
export UV_NO_DEV

## Executables directory
readonly UV_PYTHON_BIN_DIR="${PHOENIX_UV_LOCAL}/bin"
readonly UV_PYTHON_INSTALL_BIN=1
export UV_PYTHON_BIN_DIR
export UV_PYTHON_INSTALL_BIN

## Ignore configuration files
readonly UV_NO_CONFIG=1
readonly UV_NO_SYSTEM_CONFIG=1
export UV_NO_CONFIG
export UV_NO_SYSTEM_CONFIG

## Ignore env files
readonly UV_NO_ENV_FILE=1
export UV_NO_ENV_FILE

## Location
readonly UV_INSTALL_DIR="${PHOENIX_UV_DIR}"
export UV_INSTALL_DIR

## Prevent automatic downloads/updates
readonly UV_DISABLE_UPDATE=1
readonly UV_PYTHON_DOWNLOADS='manual'
export UV_DISABLE_UPDATE
export UV_PYTHON_DOWNLOADS

## Prevent modifying the system PATH
readonly INSTALLER_NO_MODIFY_PATH=1
readonly UV_NO_MODIFY_PATH=1
readonly UV_UNMANAGED_INSTALL="${PHOENIX_UV_DIR}"
export INSTALLER_NO_MODIFY_PATH
export UV_NO_MODIFY_PATH
export UV_UNMANAGED_INSTALL

## Prevent using the system Python
readonly UV_MANAGED_PYTHON=1
readonly UV_PYTHON_NO_REGISTRY=1
readonly UV_SYSTEM_PYTHON='false'
export UV_MANAGED_PYTHON
export UV_PYTHON_NO_REGISTRY
export UV_SYSTEM_PYTHON

## Python
readonly UV_PYTHON_CACHE_DIR="${PHOENIX_UV_LOCAL}/python-cache"
readonly UV_PYTHON_INSTALL_MIRROR="file://${PHOENIX_PYTHON_DIR}"
readonly UV_PYTHON_INSTALL_DIR="${PHOENIX_UV_LOCAL}/python"
export UV_PYTHON_CACHE_DIR
export UV_PYTHON_INSTALL_MIRROR
export UV_PYTHON_INSTALL_DIR

## Python environment
readonly UV_PROJECT_ENVIRONMENT="${PHOENIX_PYENV_DIR}"
VIRTUAL_ENV="${PHOENIX_PYENV_DIR}"
export UV_PROJECT_ENVIRONMENT
export VIRTUAL_ENV

## Tools directory
readonly UV_TOOL_BIN_DIR="${PHOENIX_UV_LOCAL}/tools/bin"
readonly UV_TOOL_DIR="${PHOENIX_UV_LOCAL}/tools"
export UV_TOOL_BIN_DIR
export UV_TOOL_DIR

# Include version info
source "${PHOENIX_VERSIONS}"

## Pin Python version
readonly UV_PYTHON_CPYTHON_BUILD="${PHOENIX_PYTHON_GIT_RELEASE}"
export UV_PYTHON_CPYTHON_BUILD
