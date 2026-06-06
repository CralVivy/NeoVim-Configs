# AUDIT-action.md: Implementation Plan (2026)

This document serves as the technical execution roadmap to resolve the issues identified in `AUDIT-Rigorous.md`. The primary goal is to move the configuration from a "Hybrid" state to a "Unified" state without altering the UI or breaking core functionality.

## 🎯 Core Objectives
1. **Unify Pickers**: Complete migration from `telescope.nvim` to `snacks.nvim` to eliminate redundancy and reduce memory footprint.
2. **Consolidate Completion**: Migrate from `nvim-cmp` to `blink.cmp` for significant latency reduction.
3. **Registry Hygiene**: Clean up `lua/custom/plugins/init.lua` and ensure modularity.

---

## 🛠 Phase 1: Picker Unification (Low Risk)
**Target**: Remove dependency on Telescope while maintaining all existing search/navigation shortcuts.

### 1.1 Mapping Translation Table
All current `telescope.builtin` calls must be replaced with the following `Snacks.picker` equivalents:

| Existing Telescope Call | Snacks.nvim Replacement | Keymap (Target) |
| :--- | :--- | :--- |
| `builtin.find_files` | `Snacks.picker.files()` | `<leader>sf` $\rightarrow$ `<leader>ff` |
| `builtin.live_grep` | `Snacks.picker.grep()` | `<leader>sg` $\rightarrow$ `<leader>fg` |
| `builtin.buffers` | `Snacks.picker.buffers()` | `<leader><leader>` $\rightarrow$ `<leader>fb` |
| `builtin.help_tags` | `Snacks.picker.help_tags()` | `<leader>sh` |
| `builtin.keymaps` | `Snacks.picker.keymaps()` | `<leader>sk` |
| `builtin.diagnostics` | `Snacks.picker.diagnostics()` | `<leader>sd` |
| `lsp_references` | `Snacks.picker.lsp_references()` | `grr` |
| `lsp_definitions` | `Snacks.picker.lsp_definitions()` | `grd` |
| `lsp_implementations` | `Snacks.picker.lsp_implementations()` | `gri` |
| `lsp_document_symbols` | `Snacks.picker.lsp_symbols()` | `gO` |
| `lsp_dynamic_workspace_symbols` | `Snacks.picker.lsp_workspace_symbols()` | `gW` |
| `lsp_type_definitions` | `Snacks.picker.lsp_type_definitions()` | `grt` |

### 1.2 Execution Steps
1. **`lua/custom/plugins/lsp.lua`**: Replace all `require('telescope.builtin')` calls with `Snacks.picker`.
2. **`init.lua`**: 
   - Replace Telescope keymaps with Snacks equivalents.
   - Set `enabled = false` for the `telescope.nvim` plugin block.
3. **`lua/custom/theme_switcher.lua`**: Verify if the theme selection menu uses Telescope; if so, migrate to `Snacks.picker.select()`.
4. **Verification**: Restart Neovim and ensure all `gr*` and `<leader>f*` mappings trigger the Snacks UI.

---

## ⚡ Phase 2: Completion Pivot (Medium Risk)
**Target**: Transition to `blink.cmp` while maintaining Copilot integration.

### 2.1 Dependency Updates
- **Remove**: `lua/custom/plugins/cmp.lua` (and `nvim-cmp` related plugins).
- **Install**: `saghen/blink.cmp`.
- **Integrate**: Install `giuxtaposition/blink-cmp-copilot` to bridge `copilot.lua` with the `blink.cmp` source list.

### 2.2 Configuration Logic
1. Create `lua/custom/plugins/blink.lua`.
2. Configure `blink.cmp` with `preset = 'default'` to match current UX.
3. Ensure `sources.default` includes `{'lsp', 'path', 'snippets', 'buffer', 'copilot'}`.
4. **Verification**: Ensure ghost-text and completion menus appear without latency and that Copilot suggestions are correctly prioritized.

---

## 🧹 Phase 3: Registry Cleanup (Low Risk)
**Target**: Remove technical debt from the plugin loading sequence.

### 3.1 Refactoring `lua/custom/plugins/init.lua`
1. **Prune**: Remove all commented-out plugin blocks (especially the old `codecompanion` block).
2. **Modularize**: Move any remaining bulky configuration logic from `init.lua` into dedicated files in `lua/custom/plugins/` (e.g., `lua/custom/plugins/ui.lua`).
3. **Audit**: Ensure the `import` statements for `custom.plugins` and `custom.snacks` are the final steps in the `lazy.nvim` setup.

---

## ✅ Final Verification Checklist
- [ ] **Boot**: `nvim` opens without any `module not found` errors.
- [ ] **Pickers**: All `<leader>f*`, `<leader>s*`, and LSP `gr*` mappings open the Snacks UI.
- [ ] **Completion**: `blink.cmp` provides fast completions and Copilot suggestions.
- [ ] **UI**: Theme switching and `bufferline` remain stable (no highlight glitches).
- [ ] **Performance**: Noticeable reduction in LSP navigation latency.

## 🚨 Rollback Plan
In case of critical failure:
1. Re-enable `telescope.nvim` in `init.lua`.
2. Revert `lsp.lua` mappings to `telescope.builtin`.
3. Restore `lua/custom/plugins/cmp.lua` and disable `blink.cmp`.
