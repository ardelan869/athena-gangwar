Emit = TriggerEvent
EmitNet = TriggerServerEvent
On = RegisterNetEvent
OnNUI = RegisterNUICallback
ATH.PlayerData = {}
ATH.logincam = nil
ATH.ItemsUsed = {}
ATH.UsingItem = false
ATH.ItemCooldown = false

ATH.GetPlayers = function(onlyOtherPlayers, returnKeyValue, returnPeds)
    local players, myPlayer = {}, PlayerId()

    for k, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)

        if DoesEntityExist(ped) and ((onlyOtherPlayers and player ~= myPlayer) or not onlyOtherPlayers) then
            if returnKeyValue then
                players[player] = ped
            else
                players[#players + 1] = returnPeds and ped or player
            end
        end
    end

    return players
end

ATH.GetClosestEntity = function(entities, isPlayerEntities, coords, modelFilter)
    local closestEntity, closestEntityDistance, filteredEntities = -1, -1, nil

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        coords = GetEntityCoords(ATH.PlayerData.ped)
    end

    if modelFilter then
        filteredEntities = {}

        for k, entity in pairs(entities) do
            if modelFilter[GetEntityModel(entity)] then
                filteredEntities[#filteredEntities + 1] = entity
            end
        end
    end

    for k, entity in pairs(filteredEntities or entities) do
        local distance = #(coords - GetEntityCoords(entity))

        if closestEntityDistance == -1 or distance < closestEntityDistance then
            closestEntity, closestEntityDistance = isPlayerEntities and k or entity, distance
        end
    end

    return closestEntity, closestEntityDistance
end

ATH.GetClosestPlayer = function(coords)
    return ATH.GetClosestEntity(ATH.GetPlayers(true, true), true, coords, nil)
end

ATH.GetClosestVehicle = function(coords, modelFilter)
    return ATH.GetClosestEntity(GetGamePool('CVehicle'), false, coords, modelFilter)
end

ATH.AddNotify = function(text, title, time, icon)
    SendNUIMessage({
        action = 'AddNotify',
        title = title or 'INFO',
        text = text,
        time = time or 3000,
        icon = icon or 'info'
    })
end

ATH.AddAnnounce = function(text, title, time)
    SendNUIMessage({
        action = 'AddAnnounce',
        title = title or 'ANNOUNCE',
        text = text,
        time = time or 6000
    })
end

ATH.LoginCam = function(bool)
    SetNuiFocus(bool, bool)
    if bool then
        ATH.logincam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 3857.06, 3713.28, -23.15, 2.31, 5.34, 155.55, 90.79, true, 0)
        SetCamActive(ATH.logincam, true)
        RenderScriptCams(true, true, 0, true, true, 1)
        SetEntityCoords(ATH.PlayerData.ped, 3857.06, 3713.28, -23.15, 0,0,0, 1)
    else
        RenderScriptCams(false, false, 0, true, false, 0)
        DestroyCam(ATH.logincam, false)
        ATH.logincam = nil
        SetLocalPlayerAsGhost(false)
    end
end

ATH.RevivePed = function(ped)
    local ped = ped or ATH.PlayerData.ped
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
    SetPlayerInvincible(PlayerId(), false)
    SetEntityInvincible(playerPed, false)
    ClearPedBloodDamage(ped)
    ResurrectPed(ped)
    SetEntityHealth(ped, 200)
    TriggerEvent('ath:OnPlayerRevive')
    TriggerServerEvent('ath:OnPlayerRevive')
    ATH.PlayerData.isDead = false
end

ATH.AddBlip = function(p, sprite, colour, scale, name)
    local coords = type(p) == 'table' and vector3(p.X, p.Y, p.Z) or p
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour or 0)
    SetBlipScale(blip, scale or 0.7)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)
    return blip
end

ATH.LoadAnim = function(d, cb)
    if not HasAnimDictLoaded(d) then
        RequestAnimDict(d)
        while not HasAnimDictLoaded(d) do Wait() end
    end
    if cb then
        cb()
    end
end

ATH.LoadModel = function(model, cb)
    model = type(model) == 'string' and GetHashKey(model) or model
    if not HasModelLoaded(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do Wait() end
    end
    if cb then
        cb()
    end
end

ATH.PlayTimedAnim = function(animDict, animName, time, onFinish, onCancel)
    ATH.LoadAnim(animDict)
    local PLAY_ANIM = true
    CreateThread(function()
        CreateThread(function()
            while PLAY_ANIM do
                Wait()
                if not IsEntityPlayingAnim(ATH.PlayerData.ped, animDict, animName, 3) then
                    TaskPlayAnim(ATH.PlayerData.ped, animDict, animName, 8.0, -8.0, -1, 0, 0, false, false, false)
                end
                if onCancel and (IsControlJustPressed(0, 38) or IsDisabledControlJustPressed(0, 38)) then
                    onCancel()
                    StopEntityAnim(ATH.PlayerData.ped, animName, animDict, 0)
                    ClearPedTasks(ATH.PlayerData.ped)
                    PLAY_ANIM = false
                end
            end
        end)
        Wait(time)
        if PLAY_ANIM then
            PLAY_ANIM = false
            Wait(10)
            StopEntityAnim(ATH.PlayerData.ped, animName, animDict, 0)
            ClearPedTasks(ATH.PlayerData.ped)
            if onFinish then
                onFinish()
            end
        end
    end)
end

ATH.ProgressBar = function(time, cb)
    SendNUIMessage({action='Bar',time=time})
    if cb then
        Wait(time)
        cb()
    end
end

ATH.UseItem = function(item)
    if 
        not ATH.PlayerData.isDead and
        not ATH.UsingItem and
        not IsPedInAnyVehicle(ATH.PlayerData.ped, false) and
        not IsEntityInAir(ATH.PlayerData.ped) and
        not ATH.ItemCooldown
    then
        ATH.UsingItem = true
        if item == 'medikit' then
            local this = #ATH.ItemsUsed+1
            ATH.ItemsUsed[#ATH.ItemsUsed+1] = true
            ATH.PlayTimedAnim('amb@medic@standing@tendtodead@idle_a', 'idle_a', 3500, nil, function()
                ATH.ProgressBar(0)
                ATH.UsingItem = false
                CreateThread(function()
                    ATH.ItemCooldown = true
                    Wait(1000)
                    ATH.ItemCooldown = false
                end)
            end)
            ATH.ProgressBar(3500, function()
                if this == #ATH.ItemsUsed and ATH.UsingItem then
                    SetEntityHealth(PlayerPedId(), 200)
                    ATH.UsingItem = false
                end
            end)
        elseif item == 'bulletproof' then
            local this = #ATH.ItemsUsed+1
            ATH.ItemsUsed[#ATH.ItemsUsed+1] = true
            ATH.PlayTimedAnim('anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01', 3500, nil, function()
                ATH.ProgressBar(0)
                ATH.UsingItem = false
                CreateThread(function()
                    ATH.ItemCooldown = true
                    Wait(1000)
                    ATH.ItemCooldown = false
                end)
            end)
            ATH.ProgressBar(3500, function()
                if this == #ATH.ItemsUsed and ATH.UsingItem then
                    SetPedArmour(PlayerPedId(), 100)
                    ATH.UsingItem = false
                end
            end)
        end
    end
end

ATH.HelpNotify = function(msg)
    AddTextEntry('I_LOVE_CATS', msg)
    BeginTextCommandDisplayHelp('I_LOVE_CATS')
    EndTextCommandDisplayHelp(0, false, true, -1)
end