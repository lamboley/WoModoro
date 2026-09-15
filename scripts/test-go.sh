#!/usr/bin/env bash

# Copyright (c) 2026 Lucas Lamboley.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This script runs the Go test suite, writing a coverage profile and a JUnit
# report.
#
# Usage:
#   scripts/test-go.sh

set -euo pipefail

WOMOROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd -P)"
source "${WOMOROOT}/scripts/lib/init.sh"

cd "${WOMOROOT}"

COVERAGE_FILE="coverage.txt"
COVERAGE_HTML="coverage.html"
JUNIT_FILE="junit.xml"
GOTESTSUM="gotest.tools/gotestsum@v1.13.0"

womo::log::info "Running tests"
go run "${GOTESTSUM}" \
  --format testname \
  --junitfile "${JUNIT_FILE}" \
  -- -race -covermode=atomic -coverprofile="${COVERAGE_FILE}" ./...

go tool cover -html="${COVERAGE_FILE}" -o "${COVERAGE_HTML}"

womo::log::info "Wrote ${COVERAGE_FILE}, ${COVERAGE_HTML} and ${JUNIT_FILE}"
go tool cover -func="${COVERAGE_FILE}" | tail -1
