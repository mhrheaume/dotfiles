local M = {}

function M.on_plugin_load(name, fn)
	local lazy_config = require("lazy.core.config")

	if lazy_config.plugins[name] and lazy_config.plugins[name]._.loaded then
		fn(name)
	else
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyLoad",
			callback = function(event)
				if event.data == name then
					fn(name)
					return true
				end
			end,
		})
	end
end

return M
