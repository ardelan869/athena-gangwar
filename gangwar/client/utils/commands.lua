local NameTags = {}
local NoclipSpeed = 1
local noclip = false
local maskOff = false

RegisterCommand('bulletproof', function()
    ATH.UseItem('bulletproof')
end, false)
RegisterKeyMapping('bulletproof', 'Weste', 'keyboard', 'PERIOD')

RegisterCommand('medikit', function()
    ATH.UseItem('medikit')
end, false)
RegisterKeyMapping('medikit', 'Medikit', 'keyboard', 'COMMA')

RegisterCommand('aduty', function()
    if ATH.PlayerData.rank ~= 'user' then
        ATH.PlayerData.isDuty = not ATH.PlayerData.isDuty
        if not ATH.PlayerData.isDuty then
            noclip = false
            SetPlayerInvincible(ATH.PlayerData.playerId, false)
            SetPedCanRagdoll(ATH.PlayerData.ped, true)
            ATH.ApplyClothes()
        else
            local var = ADUTY_VARIANT[ATH.PlayerData.rank]
            ATH.ApplyClothes({
                {
                    componentId = 11,
                    drawableId = 287,
                    textureId = var
                },
                {
                    componentId = 4,
                    drawableId = 114,
                    textureId = var
                },
                {
                    componentId = 6,
                    drawableId = 78,
                    textureId = var
                },
                {
                    componentId = 1,
                    drawableId = 135,
                    textureId = var
                },
                {
                    componentId = 3,
                    drawableId = 8,
                    textureId = 0
                }
            })
        end
        local GetPlayerPed = GetPlayerPed
        local CreateFakeMpGamerTag = CreateFakeMpGamerTag
        local GetActivePlayers = GetActivePlayers
        local GetPlayerServerId = GetPlayerServerId
        while ATH.PlayerData.isDuty do
            local sleep = 500
            local players = GetActivePlayers()
            for _, player in pairs(players) do
                local tag = '['..GetPlayerServerId(player)..'] | '..GetPlayerName(player)
                NameTag = CreateFakeMpGamerTag(GetPlayerPed(player), tag, 0, 0, 0, 0)
                NameTags[#NameTags+1] = NameTag
            end
            SetPlayerInvincible(ATH.PlayerData.playerId, true)
            SetPedCanRagdoll(ATH.PlayerData.ped, false)
            Wait(sleep)
        end
        ATH.ApplyClothes()
        for _, NameTag in pairs(NameTags) do
            if IsMpGamerTagActive(NameTag) then
                RemoveMpGamerTag(NameTag)
            end
        end
        NameTags = {}
    end
end)
RegisterKeyMapping('aduty', 'Toggle Aduty', 'keyboard', '0')

RegisterCommand('revive', function()
    if Config.Perms['all'][ATH.PlayerData.rank] then
        ATH.RevivePed()
    end
end)

RegisterCommand('mask', function()
    maskOff = not maskOff
    if maskOff then
        SetPedComponentVariation(ATH.PlayerData.ped, 1, 0, 0, 2)
    else
        local mask = nil
        for _, i in pairs(ATH.PlayerData.clothes) do
            if i.componentId == 1 then mask = i end
        end
        SetPedComponentVariation(ATH.PlayerData.ped, 1, mask.drawableId, mask.textureId, 2)
    end
end)
RegisterKeyMapping('mask', 'Toggle Mask', 'keyboard', 'M')

RegisterCommand('team', function()
    ATH.PlayerData.forceHud = true
    SendNUIMessage({
        action = 'ToggleHUD',
        bool = false
    })
    SendNUIMessage({
        action = 'ToggleFraction',
        bool = true
    })
    SetNuiFocus(true, true)
end)
RegisterKeyMapping('team', 'Switch Team', 'keyboard', 'F1')

RegisterCommand('coords', function()
    local c = GetEntityCoords(ATH.PlayerData.ped)
    local coords = tostring(vector4(c.x,c.y,c.z,GetEntityHeading(ATH.PlayerData.ped)))
    SendNUIMessage({action='CopyCoords',coords=coords})
    ATH.AddNotify('Koordinaten kopiert ('..coords..')')
end, false)
RegisterKeyMapping('coords', 'Copy Coords', 'keyboard', 'G')

RegisterCommand('chat', function()
    if IsNuiFocused() then return end
    SetNuiFocus(true, true)
    SendNUIMessage({action='OpenChat'})
end, false)
RegisterKeyMapping('chat', 'Open Chat', 'keyboard', 'T')

local function GetCamDirection()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(ATH.PlayerData.ped)
    local pitch = GetGameplayCamRelativePitch()
    
    local x = -math.sin(heading * math.pi / 180.0)
    local y = math.cos(heading * math.pi / 180.0)
    local z = math.sin(pitch * math.pi / 180.0)
    
    local len = math.sqrt(x * x + y * y + z * z)
    if len ~= 0 then
        x = x / len
        y = y / len
        z = z / len
    end
    
    return x, y, z
end

RegisterCommand('noclip', function()
    if ATH.PlayerData.isDuty then
        noclip = not noclip
        NoclipSpeed = 1
        local GetEntityCoords = GetEntityCoords
        local SetEntityVisible = SetEntityVisible
        local SetEntityCollision = SetEntityCollision
        local SetEntityVelocity = SetEntityVelocity
        local IsDisabledControlJustReleased = IsDisabledControlJustReleased
        local SetEntityCoordsNoOffset = SetEntityCoordsNoOffset
        SetEntityVisible(ATH.PlayerData.ped, not noclip, not noclip)
        SetEntityCollision(ATH.PlayerData.ped, not noclip, not noclip)
        while noclip do
            local k = nil
            local x, y, z = nil
            
            k = ATH.PlayerData.ped
            local c = GetEntityCoords(ATH.PlayerData.ped, 2)
            x, y, z = c.x, c.y, c.z
            
            local dx, dy, dz = GetCamDirection()
            SetEntityVelocity(k, 0.0001, 0.0001, 0.0001)
            
            if IsDisabledControlJustPressed(0, 21) then -- Change speed
                oldSpeed = NoclipSpeed
                NoclipSpeed = NoclipSpeed * 5
            end
            
            if IsDisabledControlJustReleased(0, 21) then -- Restore speed
                NoclipSpeed = oldSpeed
            end
            
            if IsDisabledControlPressed(0, 31) then -- MOVE BACK
                x = x - NoclipSpeed * dx
                y = y - NoclipSpeed * dy
                z = z - NoclipSpeed * dz
            end

            if IsDisabledControlPressed(0, 32) then -- MOVE FORWARD
                x = x + NoclipSpeed * dx
                y = y + NoclipSpeed * dy
                z = z + NoclipSpeed * dz
            end

            if IsDisabledControlPressed(0, 22) then -- MOVE UP
                z = z + NoclipSpeed
            end
            
            if IsDisabledControlPressed(0, 36) then -- MOVE DOWN
                z = z - NoclipSpeed
            end

            SetEntityCoordsNoOffset(k, x, y, z, true, true, true)
            Wait(1)
        end
        SetEntityVisible(ATH.PlayerData.ped, not noclip, not noclip)
        SetEntityCollision(ATH.PlayerData.ped, not noclip, not noclip)
    end
end, false)
RegisterKeyMapping('noclip', 'Toggle Noclip', 'keyboard', 'F7')

RegisterCommand('pausemenu', function()
    if not IsNuiFocused() then
        local settings = GetResourceKvpString('settings')
        SetNuiFocus(true, true)
        SendNUIMessage({ action = 'OpenPauseMenu' })
        SendNUIMessage({
            action = 'SetSettings',
            settings = settings and json.decode(settings) or false,
            loadout = ATH.PlayerData.loadout,
            meta = Config.MetaData,
            rewards = Rewards,
            collected = ATH.PlayerData.collected
        })
    end
end, false)
RegisterKeyMapping('pausemenu', 'Toggle Pausemenu', 'keyboard', 'P')