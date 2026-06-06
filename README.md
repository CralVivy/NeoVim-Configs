# CedarVim

**A high-performance, modular Neovim configuration evolved from Kickstart.nvim.**

CedarVim is engineered for speed and stability, utilizing a "Unification" strategy to reduce cognitive load and system overhead. By replacing legacy Lua implementations with Rust-powered alternatives and maintaining a strict separation of concerns, it provides a lean, professional development environment.

---

## 🛠 Technical Stack

### ⚡ Performance & Navigation
| Component | Tool | Purpose |
| :--- | :--- | :--- |
| **Fuzzy Finder** | `snacks.nvim` | Unified engine for files, grep, buffers, and LSP navigation. |
| **Completion** | `blink.cmp` | Rust-based completion engine for near-zero latency. |
| **Workspaces** | `workspaces.nvim` | Rapid project switching and directory management. |

### 🧠 Intelligence & LSP
- **LSP Management**: `mason.nvim` & `nvim-lspconfig` for standardized server orchestration.
- **AI Integration**: `CodeCompanion` for LLM-based chat and inline refactoring.
- **Copilot**: Integrated via `blink.cmp` for high-performance ghost-text suggestions.
- **Java Specialization**: Deep integration with `jdtls` for enterprise Java development.
- **Debugging**: Full DAP support for Java, Go, Python, Rust, and C/C++.

### 🎨 Interface & UI
- **Theme System**: Custom persistence layer with `pywal.nvim` for system-wide color harmony.
- **Visual Scope**: `indent-blankline.nvim` for structural indentation highlighting.
- **Status & UI**: `lualine.nvim` and `bufferline.nvim` for a clean, informative workspace.

---

## 📂 Configuration Structure

The configuration follows a modular architecture to ensure that the core boot process remains lightweight while allowing for extensive customization.

```text
.
├── init.lua                # Entry point & plugin registry
├── lua/
│   ├── custom/             # User-specific extensions
│   │   ├── configs/        # Plugin-specific configuration
│   │   ├── plugins/        # Modular plugin specifications
│   │   ├── snacks/         # Unified picker logic
│   │   ├── ui/             # UI assets
│   │   └── utils/          # Shared helper functions
│   └── kickstart/          # Core base components
└── doc/                    # Technical documentation (ignored by git)
```

---

## 📦 Installation

### Requirements
- **Neovim**: `v0.10.0+`
- **Font**: [Nerd Font](https://www.nerdfonts.com/)
- **CLI Tools**: `ripgrep`, `fd`, `npm`, `cargo` (optional)

### Setup
1. **Clone the repository**:
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```
2. **Launch Neovim**:
   `lazy.nvim` will automatically install all plugins on the first run.
3. **Update**:
   Run `:Lazy update` to ensure all plugins are current.

---

## 📖 Documentation

Detailed references are maintained in the `doc/` directory:

- **[Keybindings Guide](doc/keybinds.md)**: Complete list of all shortcuts and mappings.
- **[Technical Audit](doc/AUDIT-Rigorous.md)**: Deep-dive analysis of the system architecture.
- **[Implementation Walkthrough](doc/walkthrough.md)**: History of optimizations and changes.
