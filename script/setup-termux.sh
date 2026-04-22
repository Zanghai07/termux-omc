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

info "oh-my-china Termux Setup"
echo ""

# Step 1: Update packages
info "Updating Termux packages..."
pkg update -y && pkg upgrade -y

# Step 2: Install base dependencies
info "Installing base dependencies..."
pkg install -y git curl clang make python tmux

# Step 3: Install glibc support (required for Bun)
info "Installing glibc support for Bun..."
pkg install -y glibc-repo glibc-runner

# Step 4: Install Bun via bun-termux
if command -v bun &> /dev/null; then
    info "Bun already installed: $(bun --version)"
else
    info "Installing Bun via bun-termux..."
    TEMP_DIR=$(mktemp -d)
    git clone https://github.com/Happ1ness-dev/bun-termux.git "$TEMP_DIR/bun-termux"
    cd "$TEMP_DIR/bun-termux"
    make && make install
    cd -
    rm -rf "$TEMP_DIR"

    if command -v bun &> /dev/null; then
        info "Bun installed: $(bun --version)"
    else
        error "Bun installation failed. Try manual install: https://github.com/Happ1ness-dev/bun-termux"
    fi
fi

# Step 5: Install OpenCode
if command -v opencode &> /dev/null; then
    info "OpenCode already installed: $(opencode --version 2>/dev/null || echo 'unknown')"
else
    info "Installing OpenCode..."
    bun install -g opencode || npm install -g opencode 2>/dev/null || warn "OpenCode install failed - install manually"
fi

# Step 6: Install oh-my-china
info "Installing oh-my-china..."
bun install -g oh-my-china || npm install -g oh-my-china 2>/dev/null || {
    warn "Global install failed, trying from source..."
    if [ -f "package.json" ] && grep -q "oh-my-china" package.json; then
        bun install
        bun run build
        bun link
        info "Installed from source via bun link"
    else
        error "Could not install oh-my-china. Clone the repo and run: bun install && bun run build && bun link"
    fi
}

# Step 7: Install optional tools
info "Installing optional tools..."
pkg install -y imagemagick 2>/dev/null || warn "imagemagick not available"
pkg install -y termux-api 2>/dev/null || warn "termux-api not available (notifications won't work)"
pkg install -y ripgrep 2>/dev/null || warn "ripgrep not available (will be downloaded automatically)"

# Step 8: Configure OpenCode plugin
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
