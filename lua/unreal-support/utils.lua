local M = {}

M.scan_engine_path = function()
	local baseInstallPath = "C:\\Program Files\\Epic Games\\"
	local latestPath = nil

	-- Check for UE_5.x
	for minorVersion = 0, 99 do -- Assuming minor versions from 0 to 99
		local installPath = baseInstallPath .. string.format("UE_5.%d", minorVersion)
		local handle = io.popen("dir /AD /B \"" .. installPath .. "\"")

		if handle then
			local result = handle:read("*a")
			handle:close()

			if result and result ~= "" then
				latestPath = installPath
				return latestPath
			end
		end
	end

	-- Check for UE_4.xx
	for minorVersion = 0, 99 do  -- Assuming minor versions from 0 to 99
		for subMinorVersion = 0, 99 do -- Assuming sub-minor versions from 0 to 99
			local installPath = baseInstallPath .. string.format("UE_4.%02d", subMinorVersion)
			local handle = io.popen("dir /AD /B \"" .. installPath .. "\"")

			if handle then
				local result = handle:read("*a")
				handle:close()

				if result and result ~= "" then
					latestPath = installPath
					return latestPath
				end
			end
		end
	end

	print("Could not find Unreal Engine installation")
	print("Please specify the path to your Unreal Engine installation when calling setup() in your init.lua")
	print("Example: require(\"unreal-support\").setup({engine_path = \"C:\\\\Program Files\\\\Epic Games\\\\UE_5.3\"})")
	return nil
end

M.scan_project_path = function()
	local cwd = vim.fn.getcwd()
	local path = cwd
	local found = false
	while not found do
		local handle = io.popen("dir /B \"" .. path .. "\\*.uproject\"")
		if handle then
			local result = handle:read("*a")
			handle:close()
			if result and result ~= "" then
				found = true
				return path
			else
				local new_path = vim.fn.fnamemodify(path, ":h")
				if new_path == path then
					break
				end
				path = new_path
			end
		else
			break
		end
	end
	return nil
end

M.get_project_name = function(project_path)
	local handle = io.popen("dir /B \"" .. project_path .. "\\*.uproject\"")
	if handle then
		local result = handle:read("*a")
		handle:close()
		if result and result ~= "" then
			local project_name = string.gsub(result, ".uproject", "")
			project_name = string.sub(project_name, 1, string.len(project_name) - 1)
			return project_name
		end
	end
	return nil
end

return M
