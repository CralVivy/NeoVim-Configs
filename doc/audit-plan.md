# Rigorous Neovim Configuration Audit Plan (2026)

## 1. Audit Objectives
The goal of this audit is to transform the current Neovim configuration from a "functional" state to an "optimized, professional-grade" state while **strictly preserving the current UX intent and stability**. The focus is on four pillars:
- **Performance**: Minimize startup time, reduce runtime latency (especially in completion and pickers), and optimize memory usage.
- **Stability**: Eliminate deprecated API calls, resolve plugin conflicts, and ensure robust error handling.
- **Modernity**: Transition from legacy patterns to 2026 standards (e.g., evaluating `blink.cmp` vs `nvim-cmp`, `snacks.nvim` integration).
- **Maintainability**: Enforce strict modularity, consistent naming conventions, and comprehensive cross-referencing.

---

## 2. Safeguards & Preservation (Anti-Breakage Protocol)
To ensure the audit does not degrade the current setup or break the UI, the following safeguards are mandatory:

### A. Intent Analysis (The "Why" before the "How")
- [ ] **Logic Reverse-Engineering**: Before proposing any change, the agent must document the *current* underlying logic. Why was this function written this way? What specific UI behavior does it enable?
- [ ] **Visual Baseline**: Identify critical UI elements (e.g., specific border styles, theme transitions, bufferline icons) that must remain identical unless explicitly requested otherwise.

### B. Dependency & Interaction Mapping
- [ ] **Inter-file Contract Audit**: Treat every file as part of a larger system. If `File A` is updated, `File B` (which consumes its output) must be simulated to ensure the contract remains intact.
- [ ] **Chain-Reaction Simulation**: For every proposed change, perform a "what-if" analysis: "If I change the way LSP handles completion in `lsp.lua`, how does it affect the `cmp.lua` setup and the final visual appearance of the completion menu?"

### C. UI/UX Impact Simulation
- [ ] **UI Regression Check**: Any change to UI-related plugins (`bufferline`, `neo-tree`, `snacks.nvim`) must be evaluated against the current visual setup to prevent "UI drift" or breakage of custom styling.
- [ ] **User-Workflow Simulation**: Simulate common workflows (e.g., "Open file $\rightarrow$ Search symbol $\rightarrow$ Edit $\rightarrow$ Switch Buffer") to ensure the change doesn't introduce friction or break existing muscle memory.


## 2. Global Standards & 2026 Best Practices
Every audited file must be checked against these "Golden Rules":

### A. Performance & Loading
- [ ] **Lazy Loading**: Every plugin must have a defined `event`, `cmd`, `ft`, or `keys` trigger. No "eager" loading unless strictly necessary for the core experience.
- [ ] **Global Namespace**: Avoid polluting `_G`. Use local modules and explicit `require` calls.
- [ ] **Startup Time**: Target startup under 50ms. Identify "heavy" plugins using `:Lazy profile`.

### B. LSP & Completion
- [ ] **Capability Merging**: Ensure LSP capabilities are merged correctly to support snippets and completion.
- [ ] **Blink vs CMP**: Evaluate if `blink.cmp` (Rust-based) should replace `nvim-cmp` for lower latency.
- [ ] **Server Lifecycle**: Verify that servers are started via `mason-lspconfig` and handled by `lspconfig` without redundancy.

### C. UI & UX
- [ ] **Snacks.nvim Convergence**: Evaluate if `snacks.nvim` pickers should replace `telescope.nvim` for specific high-frequency tasks.
- [ ] **Visual Consistency**: Check for consistent theme colors across `bufferline`, `neo-tree`, and custom UI elements.
- [ ] **Keymap Ergonomics**: Audit for keymap collisions and intuitive grouping.

---

## 3. Cross-Reference Protocol (The "Connection" Logic)
To prevent "blind auditing," the following protocol must be followed for every function, variable, or table defined:

1.  **Definition Analysis**: Identify the symbol (e.g., `function M.setup()`).
2.  **Call-Site Mapping**: Run `rg` (ripgrep) across the entire `lua/` directory to find all occurrences of that symbol.
3.  **Dependency Chain**: If `File A` calls `File B` which calls `File C`, the audit must verify the data contract (input/output) across all three.
4.  **State Tracking**: Track any changes to global Neovim options (`vim.opt`) and identify which file "owns" the final state.

