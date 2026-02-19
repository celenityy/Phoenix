
# Set platform
if [[ "${OSTYPE}" == "darwin"* ]]; then
    export PHOENIX_PLATFORM='darwin'
else
    export PHOENIX_PLATFORM='linux'
fi

# Set OS
if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
    export PHOENIX_OS='osx'
elif [[ "${PHOENIX_NIX}" == 1 ]]; then
    export PHOENIX_OS='nix'
elif [[ "${PHOENIX_PLATFORM}" == 'linux' ]]; then
    if [[ -f "/etc/os-release" ]]; then
        source /etc/os-release
        if [[ -n "${ID}" ]]; then
            export PHOENIX_OS="${ID}"
        else
            export PHOENIX_OS='unknown'
        fi
    else
        export PHOENIX_OS='unknown'
    fi
else
    export PHOENIX_OS='unknown'
fi
