RegisterCommand('bulletproof', function()
    ATH.UseItem('bulletproof')
end, false)
RegisterKeyMapping('bulletproof', 'Weste', 'keyboard', 'PERIOD')

RegisterCommand('medikit', function()
    ATH.UseItem('medikit')
end, false)
RegisterKeyMapping('medikit', 'Medikit', 'keyboard', 'COMMA')

local NameTags = {}

RegisterCommand('aduty', function()
    if ATH.PlayerData.rank ~= 'user' then
        ATH.PlayerData.isDuty = not ATH.PlayerData.isDuty
        if ATH.PlayerData.isDuty then
            -- ATH.PlayerData.skin = skin
        else
            SetPlayerInvincible(ATH.PlayerData.playerId, false)
            SetPedCanRagdoll(ATH.PlayerData.ped, true)
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

local maskOff = false
RegisterCommand('mask', function()
    maskOff = not maskOff
    if maskOff then
        SetPedComponentVariation(ATH.PlayerData.ped, 1, 0, 0, 0)
    else
        local mask = nil
        for _, i in pairs(ATH.PlayerData.clothes) do
            if i.componentId == 1 then mask = i end
        end
        SetPedComponentVariation(ATH.PlayerData.ped, 1, mask.drawableId, mask.textureId, 0)
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
    local c = GetEntityCoords(PlayerPedId())
    local coords = tostring(vector4(c.x,c.y,c.z,GetEntityHeading(PlayerPedId())))
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
