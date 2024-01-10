local M = {}

local function run_terminal_command(command)
	vim.cmd("term" .. command)
end

M.buildEditor = function()
	local usp = require("unreal-support")
	local command = "\"" .. usp.engine_path .. "\\Engine\\Build\\BatchFiles\\Build.bat\" " ..
		"-project=\"" ..
		usp.project_path ..
		"\\" .. usp.project_name .. ".uproject\" -game -engine " .. usp.project_name .. "Editor Win64 Development"
	run_terminal_command(command)
end

M.buildGame = function()
	local usp = require("unreal-support")
	local command = "\"" .. usp.engine_path .. "\\Engine\\Build\\BatchFiles\\Build.bat\" " ..
		"-project=\"" ..
		usp.project_path ..
		"\\" .. usp.project_name .. ".uproject\" -game -engine " .. usp.project_name .. " Win64 Development"
	run_terminal_command(command)
end

M.gen = function()
	local usp = require("unreal-support")
	local command = "\"" .. usp.engine_path .. "\\Engine\\Build\\BatchFiles\\Build.bat\" " ..
		"-mode=GenerateClangDatabase -project=\"" ..
		usp.project_path ..
		"\\" .. usp.project_name .. ".uproject\" -game -engine " .. usp.project_name .. "Editor Win64 Development" ..
		" && move \"" .. usp.engine_path .. "\\compile_commands.json\" \"" .. usp.project_path .. "\""
	run_terminal_command(command)
end

M.runEditor = function()
end

M.runGame = function()
end

M.clean = function()
	local usp = require("unreal-support")
	local command = "\"" .. usp.engine_path .. "\\Engine\\Build\\BatchFiles\\Build.bat\" " ..
		"-project=\"" ..
		usp.project_path ..
		"\\" .. usp.project_name .. ".uproject\" -game -engine " .. usp.project_name .. "Editor Win64 Development -Clean"
	run_terminal_command(command)
end

M.rebuildEditor = function()
	M.clean()
	M.buildEditor()
end

M.rebuildGame = function()
	M.clean()
	M.buildGame()
end

M.cook = function()
	print("Hello from cook")
end

M.engine_path = function()
	print(require("unreal-support").engine_path)
end

M.project_path = function()
	print(require("unreal-support").project_path)
end

return M
