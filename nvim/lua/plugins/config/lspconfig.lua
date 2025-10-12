return function(_, _)
	local capabilities = require("blink.cmp").get_lsp_capabilities()

	vim.lsp.config("lua_ls", {
		capabilities = capabilities,
		settings = {
			Lua = {
				hint = {
					enable = true,
				},
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	})

	-- Python
	vim.lsp.config("basedpyright", {
		capabilities = capabilities,
		settings = {
			basedpyright = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "openFilesOnly",
					typeCheckingMode = "off",
					useLibraryCodeForTypes = true,
				},
			},
		},
	})

	vim.lsp.enable("pyre")
	vim.lsp.config("pyre", {
		capabilities = capabilities,
	})

	vim.lsp.enable("ruff")
	vim.lsp.config("ruff", {
		capabilities = capabilities,
	})

	-- Golang
	vim.lsp.config("gopls", {
		capabilities = capabilities,
		settings = {
			gopls = {
				buildFlags = { "-tags=integration" },
				hints = {
					assignVariableTypes = true,
					parameterNames = true,
				},
			},
		},
	})

	vim.lsp.config("golangci_lint_ls", {
		capabilities = capabilities,
	})

	-- Rust
	vim.lsp.enable("rust_analyzer")
	vim.lsp.config("rust_analyzer", {
		capabilities = capabilities,
		settings = {
			["rust-analyzer"] = {
				check = {
					command = "clippy",
				},
			},
		},
	})

	-- Typescript
	vim.lsp.config("ts_ls", {
		capabilities = capabilities,
		init_options = {
			preferences = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
				importModuleSpecifierPreference = "non-relative",
			},
		},
	})

	vim.lsp.config("eslint", {
		packageManager = "yarn",
		on_attach = function(_, bufnr)
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				command = "EslintFixAll",
			})
		end,
	})

	-- C/C++
	vim.lsp.config("clangd", {
		capabilities = capabilities,
		filetypes = { "c", "cpp" },
	})

	-- Protobuf
	vim.lsp.config("buf_ls", {
		capabilities = capabilities,
	})
end
