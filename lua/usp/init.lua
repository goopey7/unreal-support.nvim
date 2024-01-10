local commands = require("usp.commands")
local utils = require("usp.utils")

local M = {}

M.engine_path = nil

M.setup = function(opts)
	vim.api.nvim_create_user_command('UnrealBuild', commands.build, {})
	vim.api.nvim_create_user_command('UnrealGen', commands.gen, {})
	vim.api.nvim_create_user_command('UnrealRun', commands.run, {})
	vim.api.nvim_create_user_command('UnrealClean', commands.clean, {})
	vim.api.nvim_create_user_command('UnrealRebuild', commands.rebuild, {})
	vim.api.nvim_create_user_command('UnrealCook', commands.cook, {})
	vim.api.nvim_create_user_command('UnrealEnginePath', commands.engine_path, {})

	if opts and opts.engine_path then
		M.engine_path = opts.engine_path
	else
		M.engine_path = utils.scan_engine_path()
	end
end

return M
