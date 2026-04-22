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

## Install di Termux (Android)

Panduan lengkap dari nol untuk yang baru install Termux.

### Prasyarat

- [Termux](https://f-droid.org/en/packages/com.termux/) dari F-Droid (jangan dari Play Store - versi Play Store outdated)
- [OpenCode untuk Termux](https://github.com/Hope2333/opencode-termux) sudah terinstall dan bisa jalan

### Step 1: Update dan install dependencies

Buka Termux, lalu jalankan satu per satu:

```bash
pkg update -y && pkg upgrade -y
pkg install -y git curl clang make python tmux
pkg install -y glibc-repo glibc-runner
```

### Step 2: Install Bun

Bun belum officially support Android. Kita perlu install binary dulu, lalu pasang wrapper supaya bisa jalan.

```bash
touch ~/.bashrc
curl -fsSL https://bun.sh/install | bash
source ~/.bashrc
```

Verifikasi Bun terdownload (belum bisa dijalankan):

```bash
ls ~/.bun/bin/bun
```

### Step 3: Install bun-termux wrapper

Wrapper ini bikin Bun bisa jalan di Android lewat glibc dynamic linker.

```bash
git clone https://github.com/Happ1ness-dev/bun-termux.git ~/bun-termux
cd ~/bun-termux
make && make install
```

Verifikasi Bun bisa jalan:

```bash
bun --version
```

Kalau muncul nomor versi (misal `1.3.13`), lanjut ke step berikutnya.

### Step 4: Clone dan build oh-my-china

```bash
cd ~
git clone https://github.com/enowdev/oh-my-china.git
cd oh-my-china
BUN_OPTIONS="--os=android" bun install
bun run build
```

### Step 5: Register plugin ke OpenCode

```bash
opencode plugin ~/oh-my-china
```

### Step 6: Enable plugin di OpenCode

OpenCode versi Termux (Hope2333) disable plugin secara default. Kita perlu enable:

```bash
sed -i 's/OPENCODE_DISABLE_DEFAULT_PLUGINS:=1/OPENCODE_DISABLE_DEFAULT_PLUGINS:=0/' $(which opencode)
```

### Step 7: Konfigurasi provider

Edit `~/.config/opencode/opencode.json` dan tambahkan provider kamu:

```json
{
  "provider": {
    "nama-provider": {
      "name": "Provider Kamu",
      "npm": "@ai-sdk/openai-compatible",
      "options": {
        "apiKey": "api-key-kamu",
        "baseURL": "https://api-provider-kamu/v1"
      }
    }
  }
}
```

### Step 8: Jalankan

```bash
opencode
```

Kalau berhasil, agent di OpenCode akan berubah dari "build" menjadi "Xi Jinping".

### Tools Opsional

```bash
pkg install -y imagemagick    # Konversi gambar
pkg install -y termux-api     # Notifikasi native Android
pkg install -y ripgrep        # Pencarian cepat (auto-download jika tidak ada)
```

### Troubleshooting Termux

| Masalah | Solusi |
|---------|--------|
| `required file not found` saat jalankan `bun` | Wrapper bun-termux belum terinstall. Jalankan: `cd ~/bun-termux && make && make install` |
| `bun: command not found` | Tambah ke `~/.bashrc`: `export PATH="$HOME/.bun/bin:$PATH"` lalu `source ~/.bashrc` |
| `npm error notsup Unsupported platform` | Normal di Termux. Install dari source, jangan pakai `bun install -g` |
| Native module error saat `bun install` | Pakai: `BUN_OPTIONS="--os=android" bun install` |
| `Failed to get CPU information` saat load plugin | Pastikan pakai versi oh-my-china terbaru yang sudah di-patch untuk Termux |
| Plugin tidak ke-load (agent masih "build") | Pastikan sudah jalankan `sed` di Step 6 untuk enable plugin |
| `SIGILL` saat jalankan binary | Coba: `export OH_MY_OPENCODE_FORCE_BASELINE=1` |
| Notifikasi tidak muncul | Install Termux:API app dari F-Droid + `pkg install termux-api` |
| tmux error | `pkg install tmux` dan restart Termux |
| Permission denied / sudo | Termux tidak pakai sudo. Gunakan `pkg install` bukan `apt install` |

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
