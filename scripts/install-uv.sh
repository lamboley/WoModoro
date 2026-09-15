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

# This script installs uv from its GitHub release.
#
# Usage:
#   ENV_VAR=... scripts/install-uv.sh
#
# Example:
#   Installing a specific version:
#     INSTALL_UV_VERSION=0.12.7 scripts/install-uv.sh
#   Installing in a specific directory:
#     INSTALL_UV_BIN_DIR=/opt/bin scripts/install-uv.sh
#
# Environment variables:
#   - INSTALL_UV_VERSION
#     Version of uv to download. Use 0.12.7 as the default.
#
#   - INSTALL_UV_BIN_DIR
#     Directory to install uv binary. Use ${HOME}/.local/bin as the default

set -euo pipefail

WOMOROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd -P)"
source "${WOMOROOT}/scripts/lib/init.sh"

cd "${WOMOROOT}"

function setup_env() {
  INSTALL_UV_VERSION=${INSTALL_UV_VERSION:-0.12.7}
  INSTALL_UV_BIN_DIR="${INSTALL_UV_BIN_DIR:-${HOME}/.local/bin}"
}

function download_binary() {
  local filename="uv-x86_64-unknown-linux-gnu.tar.gz"
  local base_url="https://releases.astral.sh/github/uv/releases/download"
  local url="${base_url}/${INSTALL_UV_VERSION}/${filename}"

  womo::util::ensure-temp-dir

  womo::log::info "Downloading ${url}"
  womo::util::download_from_github "${WOMO_TEMP}/${filename}" "${url}"

  tar --extract --gzip --no-same-owner --strip-components 1 \
    --file "${WOMO_TEMP}/${filename}" --directory "${WOMO_TEMP}"
}

function setup_binary() {
  womo::log::info "Installing uv to ${INSTALL_UV_BIN_DIR}/uv"
  womo::log::info "Installing uvx to ${INSTALL_UV_BIN_DIR}/uvx"
  mkdir -p "${INSTALL_UV_BIN_DIR}"
  install -m 0755 "${WOMO_TEMP}/uv" "${WOMO_TEMP}/uvx" "${INSTALL_UV_BIN_DIR}"
}

setup_env
download_binary
setup_binary
