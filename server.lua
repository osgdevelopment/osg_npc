Config = {}

-- Load Config
local configFile = LoadResourceFile(GetCurrentResourceName(), "config.lua")

if configFile then
    local env = { vector4 = vector4, Config = {} }
    setmetatable(env, { __index = _G })

    local func, err = load(configFile, "config", "t", env)
    if func then
        func()
        Config = env.Config

        -- Ensure Config.NPCS exists
        if not Config.NPCS or #Config.NPCS == 0 then
            print("⚠️ Warning: No NPCs found in config.lua! Check your configuration.")
        end
    else
        print("❌ Error loading config.lua: " .. err)
    end
else
    print("❌ Could not load config.lua! Ensure the file exists.")
end

-- Send Config to Clients When They Join
RegisterServerEvent("osg_npc:requestConfig")
AddEventHandler("osg_npc:requestConfig", function()
    local src = source
    TriggerClientEvent("osg_npc:receiveConfig", src, Config)
end)
