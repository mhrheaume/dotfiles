local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Do this before lazy so mappings are correct.
vim.g.mapleader = " "

require("lazy").setup("plugins", {
	install = {
		colorscheme = { "kanagawa" },
	},
	change_detection = { notify = false },
})
