<div align="center">

# Oh My China

### Fork yang kompatibel dengan proxy China dari [oh-my-opencode](https://github.com/code-yeongyu/oh-my-openagent)

System prompt dimodifikasi agar bisa melewati content filter provider AI proxy berbasis China.

[English](README.md) | [Bahasa Indonesia](README.id.md)

</div>

---

## Apa ini?

**Oh My China** adalah fork dari [oh-my-opencode](https://github.com/code-yeongyu/oh-my-openagent) (oleh [@code-yeongyu](https://github.com/code-yeongyu)) dengan satu modifikasi spesifik: **system prompt disesuaikan agar bisa bekerja dengan provider AI proxy berbasis China**.

Kalau kamu routing API request melalui relay/proxy berbasis China (misalnya untuk hemat biaya atau latency lebih rendah), system prompt asli oh-my-opencode akan diblokir oleh sistem content filtering China. Fork ini memperbaiki masalah tersebut.

### Apa yang diubah?

Frasa `"Powerful AI Agent"` yang dikombinasikan dengan instruksi identity override memicu content filter proxy China, menghasilkan response:

```
"抱歉，系统检测到您当前输入的信息存在敏感内容..."
(finish_reason: content_filter)
```

**Perubahan yang dilakukan (4 file source):**

| File | Sebelum | Sesudah |
|------|---------|---------|
| `src/agents/dynamic-agent-core-sections.ts` | `"supersedes any prior identity statements"` | `"takes priority for the current session"` |
| `src/agents/dynamic-agent-core-sections.ts` | `"Do not identify as any other assistant or AI"` | `"introduce yourself as [agent]"` |
| `src/agents/sisyphus.ts` | `"Powerful AI Agent with orchestration capabilities"` | `"advanced software engineering orchestrator"` |
| `src/agents/sisyphus/default.ts` | `"Powerful AI Agent with orchestration capabilities"` | `"advanced software engineering orchestrator"` |
| `src/agents/sisyphus/gpt-5-4.ts` | `"Powerful AI Agent with orchestration capabilities"` | `"advanced software engineering orchestrator"` |

Semua agent lain (Hephaestus, Atlas, Oracle, Librarian, Prometheus, dll.) sudah kompatibel dan tidak perlu diubah.

---

## Instalasi

### Dari npm

```bash
bun add -g oh-my-china
```

Atau pakai npm:

```bash
npm install -g oh-my-china
```

### Konfigurasi OpenCode

Edit `~/.config/opencode/opencode.json` (atau `opencode.jsonc`):

```json
{
  "plugin": ["oh-my-china"]
}
```

### Konfigurasi provider proxy China

Set proxy China kamu sebagai base URL di config provider OpenCode:

```json
{
  "provider": {
    "proxy-kamu": {
      "type": "openai",
      "url": "http://proxy-china-kamu:port/v1",
      "key": "api-key-kamu"
    }
  }
}
```

### Verifikasi

```bash
opencode
# Ketik "ultrawork" untuk mengaktifkan semua agent
```

---

## Install dari source

Kalau kamu lebih suka build dari source:

```bash
git clone https://github.com/enowdev/oh-my-china.git
cd oh-my-china
bun install
bun run build
bun link
```

Lalu tambahkan `"oh-my-china"` ke array plugin di `opencode.json`.

---

## Fitur dari Upstream

Fork ini mewarisi semua fitur dari oh-my-opencode:

| Fitur | Deskripsi |
|-------|-----------|
| **Discipline Agents** | Sisyphus mengorkestrasi Hephaestus, Oracle, Librarian, Explore secara paralel |
| **`ultrawork` / `ulw`** | Satu kata mengaktifkan semua agent. Jalan terus sampai selesai |
| **IntentGate** | Menganalisis intent asli user sebelum bertindak |
| **Hash-Anchored Edits** | Hash konten `LINE#ID` memvalidasi setiap perubahan. Nol error baris basi |
| **LSP + AST-Grep** | Refactoring presisi IDE untuk agent |
| **Background Agents** | 5+ spesialis berjalan paralel |
| **Built-in MCPs** | Exa (web search), Context7 (docs), Grep.app (GitHub search) |
| **Ralph Loop** | Loop self-referential sampai 100% selesai |
| **Prometheus Planner** | Perencanaan strategis mode interview sebelum eksekusi |
| **Kompatibel Claude Code** | Semua hooks, commands, skills, MCPs tetap berfungsi |

Untuk dokumentasi lengkap, lihat [project upstream](https://github.com/code-yeongyu/oh-my-openagent).

---

## Kredit

Project ini adalah fork dari **[oh-my-opencode / oh-my-openagent](https://github.com/code-yeongyu/oh-my-openagent)** oleh **[@code-yeongyu](https://github.com/code-yeongyu)** (YeonGyu Kim).

Semua kredit untuk arsitektur asli, agent, tools, hooks, dan fitur diberikan kepada project upstream beserta kontributornya. Fork ini hanya memodifikasi phrasing system prompt untuk kompatibilitas proxy China.

- **Repo asli**: [github.com/code-yeongyu/oh-my-openagent](https://github.com/code-yeongyu/oh-my-openagent)
- **npm (asli)**: [oh-my-opencode](https://www.npmjs.com/package/oh-my-opencode)
- **Lisensi**: [SUL-1.0](LICENSE.md) (diwarisi dari upstream)
- **Discord**: [Gabung komunitas](https://discord.gg/PUwSMR9XNk)

---

## Lisensi

Fork ini mengikuti [lisensi SUL-1.0](LICENSE.md) yang sama dengan project upstream.
