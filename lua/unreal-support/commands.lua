local M = {}

-- path separator. "/" for linux, "\" for windows
local p = package.config:sub(1, 1)

local build_script = nil

local function run_terminal_command(command)
	vim.cmd("term" .. command)
end

local function build_script_path()
	if not build_script then
		local usp = require("unreal-support")
		if p == "\\" then
			build_script = usp.engine_path .. "\\Engine\\Build\\BatchFiles\\Build.bat"
		else
			build_script = usp.engine_path .. "/Engine/Build/BatchFiles/Linux/Build.sh"
		end
	end
	return build_script
end

M.buildEditor = function()
	local usp = require("unreal-support")
	local platform = "Win64"
	if p == "/" then
		platform = "Linux"
	end
	local command = build_script_path() ..
		" -project=" ..
		usp.project_path ..
		p ..
		usp.project_name .. ".uproject -game -engine " .. usp.project_name .. "Editor " .. platform .. " Development"
	run_terminal_command(command)
end

M.buildGame = function()
	local usp = require("unreal-support")
	local platform = "Win64"
	if p == "/" then
		platform = "Linux"
	end
	local command = build_script_path() ..
		" -project=" ..
		usp.project_path ..
		p ..
		usp.project_name .. ".uproject -game -engine " .. usp.project_name .. " " .. platform .. " Development"
	run_terminal_command(command)
end

M.gen = function()
	local usp = require("unreal-support")
	local platform = "Win64"
	local move = "move"
	if p == "/" then
		platform = "Linux"
		move = "mv"
	end
	local command = build_script_path() ..
		" -mode=GenerateClangDatabase -project=" ..
		usp.project_path ..
		p ..
		usp.project_name ..
		".uproject -game -engine " .. usp.project_name .. "Editor " .. platform .. " Development" ..
		" && " .. move .. " \"" .. usp.engine_path .. p .. "compile_commands.json\" \"" .. usp.project_path .. "\""
	run_terminal_command(command)
end

M.runEditor = function()
end

M.runGame = function()
end

M.clean = function()
	local usp = require("unreal-support")
	local platform = "Win64"
	if p == "/" then
		platform = "Linux"
	end
	local command = "\"" .. build_script_path() .. "\" " ..
		"-project=\"" ..
		usp.project_path ..
		p ..
		usp.project_name .. ".uproject\" -game -engine " .. usp.project_name .. " " .. platform .. " Development -Clean"
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
