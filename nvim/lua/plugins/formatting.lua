return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			bzl = { "buildifier" },
			lua = { "stylua" },
			python = { "black" },
			javascript = { "prettier" },
			sh = { "shfmt" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
		},
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
		formatters = {
			shfmt = {
				prepend_args = { "-i", "4" },
			},
		},
	},
}
