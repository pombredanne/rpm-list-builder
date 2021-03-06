#!/bin/bash -v

pushd "$(dirname "${0}")/.." > /dev/null
ROOT_DIR=$(pwd)
popd > /dev/null

if ! which bashate > /dev/null; then
    echo "ERROR: Install bashate." 1>&2
    exit 1
fi

FILES="$(find "${ROOT_DIR}/scripts" "${ROOT_DIR}/tests" -name "*.sh")"
STATUS=0

for FILE in ${FILES}; do
    if ! bash -n "${FILE}"; then
        STATUS=1
        echo "${FILE}: NG at sh -n"
        continue
    fi
    if ! bashate "${FILE}"; then
        STATUS=1
        echo "${FILE}: NG at bashate"
        continue
    fi
    echo "${FILE}: OK"
done

exit "${STATUS}"
