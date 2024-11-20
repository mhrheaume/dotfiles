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
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
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
				"<leader>xd",
				function()
					require("trouble").toggle({ mode = "diagnostics", filter = { buf = 0 } })
				end,
				desc = "Toggle document diagnostics",
			},
			{
				"<leader>xD",
				function()
					require("trouble").toggle({ mode = "diagnostics" })
				end,
				desc = "Toggle diagnostics",
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

				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, { desc = "Git blame" })
				map("n", "<leader>hl", gs.toggle_current_line_blame, { desc = "Git blame line" })
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
