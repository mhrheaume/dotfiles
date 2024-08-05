return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.4",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("utils").on_plugin_load("telescope.nvim", function()
					require("telescope").load_extension("fzf")
				end)
			end,
		},
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader>tt",
			function()
				require("telescope.builtin").find_files({ disable_coordinates = true })
			end,
			desc = "Find file",
		},
		{
			"<leader>tb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Find buffer",
		},
		{
			"<leader>tg",
			function()
				require("telescope.builtin").live_grep({ disable_coordinates = true })
			end,
			desc = "Find string",
		},
	},
}
