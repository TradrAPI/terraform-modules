#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

main() {
    local key="$1"
    local urls="$2"

    mkdir -p plugins
    cd plugins

    # Creates a temporary directory for each of the script's call
    local dir=$(mktemp -p . -d -t msk-connect.XXXXXXX)
    cd "${dir}"

    for url in ${urls//,/ }; do
        plugin=$(basename "${url}")
        curl -o "${plugin}" -LO "${url}"

        if [[ "${plugin}" == *.zip ]]; then
            # If the plugin is a zip file, we need to unzip it
            # and remove the zip file afterwards
            # The unzip command will create a directory with the same name as the zip file
            # For example: plugin-1.0.zip -> plugin-1.0/
            echo "Unzipping ${plugin}"
            python3 -m zipfile -e "${plugin}"
            rm "${plugin}"
        elif [[ "${plugin}" == *.jar ]]; then
            # If the plugin is a jar file, we need to create a directory for it
            # and move the jar file into that directory
            # The directory name will be the same as the jar file name without the extension
            # For example: plugin-1.0.jar -> plugin-1.0
            echo "Creating directory for ${plugin}"
            mkdir -p "${plugin%.*}"
            mv "${plugin}" "${plugin%.*}/"
        fi
    done

    cd -

    echo "Creating zip file ${key}.zip"
    python3 -m zipfile "${key}.zip" "${dir}"

    echo "Cleaning up"
    rm -rf "${dir}"

    echo "All DONE!"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
