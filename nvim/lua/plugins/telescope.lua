return {
	"nvim-telescope/telescope.nvim",
	opts = {},
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
				local find_command = {
					"rg",
					"--files",
					"--color",
					"never",
					"-uu",
				}
				for _, d in ipairs({
					".git",
					"node_modules",
					"/target/",
					"/build/",
					"/.cache/",
					"__pycache__",
				}) do
					table.insert(find_command, "-g")
					table.insert(find_command, "!" .. d)
				end

				require("telescope.builtin").find_files({
					find_command = find_command,
					disable_coordinates = true,
					hidden = true,
				})
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
				require("telescope.builtin").live_grep({
					disable_coordinates = true,
					additional_args = function(_)
						return { "--hidden" }
					end,
				})
			end,
			desc = "Find string",
		},
	},
}
