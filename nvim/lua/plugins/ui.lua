return {
	-- Neotree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{
				"<leader>fe",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "File Explorer",
			},
			{
				"<leader>be",
				function()
					require("neo-tree.command").execute({ toggle = true, source = "buffers" })
				end,
				desc = "Buffer Explorer",
			},
			{
				"<leader>fr",
				function()
					require("neo-tree.command").execute({ dir = vim.loop.cwd(), reveal = true })
				end,
				desc = "File Explorer (Current File)",
			},
		},
	},
	-- Lualine
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			options = {
				globalstatus = true,
				theme = "tokyonight",
			},
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
				lualine_x = {
					{
						function()
							return ("󰻂 Recording [%s]"):format(vim.fn.reg_recording())
						end,
						cond = function()
							return vim.fn.reg_recording() ~= ""
						end,
					},
					"encoding",
					"fileformat",
					"filetype",
				},
			},
		},
	},
	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				offsets = {
					{
						filetype = "neo-tree",
						text = "Explorer",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
	},
	-- Noice (Commandline, notifications, etc.)
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	-- Dressing
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	-- Various UI dependencies.
	{
		"rcarriga/nvim-notify",
		opts = {
			stages = "fade",
		},
	},
	{
		"MunifTanjim/nui.nvim",
		lazy = true,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},
}
