#!/usr/bin/env bash
set -euo pipefail

# Install build deps + Rust if missing
sudo apt-get update
sudo apt-get install -y build-essential pkg-config libssl-dev cmake git curl
if ! command -v cargo >/dev/null 2>&1; then
  echo "Installing Rust (rustup)"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

# Clone/update repo on VM and init submodule
APP_DIR="/opt/hyperhash-pool"
REPO_SSH="git@github.com:caldefenwycke/hyperhash-pool.git"

if [ ! -d "$APP_DIR/.git" ]; then
  sudo mkdir -p "$APP_DIR"
  sudo chown -R "$USER":"$USER" "$APP_DIR"
  git clone "$REPO_SSH" "$APP_DIR"
fi

cd "$APP_DIR"
git pull --rebase
git submodule update --init --recursive

# Build SV2 Pool
cd "$APP_DIR/sri/roles/pool"
cargo build --release

# Build SV1SV2 Translator Proxy
cd "$APP_DIR/sri/roles/translator"
cargo build --release

echo " Build complete."