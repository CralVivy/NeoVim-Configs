# CedarVim

A modular Neovim configuration evolved from Kickstart.nvim, optimized for performance through the integration of Rust-based plugins and a strict separation of concerns.

---

## 🛠 Technical Stack

### Navigation & Search
- **Snacks.nvim**: Acts as the primary engine for all picking and searching. Replaces Telescope for file finding, grep, buffer management, and LSP navigation to reduce memory overhead and increase response speed.
- **Workspaces.nvim**: Provides rapid project switching and directory management.

### Completion & Intelligence
- **Blink.cmp**: A Rust-powered completion engine replacing `nvim-cmp` for lower latency.
- **Copilot.lua**: Integrated via `blink.cmp` for AI-powered ghost-text suggestions.
- **CodeCompanion**: Provides a dedicated interface for LLM-based chat, inline refactoring, and code reviews.

### LSP & Development
- **Mason.nvim**: Centralized management for LSP servers, linters, and formatters.
- **nvim-lspconfig**: Standardized LSP configurations with optimized inlay hints.
- **JDTLS**: Specialized integration for Java development, including import organization and variable extraction.
- **nvim-dap**: Full Debug Adapter Protocol support for Java, Go, Python, Rust, and C/C++.

### UI & Aesthetics
- **Indent-blankline.nvim**: Provides scope-aware indentation highlighting.
- **Pywal.nvim**: Dynamic colorscheme integration based on system colors.
- **Custom Theme Switcher**: A persistence system that remembers and restores the chosen theme across sessions.

---

## 📂 Configuration Structure

The configuration is split between the core boot process and a modular custom directory:

```text
.
├── init.lua                # Entry point, basic options, and plugin registry
├── lua/
│   ├── custom/             # User-specific extensions
│   │   ├── configs/        # Detailed plugin settings
│   │   ├── plugins/        # Modular plugin specs
│   │   ├── snacks/         # Unified picker configurations
│   │   ├── ui/             # UI assets
│   │   └── utils/          # Shared helper functions
│   └── kickstart/          # Core Kickstart components
└── doc/                    # Technical documentation
    ├── keybinds.md         # Full mapping reference
    ├── AUDIT-Rigorous.md   # Technical system analysis
    └── walkthrough.md      # Change log and implementation history
```

---

## 📦 Installation & Dependencies

### Requirements
- **Neovim**: `v0.10.0+`
- **Font**: [Nerd Font](https://www.nerdfonts.com/)
- **External Tools**:
  - `ripgrep` & `fd` (Search/Finding)
  - `npm` (Linter/Tooling)
  - `cargo` (Optional, for plugin builds)

### Setup
1. Clone this repository into `~/.config/nvim`.
2. Launch Neovim; `lazy.nvim` will automatically install all plugins.
3. Run `:Lazy update` to ensure all versions are current.

---

## 📖 Documentation

- **Keybindings**: See [doc/keybinds.md](doc/keybinds.md) for a complete list of shortcuts.
- **Architecture**: See [doc/AUDIT-Rigorous.md](doc/AUDIT-Rigorous.md) for the technical audit and system logic.
