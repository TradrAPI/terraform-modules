#!/usr/bin/env bash

main() {
    local key="$1"
    local urls="$2"

    mkdir plugins
    cd plugins

    for url in ${urls//,/ }; do
        plugin=$(basename "${url}")
        curl -o "${plugin}" -LO "${url}"
        unzip -o "${plugin}"
    done

    cd -
    
    zip -r "${key}.zip" plugins
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
