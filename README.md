<div align="center">

# Oh My China

### A China-compatible fork of [oh-my-opencode](https://github.com/code-yeongyu/oh-my-openagent)

Modified system prompts to pass through China-based AI proxy providers. All agents renamed to Chinese historical and political figures for maximum cultural immersion.

[English](README.md) | [Bahasa Indonesia](README.id.md)

</div>

---

## What is this?

**Oh My China** is a fork of [oh-my-opencode](https://github.com/code-yeongyu/oh-my-openagent) (by [@code-yeongyu](https://github.com/code-yeongyu)) with two modifications:

1. **System prompts adjusted** to pass through China-based AI proxy content filters
2. **All agents renamed** to Chinese historical/political figures

### Agent Roster

| Original | Oh My China | Role |
|----------|-------------|------|
| Sisyphus | **Xi Jinping** | Main orchestrator. Leads the code. |
| Hephaestus | **Zhuge Liang** | Autonomous deep worker. The legendary strategist. |
| Oracle | **Confucius** | Read-only consultant. Wisdom without action. |
| Librarian | **Cai Lun** | External docs search. Inventor of paper. |
| Explore | **Sun Wukong** | Codebase search. The Monkey King scouts everything. |
| Atlas | **Mao Zedong** | Todo orchestrator. The Great Organizer. |
| Prometheus | **Laozi** | Strategic planner. The Way before the work. |
| Metis | **Sun Tzu** | Pre-planning consultant. The Art of War Planning. |
| Momus | **Lu Xun** | Plan reviewer/critic. China's greatest critic. |
| Sisyphus-Junior | **Red Guard** | Task executor. Follows orders. |
| Multimodal Looker | **Zheng He** | Vision/PDF analysis. The great explorer. |

### Content Filter Fix

The phrase `"Powerful AI Agent"` combined with identity override directives triggers China proxy content filters. This fork replaces it with softer phrasing that passes through.

---

## Installation

### From npm

```bash
bun add -g oh-my-china
```

Or with npm:

```bash
npm install -g oh-my-china
```

### Configure OpenCode

Edit `~/.config/opencode/opencode.json` (or `opencode.jsonc`):

```json
{
  "plugin": ["oh-my-china"]
}
```

### Configure your China proxy provider

```json
{
  "provider": {
    "your-proxy": {
      "type": "openai",
      "url": "http://your-china-proxy:port/v1",
      "key": "your-api-key"
    }
  }
}
```

### Verify

```bash
opencode
# Type "ultrawork" to activate all agents
```

---

## Install from source

```bash
git clone https://github.com/Zanghai07/termux-omc.git
cd termux-omc
bun install
bun run build
bun link
```

Then add `"oh-my-china"` to your `opencode.json` plugin array.

---

## Install on Termux (Android)

Complete guide from scratch. Requires [Termux](https://f-droid.org/en/packages/com.termux/) from F-Droid and [OpenCode for Termux](https://github.com/Hope2333/opencode-termux).

```bash
# 1. Install dependencies
pkg update -y && pkg upgrade -y
pkg install -y git curl clang make python tmux glibc-repo glibc-runner

# 2. Install Bun
touch ~/.bashrc
curl -fsSL https://bun.sh/install | bash
source ~/.bashrc

# 3. Install bun-termux wrapper (makes Bun work on Android)
git clone https://github.com/Happ1ness-dev/bun-termux.git ~/bun-termux
cd ~/bun-termux && make && make install
bun --version  # should print version number

# 4. Build oh-my-china
cd ~
git clone https://github.com/Zanghai07/termux-omc.git
cd termux-omc
BUN_OPTIONS="--os=android" bun install
bun run build

# 5. Register plugin
opencode plugin ~/termux-omc

# 6. Enable plugins (disabled by default in Termux OpenCode)
sed -i 's/OPENCODE_DISABLE_DEFAULT_PLUGINS:=1/OPENCODE_DISABLE_DEFAULT_PLUGINS:=0/' $(which opencode)

# 7. Download the opencode.json from the release menu
rm ~/.config/opencode/opencode.json
cp /path/to/opencode.json ~/.config/opencode
(dont forget to replace the api key to your own enowx api key)

# 8. Run
opencode
```

See [README.id.md](README.id.md) for detailed step-by-step guide and troubleshooting.

---

## Upstream Features

This fork inherits all features from oh-my-opencode:

| Feature | Description |
|---------|-------------|
| **Discipline Agents** | Xi Jinping orchestrates Zhuge Liang, Confucius, Cai Lun, Sun Wukong in parallel |
| **`ultrawork` / `ulw`** | One word activates every agent. Runs until done |
| **IntentGate** | Analyzes true user intent before acting |
| **Hash-Anchored Edits** | `LINE#ID` content hash validates every change. Zero stale-line errors |
| **LSP + AST-Grep** | IDE-precision refactoring for agents |
| **Background Agents** | 5+ specialists running in parallel |
| **Built-in MCPs** | Exa (web search), Context7 (docs), Grep.app (GitHub search) |
| **Ralph Loop** | Self-referential loop until 100% done |
| **Laozi Planner** | Interview-mode strategic planning before execution |
| **Claude Code Compatible** | All hooks, commands, skills, MCPs work unchanged |

For full documentation, see the [upstream project](https://github.com/code-yeongyu/oh-my-openagent).

---

## Credits

This project is a fork of **[oh-my-opencode / oh-my-openagent](https://github.com/code-yeongyu/oh-my-openagent)** by **[@code-yeongyu](https://github.com/code-yeongyu)** (YeonGyu Kim).

All credit for the original architecture, agents, tools, hooks, and features goes to the upstream project and its contributors. This fork modifies system prompt phrasing and agent display names.

- **Original repo**: [github.com/code-yeongyu/oh-my-openagent](https://github.com/code-yeongyu/oh-my-openagent)
- **npm (original)**: [oh-my-opencode](https://www.npmjs.com/package/oh-my-opencode)
- **License**: [SUL-1.0](LICENSE.md) (inherited from upstream)
- **Discord**: [Join the community](https://discord.gg/PUwSMR9XNk)

---

## License

This fork follows the same [SUL-1.0 license](LICENSE.md) as the upstream project.
