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
    for minorVersion = 0, 99 do -- Assuming minor versions from 0 to 99
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

return M