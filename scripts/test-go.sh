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
# It runs the tests through gotestsum rather than `go test` directly. That buys
# two things: readable output, and a JUnit XML report -- the only format
# Codecov's test analytics accepts, and something `go test` cannot emit.
#
# All three outputs land in the repository root, are gitignored, and are
# removed by `make clean`: the coverage profile, an HTML rendering of it for
# reading locally, and the JUnit report.
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

# Everything after `--` is handed to `go test`. -covermode=atomic rather than
# the default `set`: it is what Codecov expects, and the only mode that stays
# correct under -race.
womo::log::info "Running tests"
go run "${GOTESTSUM}" \
  --format testname \
  --junitfile "${JUNIT_FILE}" \
  -- -race -covermode=atomic -coverprofile="${COVERAGE_FILE}" ./...

# An annotated, line-by-line view of what the tests actually reached. Open it
# in a browser; the profile itself is only useful to machines.
go tool cover -html="${COVERAGE_FILE}" -o "${COVERAGE_HTML}"

womo::log::info "Wrote ${COVERAGE_FILE}, ${COVERAGE_HTML} and ${JUNIT_FILE}"
go tool cover -func="${COVERAGE_FILE}" | tail -1
