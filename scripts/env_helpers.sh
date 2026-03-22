
# Set platform
if [[ "${OSTYPE}" == "darwin"* ]]; then
    readonly export PHOENIX_PLATFORM='darwin'
else
    readonly export PHOENIX_PLATFORM='linux'
fi

# Set OS
if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
    readonly export PHOENIX_OS='osx'
elif [[ "${PHOENIX_PLATFORM}" == 'linux' ]]; then
    if [[ -f "/etc/os-release" ]]; then
        source /etc/os-release
        if [[ -n "${ID}" ]]; then
            readonly export PHOENIX_OS="${ID}"
        else
            readonly export PHOENIX_OS='unknown'
        fi
    else
        readonly export PHOENIX_OS='unknown'
    fi
else
    readonly export PHOENIX_OS='unknown'
fi
