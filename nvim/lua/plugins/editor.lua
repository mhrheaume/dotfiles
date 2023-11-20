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
	-- Git
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map("n", "<leader>hb", gs.toggle_current_line_blame, { desc = "Git blame" })
				map("n", "<leader>hp", gs.preview_hunk, { desc = "Git preview" })
			end,
		},
	},
	-- Indentation markers
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
