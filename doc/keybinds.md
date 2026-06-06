# ⌨️ Neovim Keybindings Guide

This document lists all configured keybindings for the current Neovim setup.

## 🌍 General & System
| Keybind | Description | Mode |
| :--- | :--- | :--- |
| `<Esc>` | Clear search highlights | `n` |
| `jj` | Quick escape to Normal mode | `i` |
| `<C-BS>` | Delete previous word (Ctrl+Backspace) | `i` |
| `<C-h>` | Move focus to the left window | `n` |
| `<C-l>` | Move focus to the right window | `n` |
| `<C-j>` | Move focus to the lower window | `n` |
| `<C-k>` | Move focus to the upper window | `n` |
| `<Esc><Esc>` | Exit terminal mode | `t` |
| `<C-+>` | Increase Neovide scale factor | `n, v` |
| `<C-->` | Decrease Neovide scale factor | `n, v` |
| `<C-0>` | Reset Neovide scale factor | `n, v` |

## 🔍 Search & Picking (Snacks.nvim)
| Keybind | Description | Mode |
| :--- | :--- | :--- |
| `<leader>sf` | Search Files | `n` |
| `<leader>sg` | Search by Grep | `n` |
| `<leader>sh` | Search Help | `n` |
| `<leader>sk` | Search Keymaps | `n` |
| `<leader>sd` | Search Diagnostics | `n` |
| `<leader>sr` | Search Resume | `n` |
| `<leader>s.` | Search Recent Files | `n` |
| `<leader><leader>` | Find existing buffers | `n` |
| `<leader>/` | Fuzzily search in current buffer | `n` |
| `<leader>s/` | Search in Open Files | `n` |
| `<leader>sn` | Search Neovim config files | `n` |
| `<leader>ww` | Workspace Picker | `n` |

## 🛠 LSP (Language Server Protocol)
| Keybind | Description | Mode |
| :--- | :--- | :--- |
| `grn` | Rename symbol | `n` |
| `gra` | Goto Code Action | `n, x` |
| `grr` | Goto References | `n` |
| `gri` | Goto Implementation | `n` |
| `grd` | Goto Definition | `n` |
| `grD` | Goto Declaration | `n` |
| `gO` | Open Document Symbols | `n` |
| `gW` | Open Workspace Symbols | `n` |
| `grt` | Goto Type Definition | `n` |
| `<leader>q` | Open diagnostic Quickfix list | `n` |
| `<leader>th` | Toggle Inlay Hints | `n` |

## 📁 File & Buffer Management
| Keybind | Description | Mode |
| :--- | :--- | :--- |
| `<Tab>` | Next buffer (safe) | `n` |
| `<S-Tab>` | Previous buffer (safe) | `n` |
| `<leader>x` | Smart close buffer (preserve layout) | `n` |
| `<leader>bn` | New empty buffer | `n` |
| `<leader>e` | Toggle Neo-tree | `n` |
| `<C-n>` | Toggle Neo-tree (Alternative) | `n` |
| `<leader>bh` | Toggle BufferLine visibility | `n` |

## 🤖 AI & CodeCompanion
| Keybind | Description | Mode |
| :--- | :--- | :--- |
| `<leader>as` | Save CodeCompanion Chat | `n` |
| `<leader>al` | Load CodeCompanion Chat | `n` |
| `<leader>ad` | Delete CodeCompanion Chat | `n` |

## 🐞 Debugging (DAP)
| Keybind | Description | Mode |
| :--- | :--- | :--- |
| `<F5>` | Debug: Start/Continue | `n` |
| `<F1>` | Debug: Step Into | `n` |
| `<F2>` | Debug: Step Over | `n` |
| `<F3>` | Debug: Step Out | `n` |
| `<F6>` | Debug: Stop | `n` |
| `<F7>` | Debug: Toggle UI | `n` |
| `<leader>bb` | Debug: Toggle Breakpoint | `n` |
| `<leader>B` | Debug: Conditional Breakpoint | `n` |

## ☕ Language Specific (Java/JDTLS)
| Keybind | Description | Mode |
| :--- | :--- | :--- |
| `<leader>co` | Organize Imports | `n` |
| `<leader>crv` | Extract Variable | `n, v` |
| `<leader>crc` | Extract Constant | `n, v` |
| `<leader>crm` | Extract Method | `v` |
