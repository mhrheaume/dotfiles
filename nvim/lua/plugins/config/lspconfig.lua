return function(_, _)
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	require("lspconfig").lua_ls.setup({
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
	require("lspconfig").basedpyright.setup({
		capabilities = capabilities,
		settings = {
			basedpyright = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "openFilesOnly",
					useLibraryCodeForTypes = true,
				},
				typeCheckingMode = "off",
			},
		},
	})
	require("lspconfig").pyre.setup({
		capabilities = capabilities,
		cmd = { "pyre", "persistent" },
	})

	require("lspconfig").ruff.setup({
		capabilities = capabilities,
	})

	-- Golang
	require("lspconfig").gopls.setup({
		capabilities = capabilities,
		settings = {
			gopls = {
				hints = {
					assignVariableTypes = true,
					parameterNames = true,
				},
			},
		},
	})

	-- Rust
	require("lspconfig").rust_analyzer.setup({
		capabilities = capabilities,
	})

	-- Typescript
	require("lspconfig").ts_ls.setup({
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
end
