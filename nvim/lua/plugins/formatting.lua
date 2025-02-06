return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			bzl = { "buildifier" },
			go = { "gofmt", "goimports" },
			lua = { "stylua" },
			javascript = { "prettier" },
			json = { "jq" },
			python = { "black", "isort", "ruff_fix" },
			rust = { "rustfmt" },
			sh = { "shfmt" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
		},
		format_on_save = function(bufnr)
			if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
				return
			end
			return { timeout_ms = 5000, lsp_fallback = true }
		end,
		formatters = {
			shfmt = {
				prepend_args = { "-i", "4" },
			},
		},
	},
}
