local M = {}

-- path separator. "/" for linux, "\" for windows
local p = package.config:sub(1, 1)

local build_script = nil

local function run_terminal_command(command)
	vim.cmd("term " .. command)
end

local function build_script_path()
	if not build_script then
		local usp = require("unreal-support")
		if p == "\\" then
			build_script = "\"" .. usp.engine_path .. "\\Engine\\Build\\BatchFiles\\Build.bat" .. "\""
		else
			build_script = usp.engine_path .. "/Engine/Build/BatchFiles/Linux/Build.sh"
		end
	end
	return build_script
end

local function editor_binary()
	local usp = require("unreal-support")
	if p == "\\" then
		return "\"" .. usp.engine_path .. "\\Engine\\Binaries\\Win64\\UnrealEditor.exe" .. "\""
	else
		return usp.engine_path .. "/Engine/Binaries/Linux/UnrealEditor"
	end
end

M.buildEditor = function()
	local usp = require("unreal-support")
	local platform = "Win64"
	local project_file_path = "\"" .. usp.project_path .. p .. usp.project_name .. ".uproject\""
	if p == "/" then
		platform = "Linux"
		project_file_path = usp.project_path .. p .. usp.project_name .. ".uproject"
	end
	local command = build_script_path() ..
		" -project=" ..
		project_file_path .. " -game -engine " .. usp.project_name .. "Editor " .. platform .. " Development"
	run_terminal_command(command)
end

M.buildGame = function()
	local usp = require("unreal-support")
	local platform = "Win64"
	local project_file_path = "\"" .. usp.project_path .. p .. usp.project_name .. ".uproject\""
	if p == "/" then
		platform = "Linux"
		project_file_path = usp.project_path .. p .. usp.project_name .. ".uproject"
	end
	local command = build_script_path() ..
		" -project=" ..
		project_file_path ..
		" -game -engine " .. usp.project_name .. " " .. platform .. " Development"
	run_terminal_command(command)
end

M.gen = function()
	local usp = require("unreal-support")
	local platform = "Win64"
	local move = "move"
	local project_file_path = "\"" .. usp.project_path .. p .. usp.project_name .. ".uproject\""
	if p == "/" then
		platform = "Linux"
		move = "mv"
		project_file_path = usp.project_path .. p .. usp.project_name .. ".uproject"
	end
	local command = build_script_path() ..
		" -mode=GenerateClangDatabase -project=" ..
		project_file_path ..
		" -game -engine " .. usp.project_name .. "Editor " .. platform .. " Development" ..
		" && " .. move .. " \"" .. usp.engine_path .. p .. "compile_commands.json\" \"" .. usp.project_path .. "\""
	run_terminal_command(command)
end

M.runEditor = function()
	local usp = require("unreal-support")
	local platform = "Win64"
	local project_file_path = "\"" .. usp.project_path .. p .. usp.project_name .. ".uproject\""
	if p == "/" then
		platform = "Linux"
		project_file_path = usp.project_path .. p .. usp.project_name .. ".uproject"
	end
	local command = "\"" .. editor_binary() .. "\" " .. "-project=\"" .. project_file_path .. "\""
	run_terminal_command(command)
end

M.runGame = function()
end

M.clean = function()
	local usp = require("unreal-support")
	local platform = "Win64"
	local project_file_path = "\"" .. usp.project_path .. p .. usp.project_name .. ".uproject\""
	if p == "/" then
		platform = "Linux"
		project_file_path = usp.project_path .. p .. usp.project_name .. ".uproject"
	end
	local command = "\"" .. build_script_path() .. "\" " ..
		"-project=\"" ..
		project_file_path ..
		"\" -game -engine " .. usp.project_name .. " " .. platform .. " Development -Clean"
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
