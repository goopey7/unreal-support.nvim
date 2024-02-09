local commands = require("unreal-support.commands")
local utils = require("unreal-support.utils")

local M = {}

M.engine_path = nil
M.project_path = nil
M.project_name = nil

M.setup = function(opts)
	if opts and opts.project_path then
		M.project_path = opts.project_path
	else
		M.project_path = utils.scan_project_path()
	end

	if not M.project_path then
		return
	else
		M.project_name = utils.get_project_name(M.project_path)

		-- Call the callback function if provided
		if opts and opts.on_project_loaded and type(opts.on_project_loaded) == "function" then
			opts.on_project_loaded(M.project_path, M.project_name)
		end
	end

	if opts and opts.engine_path then
		M.engine_path = opts.engine_path
	else
		M.engine_path = utils.scan_engine_path()
	end

	vim.api.nvim_create_user_command('UnrealBuildEditor', commands.buildEditor, {})
	vim.api.nvim_create_user_command('UnrealBuildGame', commands.buildGame, {})
	vim.api.nvim_create_user_command('UnrealGen', commands.gen, {})
	vim.api.nvim_create_user_command('UnrealRunEditor', commands.runEditor, {})
	vim.api.nvim_create_user_command('UnrealClean', commands.clean, {})
	vim.api.nvim_create_user_command('UnrealRebuildEditor', commands.rebuildEditor, {})
	vim.api.nvim_create_user_command('UnrealRebuildGame', commands.rebuildGame, {})
	vim.api.nvim_create_user_command('UnrealCook', commands.cook, {})
	vim.api.nvim_create_user_command('UnrealEnginePath', commands.engine_path, {})
	vim.api.nvim_create_user_command('UnrealProjectPath', commands.project_path, {})

end

return M
