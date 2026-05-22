# Build Phoenix

## Libs

```bash
# Fedora Linux
dnf install jq python uv bash

# Gentoo GNU/Linux
emerge -av app-misc/jq dev-lang/python dev-python/uv app-shells/bash
```

## Build

```bash
#!/bin/bash

set -euo pipefail

git clone https://codeberg.org/celenity/Phoenix.git --depth=1
cd Phoenix
uv python install 3.14
uv venv build/pyenv --python 3.14 --seed
source build/pyenv/bin/activate
./scripts/build.sh
deactivate
```
