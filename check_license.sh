#!/bin/bash

set -eo pipefail

run_update_license() {
  # doing this because of SC2046 warning
  for file in $(git ls-files | grep '\.go$'); do
    update-license $@ "${file}"
  done
}

if [ -z "${DRY_RUN}" ]; then
  run_update_license
else
  DRY_OUTPUT="$(run_update_license --dry)"
  if [ -n "${DRY_OUTPUT}" ]; then
    echo "The following files do not have correct license headers."
    echo "Please run make license and amend your commit."
    echo
    echo "${DRY_OUTPUT}"
    exit 1
  fi
fi
