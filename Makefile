DOTFILES := $(CURDIR)

# Active configs linked by 'all'
.PHONY: all shell git jj nvim tmux ghostty claude codex
# Legacy configs (not included in 'all')
.PHONY: alacritty wezterm xmonad

all: shell git jj nvim tmux ghostty claude codex

shell:
	ln -sf $(DOTFILES)/zshrc $(HOME)/.zshrc

git:
	ln -sf $(DOTFILES)/gitconfig $(HOME)/.gitconfig

jj:
	mkdir -p $(HOME)/.config/jj
	ln -sf $(DOTFILES)/jj/config.toml $(HOME)/.config/jj/config.toml

nvim:
	# If ~/.config/nvim exists as a real directory (not symlink), remove it first.
	ln -sfn $(DOTFILES)/nvim $(HOME)/.config/nvim

tmux:
	ln -sf $(DOTFILES)/tmux.conf $(HOME)/.tmux.conf

ghostty:
	mkdir -p $(HOME)/.config/ghostty
	ln -sf $(DOTFILES)/ghostty/config $(HOME)/.config/ghostty/config

claude:
	ln -sf $(DOTFILES)/claude/settings.json $(HOME)/.claude/settings.json
	ln -sf $(DOTFILES)/claude/statusline.sh $(HOME)/.claude/statusline.sh

codex:
	mkdir -p $(HOME)/.codex
	ln -sf $(DOTFILES)/codex/hooks.json $(HOME)/.codex/hooks.json

# Legacy targets

alacritty:
	ln -sfn $(DOTFILES)/alacritty $(HOME)/.config/alacritty

wezterm:
	ln -sfn $(DOTFILES)/wezterm $(HOME)/.config/wezterm

xmonad:
	ln -sfn $(DOTFILES)/xmonad $(HOME)/.xmonad
