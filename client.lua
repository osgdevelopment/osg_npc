local Config = {} -- ✅ Initialize Config to prevent nil errors
local configLoaded = false -- ✅ Flag to check if Config is received

-- Function to load NPC models
function LoadModel(model)
    local modelHash = GetHashKey(model)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Citizen.Wait(10)
    end
end

-- Function to check if current in-game time is within the NPC's active hours
local function isTimeInRange(startHour, endHour)
    local currentHour = GetClockHours()
    
    if startHour < endHour then
        return currentHour >= startHour and currentHour < endHour
    else
        return currentHour >= startHour or currentHour < endHour
    end
end

-- Request Config from the Server
RegisterNetEvent("osg_npc:receiveConfig")
AddEventHandler("osg_npc:receiveConfig", function(serverConfig)
    Config = serverConfig
    configLoaded = true
end)

TriggerServerEvent("osg_npc:requestConfig") -- Request config when the script starts

Citizen.CreateThread(function()
    while not configLoaded do
        Citizen.Wait(1000) -- ✅ Wait until Config is received
    end
    
    while true do
        if Config.NPCS then
            for _, npc in pairs(Config.NPCS) do
                local pcoords = GetEntityCoords(PlayerPedId())
                local dist = GetDistanceBetweenCoords(pcoords, npc.coords.x, npc.coords.y, npc.coords.z, 1)

                -- Check if NPC is within active hours
                if isTimeInRange(npc.startHour, npc.endHour) and dist < 180 and not DoesEntityExist(npc.NPC) then
                    LoadModel(npc.model) -- ✅ Now this function is defined
                    local npc_ped = CreatePed(npc.model, npc.coords, false, true, true, true)

                    if npc.outfit then
                        SetPedOutfitPreset(npc_ped, npc.outfit)
                    else
                        Citizen.InvokeNative(0x283978A15512B2FE, npc_ped, true)
                    end

                    if npc.weapon then 
                        GiveWeaponToPed_2(npc_ped, GetHashKey(npc.weapon), 10, true, true, 1, false, 0.5, 1.0, 1.0, true, 0, 0)
                        SetCurrentPedWeapon(npc_ped, GetHashKey(npc.weapon), true, 0, false, false)
                    end

                    if npc.scenario then
                        TaskStartScenarioInPlace(npc_ped, GetHashKey(npc.scenario), 0, true, false, false, false)
                    end

                    if npc.anim.animDict and npc.anim.animName then
                        RequestAnimDict(npc.anim.animDict)
                        while not HasAnimDictLoaded(npc.anim.animDict) do
                            Citizen.Wait(100)
                        end
                        TaskPlayAnim(npc_ped, npc.anim.animDict, npc.anim.animName, 1.0, -1.0, -1, 1, 0, true, 0, false, 0, false)
                    end

                    if npc.scale then
                        SetPedScale(npc_ped, npc.scale)
                    end

                    SetEntityCanBeDamaged(npc_ped, false)
                    SetEntityInvincible(npc_ped, true)
                    FreezeEntityPosition(npc_ped, true)
                    SetBlockingOfNonTemporaryEvents(npc_ped, true)
                    SetModelAsNoLongerNeeded(npc.model)
                    SetEntityAsMissionEntity(npc_ped, true, true)

                    npc.NPC = npc_ped

                elseif (not isTimeInRange(npc.startHour, npc.endHour) or dist > 180) and DoesEntityExist(npc.NPC) then
                    DeleteEntity(npc.NPC)
                    npc.NPC = nil
                end
            end
        end
        Citizen.Wait(500)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for i, v in pairs(Config.NPCS) do
        if v.NPC then
            DeleteEntity(v.NPC)
            DeletePed(v.NPC)
        end
    end
end)
