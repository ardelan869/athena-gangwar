Emit = TriggerEvent
EmitNet = TriggerServerEvent
On = RegisterNetEvent
OnNUI = RegisterNUICallback
ATH.PlayerData = {}
ATH.logincam = nil
ATH.ItemsUsed = {}
ATH.UsingItem = false
ATH.ItemCooldown = false
ATH.Weather = 'EXTRASUNNY'
KillFeed = {}
WEATHER_TYPES = {
	['sun'] = 'EXTRASUNNY',
	['rain'] = 'RAIN',
	['fog'] = 'FOGGY',
	['snow'] = 'XMAS',
}

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

ATH.RevivePed = function()
    local ped = ATH.PlayerData.ped
    local coords = Teams[ATH.PlayerData.team].spawn
    local heading = GetEntityHeading(ped)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
    SetPlayerInvincible(PlayerId(), false)
    SetEntityInvincible(ped, false)
    ClearPedBloodDamage(ped)
    ResurrectPed(ped)
    SetEntityHealth(ped, 200)
    SetPedArmour(ped, 100)
    TriggerEvent('ath:OnPlayerRevive')
    TriggerServerEvent('ath:OnPlayerRevive')
    ATH.PlayerData.isDead = false
    CreateThread(function()
        while not IsControlJustPressed(0, 32) and
            not IsControlJustPressed(0, 33) and
            not IsControlJustPressed(0, 34) and
            not IsControlJustPressed(0, 22) and
            not IsControlJustPressed(0, 37) and
            not IsControlJustPressed(0, 35)
        do
            SetLocalPlayerAsGhost(true)
            SetGhostedEntityAlpha(128)
            SetEntityAlpha(ped, 128, false)
            Wait()
        end
        ResetEntityAlpha(ped)
        SetLocalPlayerAsGhost(false)
    end)
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

ATH.UpdateTeamCount = function()
    for team, count in pairs(ATH.Teams) do
        SendNUIMessage({
            action = 'UpdateTeamCount',
            team = team,
            count = count
        })
    end
end

ATH.CreatePed = function(model, pos, offset)
    local modelHash = (type(model) == 'string' and GetHashKey(model)) or model;
    ATH.LoadModel(modelHash)
    local ped = CreatePed(0, modelHash, pos.x, pos.y, pos.z-offset, 10.0, false, false)
    CreateThread(function()
        while not DoesEntityExist(ped) do Wait() end
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end)
    return ped
end

ATH.SpawnCar = function(model, plate, pos, heading)
    local model = type(model) == 'string' and GetHashKey(model) or model
    ATH.LoadModel(model)
    local heading = heading or GetEntityHeading(ATH.PlayerData.ped)
    local pos = pos or GetEntityCoords(ATH.PlayerData.ped)
    local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, heading, true, true)
    RequestCollisionAtCoord(pos)
    while not HasCollisionLoadedAroundEntity(vehicle) do
        Wait(0)
    end
    TaskWarpPedIntoVehicle(ATH.PlayerData.ped, vehicle, -1)
    SetVehicleDirtLevel(vehicle, 0)
    SetVehicleFuelLevel(vehicle, 100.0)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleModKit(vehicle, 0)
    SetVehicleMod(vehicle, 11, 3, false)
    SetVehicleMod(vehicle, 12, 2, false)
    SetVehicleMod(vehicle, 13, 2, false)
    SetVehicleMod(vehicle, 15, 3, false)
    SetVehicleMod(vehicle, 16, 4, false)
    ToggleVehicleMod(vehicle, 18, true)
    local rgb = {r=55,g=140,b=191}
    if plate ~= 'ATHENA' then
        rgb = Teams[ATH.PlayerData.team].color.rgb
    end
    SetVehicleCustomPrimaryColour(vehicle, rgb.r, rgb.g, rgb.b)
    SetVehicleCustomSecondaryColour(vehicle, rgb.r, rgb.g, rgb.b)
    SetVehicleNumberPlateText(vehicle, tostring(plate))
    SetVehicleNumberPlateTextIndex(vehicle, 1)
    return vehicle
end

ATH.ApplyClothes = function(skin)
    local skin = skin or ATH.PlayerData.clothes
    for _, cloth in pairs(skin) do
        if cloth.isDrop then
			SetPedPropIndex(
                ATH.PlayerData.ped,
                cloth.componentId,
                cloth.drawableId,
                cloth.textureId,
                2
            )
        else
            if cloth.componentId == 11 then
                if isLongSleeve(cloth.drawableId) then
                    SetPedComponentVariation(ATH.PlayerData.ped, 3, 4, 0, 2)
                else
                    SetPedComponentVariation(ATH.PlayerData.ped, 3, 2, 0, 2)
                end
            end
            SetPedComponentVariation(
                ATH.PlayerData.ped,
                cloth.componentId,
                cloth.drawableId,
                cloth.textureId,
                2
            )
        end
	end
end

ATH.IsVehicleNearPoint = function(coords, radius)
    if type(coords) == 'table' then
        coords = vector3(coords.x, coords.y, coords.z)
    end
    return IsAnyVehicleNearPoint(coords, radius or 3.0) == 0
end