return {
	-- Completion
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			cmdline = { enabled = false },
			completion = {
				menu = {
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind", gap = 1 },
							{ "source_name" },
						},
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 0,
				},
			},
			keymap = { preset = "enter" },
			signature = { enabled = true },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
		opts_extend = { "sources.default" },
	},
	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"neodev.nvim",
			"mason.nvim",
			"mason-lspconfig.nvim",
		},
		config = require("plugins.config.lspconfig"),
	},
	{
		"folke/neodev.nvim",
		opts = {},
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {},
	},
	-- Copilot
	{
		"zbirenbaum/copilot.lua",
		opts = {
			suggestion = {
				auto_trigger = true,
			},
			copilot_node_command = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v22.20.0/bin/node",
		},
		cmd = "Copilot",
		event = "InsertEnter",
	},
}
