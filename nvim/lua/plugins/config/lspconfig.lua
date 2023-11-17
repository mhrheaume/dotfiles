return function(_, _)
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	require("lspconfig").lua_ls.setup({
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					checkThirdParty = false,
				},
			},
		},
	})

	-- Python
	require("lspconfig").pyright.setup({
		capabilities = capabilities,
		settings = {
			python = {
				disableOrganizeImports = true,
				analysis = {
					diagnosticMode = "openFilesOnly",
					typeCheckingMode = "off",
				},
			},
		},
	})
	require("lspconfig").pyre.setup({
		capabilities = capabilities,
		cmd = { "pyre", "persistent" },
	})

	-- Golang
	require("lspconfig").gopls.setup({
		capabilities = capabilities,
	})

	-- Rust
	require("lspconfig").rust_analyzer.setup({
		capabilities = capabilities,
	})

	-- Typescript
	require("lspconfig").tsserver.setup({})
end
