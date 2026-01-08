# CLAUDE.md

This file provides guidance for working with this dotfiles repository.

## Project Overview

This is a personal dotfiles repository containing system configuration files for various tools and applications.

## Repository Structure

- **Root-level configs**: `zshrc`, `tmux.conf` - shared configuration files
- **Application directories**: Each subdirectory contains configuration for a specific tool
  - `nvim/` - Neovim editor configuration (Lua-based)
  - `tmux/` - Supplemental configuration for tmux (i.e. plugins)
  - `alacritty/` - Alacritty terminal emulator configuration (legacy)
  - `ghostty/` - Ghostty terminal emulator configuration
  - `wezterm/` - WezTerm terminal emulator configuration (legacy)
  - `xmonad/` - XMonad window manager configuration (legacy)

## Configuration Languages

- **Neovim**: Lua and Vimscript
- **Shell configs**: Zsh (zshrc)

## Common Tasks

### Modifying Neovim Configuration

- Main config: `nvim/init.lua`
- Plugin lockfile: `nvim/lazy-lock.json` (managed by lazy.nvim)
- Additional config: `nvim/lua/` directory
- Filetype detection: `nvim/ftdetect/`
- After scripts: `nvim/after/`

### Shell Configuration

- Primary shell: zsh
- Config file: `zshrc` (root level)

## Notes

- This repository is actively maintained
- Configuration files are meant to be symlinked to their proper locations
- Changes to nvim plugins should update lazy-lock.json
- Keep configurations minimal and focused on personal preferences
