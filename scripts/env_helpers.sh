
# Set platform
if [[ "${OSTYPE}" == "darwin"* ]]; then
    readonly PHOENIX_PLATFORM='darwin'
else
    readonly PHOENIX_PLATFORM='linux'
fi
export PHOENIX_PLATFORM

# Set OS
if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
    readonly PHOENIX_OS='osx'
elif [[ "${PHOENIX_PLATFORM}" == 'linux' ]]; then
    if [[ -f "/etc/os-release" ]]; then
        source /etc/os-release
        if [[ -n "${ID}" ]]; then
            readonly PHOENIX_OS="${ID}"
        else
            readonly PHOENIX_OS='unknown'
        fi
    else
        readonly PHOENIX_OS='unknown'
    fi
else
    readonly PHOENIX_OS='unknown'
fi
export PHOENIX_OS
