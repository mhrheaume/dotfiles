return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			bzl = { "buildifier" },
			go = { "gofumpt" },
			lua = { "stylua" },
			javascript = { "prettier" },
			json = { "jq" },
			python = { "ruff_format", "ruff_fix" },
			rust = { "rustfmt" },
			sh = { "shfmt" },
			terraform = { "terraform_fmt" },
			["terraform-vars"] = { "terraform_fmt" },
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
			jq = {
				prepend_args = { "--indent", "2" },
			},
			shfmt = {
				prepend_args = { "-i", "4" },
			},
			rustfmt = {
				options = {
					default_edition = "2024",
				},
			},
		},
	},
}
