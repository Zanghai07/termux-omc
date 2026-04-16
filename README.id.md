<div align="center">

# Oh My China

### Fork yang kompatibel dengan proxy China dari [oh-my-opencode](https://github.com/code-yeongyu/oh-my-openagent)

System prompt dimodifikasi agar bisa melewati content filter. Semua agent diganti nama jadi tokoh sejarah dan politik China.

[English](README.md) | [Bahasa Indonesia](README.id.md)

</div>

---

## Apa ini?

**Oh My China** adalah fork dari [oh-my-opencode](https://github.com/code-yeongyu/oh-my-openagent) (oleh [@code-yeongyu](https://github.com/code-yeongyu)) dengan dua modifikasi:

1. **System prompt disesuaikan** agar lolos content filter proxy China
2. **Semua agent diganti nama** jadi tokoh sejarah/politik China

### Daftar Agent

| Asli | Oh My China | Peran |
|------|-------------|-------|
| Sisyphus | **Xi Jinping** | Orkestrator utama. Memimpin kode. |
| Hephaestus | **Zhuge Liang** | Deep worker otonom. Sang ahli strategi legendaris. |
| Oracle | **Confucius** | Konsultan read-only. Kebijaksanaan tanpa aksi. |
| Librarian | **Cai Lun** | Pencari dokumentasi. Penemu kertas. |
| Explore | **Sun Wukong** | Pencari codebase. Raja Kera mengintai segalanya. |
| Atlas | **Mao Zedong** | Orkestrator todo. Sang Pengorganisir Agung. |
| Prometheus | **Laozi** | Perencana strategis. Jalan sebelum pekerjaan. |
| Metis | **Sun Tzu** | Konsultan pra-perencanaan. Seni Perang Planning. |
| Momus | **Lu Xun** | Reviewer/kritikus plan. Kritikus terbesar China. |
| Sisyphus-Junior | **Red Guard** | Eksekutor tugas. Ikut perintah. |
| Multimodal Looker | **Zheng He** | Analisis vision/PDF. Sang penjelajah agung. |

### Fix Content Filter

Frasa `"Powerful AI Agent"` dikombinasikan dengan instruksi identity override memicu content filter proxy China. Fork ini menggantinya dengan phrasing yang lebih soft.

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
| **Discipline Agents** | Xi Jinping mengorkestrasi Zhuge Liang, Confucius, Cai Lun, Sun Wukong secara paralel |
| **`ultrawork` / `ulw`** | Satu kata mengaktifkan semua agent. Jalan terus sampai selesai |
| **IntentGate** | Menganalisis intent asli user sebelum bertindak |
| **Hash-Anchored Edits** | Hash konten `LINE#ID` memvalidasi setiap perubahan |
| **LSP + AST-Grep** | Refactoring presisi IDE untuk agent |
| **Background Agents** | 5+ spesialis berjalan paralel |
| **Built-in MCPs** | Exa (web search), Context7 (docs), Grep.app (GitHub search) |
| **Ralph Loop** | Loop self-referential sampai 100% selesai |
| **Laozi Planner** | Perencanaan strategis mode interview sebelum eksekusi |
| **Kompatibel Claude Code** | Semua hooks, commands, skills, MCPs tetap berfungsi |

Untuk dokumentasi lengkap, lihat [project upstream](https://github.com/code-yeongyu/oh-my-openagent).

---

## Kredit

Project ini adalah fork dari **[oh-my-opencode / oh-my-openagent](https://github.com/code-yeongyu/oh-my-openagent)** oleh **[@code-yeongyu](https://github.com/code-yeongyu)** (YeonGyu Kim).

Semua kredit untuk arsitektur asli, agent, tools, hooks, dan fitur diberikan kepada project upstream beserta kontributornya. Fork ini memodifikasi phrasing system prompt dan nama display agent.

- **Repo asli**: [github.com/code-yeongyu/oh-my-openagent](https://github.com/code-yeongyu/oh-my-openagent)
- **npm (asli)**: [oh-my-opencode](https://www.npmjs.com/package/oh-my-opencode)
- **Lisensi**: [SUL-1.0](LICENSE.md) (diwarisi dari upstream)
- **Discord**: [Gabung komunitas](https://discord.gg/PUwSMR9XNk)

---

## Lisensi

Fork ini mengikuti [lisensi SUL-1.0](LICENSE.md) yang sama dengan project upstream.
