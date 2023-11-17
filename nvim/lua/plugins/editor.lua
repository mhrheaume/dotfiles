return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},
	{
		"echasnovski/mini.bufremove",
		event = "VeryLazy",
		version = false,
		opts = {},
	},
	{
		"echasnovski/mini.surround",
		opts = {
			-- Settings / keybindings from vim-surround.
			custom_surroundings = {
				["("] = { output = { left = "( ", right = " )" } },
				["["] = { output = { left = "[ ", right = " ]" } },
				["{"] = { output = { left = "{ ", right = " }" } },
				["<"] = { output = { left = "< ", right = " >" } },
			},
			mappings = {
				add = "ys",
				delete = "ds",
				find = "",
				find_left = "",
				highlight = "",
				replace = "cs",
				update_n_lines = "",
			},
			search_method = "cover_or_next",
		},
	},
	-- Diagnostics
	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
		keys = {
			{
				"<leader>xx",
				function()
					require("trouble").toggle()
				end,
			},
			{
				"<leader>xw",
				function()
					require("trouble").toggle("workspace_diagnostics")
				end,
			},
			{
				"<leader>xd",
				function()
					require("trouble").toggle("document_diagnostics")
				end,
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"neo-tree",
					"lazy",
				},
			},
		},
		main = "ibl",
	},
}
