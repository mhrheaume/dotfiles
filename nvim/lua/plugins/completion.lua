return {
	-- Completion
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		opts = function()
			local cmp = require("cmp")

			return {
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp", group_index = 1 },
					{ name = "luasnip", group_index = 1 },
					{ name = "path", group_index = 1 },
					{ name = "buffer", group_index = 2 },
				}),
			}
		end,
	},
	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		-- build = "make install_jsregexp"
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
		"github/copilot.vim",
		branch = "release",
	},
}
