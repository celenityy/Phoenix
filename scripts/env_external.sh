# Phoenix external environment variables

## This is used for converting Phoenix-specific environment variables to ones used in external projects.

## CAUTION: Do NOT source this directly!
## Source 'env.sh' instead.

## CAUTION: Do NOT try to configure any of these environment variables directly!
## Use the Phoenix equivalent variables (at `env_common.sh`) instead.

# Python
## https://docs.python.org/3/using/cmdline.html#environment-variables

## Disable JIT
readonly export PYTHON_JIT=0
readonly export PYTHON_PERF_JIT_SUPPORT=0

## Disable remote debugging
readonly export PYTHON_DISABLE_REMOTE_DEBUG=1

## Enable performance optimizations
readonly export PYTHONOPTIMIZE=1
