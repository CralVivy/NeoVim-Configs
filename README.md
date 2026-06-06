<div align="center">

# 🌲 CedarVim

**A high-performance, modular Neovim configuration engineered for stability and speed.**

[![Neovim](https://img.shields.io/badge/Neovim-v0.10+-blue?logo=neovim&logoColor=white)](https://neovim.io)
[![Language](https://img.shields.io/badge/Language-Lua-blue?logo=lua)](https://www.lua.org)
[![Engine](https://img.shields.io/badge/Engine-Rust--Powered-orange?logo=rust)](https://www.rust-lang.org)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE.md)

---

**Modular • Unified • Low-Latency • Rigorous**

</div>

## 📖 Overview

CedarVim is an evolution of the Kickstart.nvim philosophy, optimized for developers who require a professional-grade environment without the bloat. It implements a **Unification Strategy**, consolidating redundant plugins into single, high-performance engines to reduce cognitive load and system memory overhead.

---

## 🛠 Technical Capabilities

### ⚡ Performance & Navigation
| Feature | Implementation | Technical Advantage |
| :--- | :--- | :--- |
| **Unified Picking** | `snacks.nvim` | Single Rust-powered engine for files, grep, and LSP. |
| **Instant Completion** | `blink.cmp` | Asynchronous Rust completion for sub-millisecond latency. |
| **Project Switching** | `workspaces.nvim` | Rapid directory context switching for multi-repo workflows. |

### 🧠 Intelligence & LSP
- **Orchestration**: `mason.nvim` & `nvim-lspconfig` for standardized server management.
- **AI Pairing**: `CodeCompanion` for LLM-integrated chat and inline refactoring.
- **Copilot**: Native `blink.cmp` integration for high-performance ghost-text.
- **Java Stack**: Specialized `jdtls` configuration for enterprise-scale Java development.
- **Debugging**: Full DAP implementation for Java, Go, Python, Rust, and C/C++.

### 🎨 Interface & UI
- **Dynamic Theme**: `pywal.nvim` integration for system-wide color synchronization.
- **Visual Scope**: `indent-blankline.nvim` for precise indentation and scope tracking.
- **Workspace UI**: `lualine.nvim` and `bufferline.nvim` for a minimal, information-dense interface.

---

## 📂 Architecture

The configuration utilizes a strict separation of concerns to ensure stability and ease of maintenance.

```text
.
├── init.lua                # Boot sequence, options, and plugin registry
├── lua/
│   ├── custom/             # The core logic layer
│   │   ├── configs/        # Granular plugin settings
│   │   ├── plugins/        # Modular plugin specifications
│   │   ├── snacks/         # Unified picker configurations
│   │   ├── ui/             # UI components and assets
│   │   └── utils/          # Shared helper functions
│   └── kickstart/          # Base foundational components
└── doc/                    # Technical reference (Git-ignored)
```

---

## 📦 Installation

### Prerequisites
- **Neovim**: `v0.10.0+`
- **Font**: [Nerd Font](https://www.nerdfonts.com/)
- **CLI Tools**: `ripgrep`, `fd`, `npm`

### Setup
1. **Clone the repository**:
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```
2. **Initialization**:
   Launch Neovim. `lazy.nvim` will automatically bootstrap and install all dependencies.
3. **Sync**:
   Run `:Lazy update` to synchronize the latest plugin versions.

---

## 📖 Documentation

Detailed technical references are maintained in the `doc/` directory:

- **[Keybindings Guide](doc/keybinds.md)**: Comprehensive mapping and shortcut reference.
- **[Technical Audit](doc/AUDIT-Rigorous.md)**: Deep-dive analysis of the system architecture.
- **[Implementation Walkthrough](doc/walkthrough.md)**: History of optimizations and migrations.
