#!/data/data/com.termux/files/usr/bin/bash
# setup-termux.sh - Install oh-my-china on Termux
# Usage: bash setup-termux.sh

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

info()  { echo -e "${GREEN}[*]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[x]${NC} $1"; exit 1; }
debug() { echo -e "${CYAN}[>]${NC} $1"; }

if [ -z "$TERMUX_VERSION" ]; then
    error "This script must be run inside Termux."
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
export PATH="$BUN_INSTALL/bin:$PATH"

verify_bun_works() {
    if "$BUN_INSTALL/bin/bun" --version &> /dev/null; then
        return 0
    fi
    return 1
}

info "oh-my-china Termux Setup"
echo ""

info "Updating Termux packages..."
pkg update -y && pkg upgrade -y

info "Installing base dependencies..."
pkg install -y git curl clang make python tmux

info "Installing glibc support (required for Bun)..."
pkg install -y glibc-repo glibc-runner

if verify_bun_works; then
    info "Bun already working: $("$BUN_INSTALL/bin/bun" --version)"
else
    info "Setting up Bun for Termux..."

    # Step A: Download raw Bun binary
    if [ -f "$BUN_INSTALL/bin/buno" ]; then
        debug "Original bun binary (buno) already exists, skipping download"
    elif [ -f "$BUN_INSTALL/bin/bun" ]; then
        debug "Raw bun binary exists at $BUN_INSTALL/bin/bun"
    else
        info "Downloading Bun binary..."
        touch ~/.bashrc
        curl -fsSL https://bun.sh/install | bash || true
        [ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"
    fi

    if [ ! -f "$BUN_INSTALL/bin/bun" ] && [ ! -f "$BUN_INSTALL/bin/buno" ]; then
        error "Bun binary not found at $BUN_INSTALL/bin/. Download failed - check internet connection."
    fi

    # Step B: Build and install bun-termux wrapper
    info "Building bun-termux wrapper..."
    TEMP_DIR=$(mktemp -d)
    git clone --depth 1 https://github.com/Happ1ness-dev/bun-termux.git "$TEMP_DIR/bun-termux"
    cd "$TEMP_DIR/bun-termux"

    debug "Running make..."
    if ! make; then
        cd "$PROJECT_DIR"
        rm -rf "$TEMP_DIR"
        error "bun-termux build failed. Check that clang and glibc-repo are installed: pkg install clang glibc-repo"
    fi

    debug "Running make install (BUN_INSTALL=$BUN_INSTALL)..."
    if ! make install; then
        cd "$PROJECT_DIR"
        rm -rf "$TEMP_DIR"
        error "bun-termux install failed. Check: https://github.com/Happ1ness-dev/bun-termux/blob/main/docs/troubleshooting.md"
    fi

    cd "$PROJECT_DIR"
    rm -rf "$TEMP_DIR"

    # Step C: Verify wrapper works
    debug "Verifying: $BUN_INSTALL/bin/bun exists=$([ -f $BUN_INSTALL/bin/bun ] && echo yes || echo no)"
    debug "Verifying: $BUN_INSTALL/bin/buno exists=$([ -f $BUN_INSTALL/bin/buno ] && echo yes || echo no)"
    debug "Verifying: $BUN_INSTALL/lib/bun-shim.so exists=$([ -f $BUN_INSTALL/lib/bun-shim.so ] && echo yes || echo no)"

    if verify_bun_works; then
        info "Bun ready: $("$BUN_INSTALL/bin/bun" --version)"
    else
        echo ""
        warn "bun-termux wrapper installed but bun still can't execute."
        warn "Diagnostics:"
        debug "  file bun:  $(file "$BUN_INSTALL/bin/bun" 2>&1)"
        debug "  file buno: $(file "$BUN_INSTALL/bin/buno" 2>&1)"
        debug "  glibc lib: $(ls "$PREFIX/glibc/lib/ld-linux-aarch64.so.1" 2>&1 || echo 'NOT FOUND')"
        echo ""
        error "Bun cannot execute. Try running manually: https://github.com/Happ1ness-dev/bun-termux#quick-start"
    fi
fi

info "Installing oh-my-china from source..."
cd "$PROJECT_DIR"

if [ ! -f "package.json" ] || ! grep -q "oh-my-china" package.json 2>/dev/null; then
    error "Not in oh-my-china project root. Run from the cloned repo: cd oh-my-china && bash script/setup-termux.sh"
fi

BUN_OPTIONS="--os=android" bun install || bun install
bun run build
bun link
info "oh-my-china installed via bun link"

info "Installing optional tools..."
pkg install -y imagemagick 2>/dev/null || warn "imagemagick not available"
pkg install -y termux-api 2>/dev/null || warn "termux-api not available (notifications won't work)"
pkg install -y ripgrep 2>/dev/null || warn "ripgrep not available (will be downloaded automatically)"

OPENCODE_CONFIG_DIR="$HOME/.config/opencode"
OPENCODE_CONFIG="$OPENCODE_CONFIG_DIR/opencode.json"

if [ -f "$OPENCODE_CONFIG" ]; then
    if grep -q "oh-my-china" "$OPENCODE_CONFIG"; then
        info "oh-my-china already configured in opencode.json"
    else
        warn "opencode.json exists but oh-my-china not configured."
        warn "Add \"oh-my-china\" to the plugin array in: $OPENCODE_CONFIG"
    fi
else
    info "Creating OpenCode config..."
    mkdir -p "$OPENCODE_CONFIG_DIR"
    cat > "$OPENCODE_CONFIG" << 'CONF'
{
  "plugin": ["oh-my-china"]
}
CONF
    info "Created $OPENCODE_CONFIG"
fi

echo ""
info "Setup complete!"
echo ""
echo "  Next steps:"
echo "  1. Configure your AI provider in $OPENCODE_CONFIG"
echo "  2. Run: opencode"
echo "  3. Type 'ultrawork' to activate all agents"
echo ""
echo "  Example provider config:"
echo '  {'
echo '    "provider": {'
echo '      "your-proxy": {'
echo '        "type": "openai",'
echo '        "url": "http://your-proxy:port/v1",'
echo '        "key": "your-api-key"'
echo '      }'
echo '    },'
echo '    "plugin": ["oh-my-china"]'
echo '  }'
echo ""
echo "  If bun is not found in new terminal sessions, add to ~/.bashrc:"
echo '  export BUN_INSTALL="$HOME/.bun"'
echo '  export PATH="$BUN_INSTALL/bin:$PATH"'
echo ""
