local config = require('last-session.config')

local M = {}

M.save_session = function ()
	require('last-session.sessions').save_session()
end

M.load_session = function ()
	require('last-session.sessions').load_session()
end

-- setup
M.setup = function(opts)
	config.setup(opts or {})

	-- If auto_save is true, save the session before exiting Neovim.
	local options = config.get_config()
	if options.auto_save then
		vim.api.nvim_create_autocmd('VimLeavePre', {
			group = vim.api.nvim_create_augroup('LastSession', { clear = true }),
			callback = function ()
				M.save_session()
			end,
			desc = 'Auto-save session before exiting Neovim',
		})
	end
end

return M
