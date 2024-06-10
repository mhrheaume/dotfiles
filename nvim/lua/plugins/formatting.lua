return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			bzl = { "buildifier" },
			lua = { "stylua" },
			python = { "black", "ruff_fix" },
			javascript = { "prettier" },
			sh = { "shfmt" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
		},
		format_on_save = function(bufnr)
			if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
				return
			end
			return { timeout_ms = 500, lsp_fallback = true }
		end,
		formatters = {
			shfmt = {
				prepend_args = { "-i", "4" },
			},
		},
	},
}