---

## 4. Detailed Audit Matrix

| Component | Files | Rigorous Checks | Reference Standard |
| :--- | :--- | :--- | :--- |
| **Core Boot** | `init.lua` | - Order of operations (Options $\rightarrow$ Plugins $\rightarrow$ Configs)<br>- Minimal logic in entry point<br>- Proper error handling for missing modules | Neovim Init Guide |
| **Plugin Core** | `lua/custom/plugins/init.lua`, `lazy-lock.json` | - Version pinning strategy<br>- Plugin duplication check<br>- Lazy-load trigger efficiency | `lazy.nvim` Docs |
| **LSP System** | `lua/custom/plugins/lsp.lua`, `lua/kickstart/plugins/lint.lua` | - Server config redundancy<br>- Diagnostic severity mapping<br>- Linter integration efficiency | `nvim-lspconfig` / `mason` |
| **Completion** | `lua/custom/plugins/cmp.lua` | - Latency audit<br>- Snippet source validation<br>- Alternative: `blink.cmp` feasibility | Completion Engine Benchmarks |
| **Picking/Search**| `lua/custom/snacks/picker.lua`, `lua/custom/snacks/snacks.lua` | - Telescope vs Snacks overlap<br>- Frequency sorting usage<br>- Cache efficiency | `snacks.nvim` API |
| **File Navigation**| `lua/kickstart/plugins/neo-tree.lua`, `lua/custom/configs/bufferline.lua` | - Event-driven updates<br>- Visual artifacts on resize<br>- Memory leak check on buffer close | UI Performance Patterns |
| **Custom Logic** | `lua/custom/utils/utils.lua`, `lua/custom/utils/theme_colors.lua` | - Type safety/validation<br>- Redundancy with native Lua functions<br>- Module caching | Lua 5.1 / LuaJIT Best Practices |
| **UI/Themes** | `lua/custom/current_theme.lua`, `lua/custom/plugins/themes.lua`, `lua/custom/theme_switcher.lua` | - Color contrast (WCAG)<br>- Theme switching latency<br>- Proper cleanup of highlight groups | Neovim Highlight API |
| **Keybindings** | `lua/custom/keymaps.lua` | - Collision detection<br>- Consistency (e.g., all "find" maps start with `<leader>f`)<br>- Dead-key analysis | Ergonomic Mapping Standards |
| **Specialized** | `lua/custom/plugins/codecompanion.lua`, `lua/custom/plugins/workspaces.lua` | - API key security (no hardcoding)<br>- Async operation handling<br>- State persistence | Plugin-specific Docs |

---

## 5. Execution Workflow

### Step 1: Static Analysis & Intent Mapping (The "Scan")
For each file in the matrix:
1. Read file content.
2. **Analyze Underlying Logic**: Document the *intent* and *dependencies* of the current implementation.
3. Apply the "Global Standards" checklist.
4. Map all internal functions to their external call-sites.
5. Flag "Legacy Patterns" (e.g., `vim.api.nvim_set_current_line` vs newer alternatives).

### Step 2: Simulation & Risk Assessment (The "Impact Study")
Before any refactoring:
1. **Simulate Changes**: For every flagged legacy pattern or proposed "modern" alternative, simulate the change in context.
2. **Breakage Analysis**: Specifically check if the change will:
    - Break the current UI layout or theme.
    - Disrupt dependencies in other files.
    - Alter a critical user-experience behavior.
3. **Dependency Validation**: Verify that the updated "contract" between files is still valid.

### Step 3: Dynamic Analysis (The "Stress Test")
1. Run `:Lazy profile` $\rightarrow$ Audit any plugin taking $>10ms$.
2. Measure LSP response time for large files.
3. Test theme switching for visual glitches.

### Step 4: Refactoring & Alignment (The "Controlled Update")
1. Propose changes based on "Modernity" (e.g., replacing `nvim-cmp` with `blink.cmp`) **only if the Simulation phase proves no UI/UX breakage**.
2. Consolidate redundant utility functions while preserving the logic.
3. Standardize keymap prefixes.

### Step 5: Final Verification
1. Run `:checkhealth`.
2. Verify all `doc/` files and `README.md` are updated to reflect the new structure.
3. Final check: "Does this configuration feel like a cohesive system or a collection of plugins?"
