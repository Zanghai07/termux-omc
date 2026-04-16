<div align="center">

# Oh My China

### A China-compatible fork of [oh-my-opencode](https://github.com/code-yeongyu/oh-my-openagent)

Modified system prompts to pass through China-based AI proxy providers without triggering content filters.

[English](README.md) | [Bahasa Indonesia](README.id.md)

</div>

---

## What is this?

**Oh My China** is a fork of [oh-my-opencode](https://github.com/code-yeongyu/oh-my-openagent) (by [@code-yeongyu](https://github.com/code-yeongyu)) with one specific modification: **system prompts have been adjusted to work with China-based AI proxy providers**.

If you route API requests through a China-based relay/proxy (e.g., for cost savings or latency), the original oh-my-opencode system prompts get blocked by China's content filtering systems. This fork fixes that.

### What was changed?

The phrase `"Powerful AI Agent"` combined with identity override directives triggers China proxy content filters, returning:

```
"Sorry, the system detected sensitive content in your input..."
(finish_reason: content_filter)
```

**Changes made (4 source files):**

| File | Before | After |
|------|--------|-------|
| `src/agents/dynamic-agent-core-sections.ts` | `"supersedes any prior identity statements"` | `"takes priority for the current session"` |
| `src/agents/dynamic-agent-core-sections.ts` | `"Do not identify as any other assistant or AI"` | `"introduce yourself as [agent]"` |
| `src/agents/sisyphus.ts` | `"Powerful AI Agent with orchestration capabilities"` | `"advanced software engineering orchestrator"` |
| `src/agents/sisyphus/default.ts` | `"Powerful AI Agent with orchestration capabilities"` | `"advanced software engineering orchestrator"` |
| `src/agents/sisyphus/gpt-5-4.ts` | `"Powerful AI Agent with orchestration capabilities"` | `"advanced software engineering orchestrator"` |

All other agents (Hephaestus, Atlas, Oracle, Librarian, Prometheus, etc.) were already compatible and required no changes.

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

Set your China proxy as the API base URL in your OpenCode provider config:

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

If you prefer to build from source:

```bash
git clone https://github.com/enowdev/oh-my-china.git
cd oh-my-china
bun install
bun run build
bun link
```

Then add `"oh-my-china"` to your `opencode.json` plugin array.

---

## Upstream Features

This fork inherits all features from oh-my-opencode:

| Feature | Description |
|---------|-------------|
| **Discipline Agents** | Sisyphus orchestrates Hephaestus, Oracle, Librarian, Explore in parallel |
| **`ultrawork` / `ulw`** | One word activates every agent. Runs until done |
| **IntentGate** | Analyzes true user intent before acting |
| **Hash-Anchored Edits** | `LINE#ID` content hash validates every change. Zero stale-line errors |
| **LSP + AST-Grep** | IDE-precision refactoring for agents |
| **Background Agents** | 5+ specialists running in parallel |
| **Built-in MCPs** | Exa (web search), Context7 (docs), Grep.app (GitHub search) |
| **Ralph Loop** | Self-referential loop until 100% done |
| **Prometheus Planner** | Interview-mode strategic planning before execution |
| **Claude Code Compatible** | All hooks, commands, skills, MCPs work unchanged |

For full documentation, see the [upstream project](https://github.com/code-yeongyu/oh-my-openagent).

---

## Credits

This project is a fork of **[oh-my-opencode / oh-my-openagent](https://github.com/code-yeongyu/oh-my-openagent)** by **[@code-yeongyu](https://github.com/code-yeongyu)** (YeonGyu Kim).

All credit for the original architecture, agents, tools, hooks, and features goes to the upstream project and its contributors. This fork only modifies system prompt phrasing for China proxy compatibility.

- **Original repo**: [github.com/code-yeongyu/oh-my-openagent](https://github.com/code-yeongyu/oh-my-openagent)
- **npm (original)**: [oh-my-opencode](https://www.npmjs.com/package/oh-my-opencode)
- **License**: [SUL-1.0](LICENSE.md) (inherited from upstream)
- **Discord**: [Join the community](https://discord.gg/PUwSMR9XNk)

---

## License

This fork follows the same [SUL-1.0 license](LICENSE.md) as the upstream project.
