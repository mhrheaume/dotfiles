return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = { "VeryLazy", "BufReadPost", "BufNewFile" },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		opts = {},
		config = function()
			-- Install parsers
			local ensure_installed = {
				"bash",
				"cpp",
				"dockerfile",
				"go",
				"graphql",
				"json",
				"lua",
				"luadoc",
				"proto",
				"python",
				"rust",
				"terraform",
				"tsx",
				"typescript",
				"vimdoc",
				"yaml",
			}
			local installed = require("nvim-treesitter").get_installed()
			local to_install = vim.tbl_filter(function(lang)
				return not vim.list_contains(installed, lang)
			end, ensure_installed)
			if #to_install > 0 then
				require("nvim-treesitter").install(to_install)
			end

			-- Register additional filetypes
			vim.treesitter.language.register("bash", "zsh")
			vim.treesitter.language.register("python", "starlark")
			vim.treesitter.language.register("terraform", { "terraform", "terraform-vars" })
		end,
	},
}
