#!/data/data/com.termux/files/usr/bin/bash
# setup-termux.sh - Install oh-my-china on Termux
# Usage: bash setup-termux.sh

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[*]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[x]${NC} $1"; exit 1; }

if [ -z "$TERMUX_VERSION" ]; then
    error "This script must be run inside Termux."
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

info "oh-my-china Termux Setup"
echo ""

info "Updating Termux packages..."
pkg update -y && pkg upgrade -y

info "Installing base dependencies..."
pkg install -y git curl clang make python tmux

info "Installing glibc support (required for Bun)..."
pkg install -y glibc-repo glibc-runner

if command -v bun &> /dev/null; then
    info "Bun already installed: $(bun --version 2>/dev/null || echo 'wrapper present')"
else
    info "Installing Bun + bun-termux wrapper..."

    touch ~/.bashrc

    curl -fsSL https://bun.sh/install | bash || true

    if [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc"
    fi
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"

    if [ ! -f "$BUN_INSTALL/bin/bun" ]; then
        error "Bun install failed. The raw binary was not downloaded. Check your internet connection."
    fi

    info "Installing bun-termux wrapper (glibc-runner bridge)..."
    TEMP_DIR=$(mktemp -d)
    git clone https://github.com/Happ1ness-dev/bun-termux.git "$TEMP_DIR/bun-termux"
    cd "$TEMP_DIR/bun-termux"
    make && make install
    cd "$PROJECT_DIR"
    rm -rf "$TEMP_DIR"

    if [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc"
    fi

    if bun --version &> /dev/null; then
        info "Bun ready: $(bun --version)"
    else
        error "bun-termux wrapper install failed. See: https://github.com/Happ1ness-dev/bun-termux"
    fi
fi

export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
export PATH="$BUN_INSTALL/bin:$PATH"

info "Installing oh-my-china from source..."
cd "$PROJECT_DIR"

if [ ! -f "package.json" ] || ! grep -q "oh-my-china" package.json 2>/dev/null; then
    error "Not in oh-my-china project root. Run this script from the cloned repo: bash script/setup-termux.sh"
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
