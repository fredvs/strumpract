#!/usr/bin/env bash
set -euo pipefail

# 1. Install pure FPC on Debian/Ubuntu systems instead of Lazarus
if [[ -f '/etc/os-release' ]]; then
    source '/etc/os-release'
fi

if [[ "${ID:-}" == "debian" || "${ID:-}" == "ubuntu" ]]; then
    sudo bash -c '
        apt-get update; apt-get -y install fpc
    ' >/dev/null
fi

# 2. Dynamically swap the target kernel path depending on the runner platform
if [[ "${OSTYPE:-}" == "msys" || "${OS:-}" == "Windows_NT" ]]; then
    KERNEL_DIR="windows"
else
    KERNEL_DIR="linux"
fi

# 3. Apply cross-platform array configurations for the compiler search paths
declare -ar OPS=(
    -Fu"use/mseide-msegui/lib/common/*"
    -Fu"use/mseide-msegui/lib/common/kernel/${KERNEL_DIR}"
    -Fu"use/bgrabitmap/bgrabitmap"
    -dmse_dynpo
    -dclass_bridge
    -dBGRABITMAP_USE_MSEGUI
    -B
)

declare -i exitCode=0
while read -r; do
    if ! [[ ${REPLY} =~ /use/ ]]; then
        mapfile -t < <(
            if [[ -f "${REPLY%.*}.pas" ]]; then
                if (fpc "${OPS[@]}" -B "${REPLY%.*}.pas"); then
                    printf 'SUCCES\t\x1b[32m%s\x1b[0m\n' "${REPLY}" >&2
                    printf 'exitCode:0\n'
                else
                    printf 'ERROR\t\x1b[31m%s\x1b[0m\n'  "${REPLY}" >&2
                    printf 'exitCode:1\n'
                fi |
                    grep --extended-regexp '(Error:|Fatal:|Linking|exitCode)'
            fi
        )
        if ((${#MAPFILE[@]})) && ((${MAPFILE[-1]##*:})); then
            exitCode+=${MAPFILE[-1]##*:}
        fi
        printf '%s\n' "${MAPFILE[@]}"
    fi
done < <(find '.' -type 'f' -name '*.prj')
exit "${exitCode}"
