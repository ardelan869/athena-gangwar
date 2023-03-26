On('__cfx_internal:serverPrint', print)

On('ath:UpdateLoadout', function(loadout)
    ATH.PlayerData.loadout = loadout
end)

On('ath:UpdateRank', function(rank)
    ATH.PlayerData.rank = rank
end)

On('ath:ShowHitmarker', function(damage, deadly)
    SendNUIMessage({
        action='ShowHitmarker',
        damage=damage,
        deadly=deadly
    })
end)

On('ath:UpdatePlayers', function(players)
    SendNUIMessage({
        action = 'UpdatePlayers',
        players = players
    })
end)

On('ath:UpdateStats', function(data)
    ATH.PlayerData.kills = data.kills
    ATH.PlayerData.deaths = data.deaths
    SendNUIMessage({
        action='SetStats',
        kills=data.kills,
        deaths=data.deaths,
    })
end)

On('ath:SetXP', function(xp, t)
    ATH.PlayerData.xp = xp
    local level, needed = ATH.GetLevel(xp)
    SendNUIMessage({
        action = 'AddXPFeed',
        type = string.find(tostring(Levels.On[t]), '-') and 'subtract' or 'add',
        amount = string.find(tostring(Levels.On[t]), '-') and toPlus(Levels.On[t]) or Levels.On[t],
        reason = t,
        xp = xp,
        needed = needed,
        level = level
    })
end)

On('ath:AddNotify', ATH.AddNotify)

On('ath:AddAnnounce', ATH.AddAnnounce)

On('ath:SpawnCar', function(model)
    if Config.Perms['all'][ATH.PlayerData.rank] then
        local model = GetHashKey(model)
        if IsModelInCdimage(model) then
            local coords, heading = GetEntityCoords(ATH.PlayerData.ped), GetEntityHeading(ATH.PlayerData.ped)
            if not HasModelLoaded(model) then
                RequestModel(model)
                while not HasModelLoaded(model) do Wait() end
            end
            local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, true)
            RequestCollisionAtCoord(coords)
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
            SetVehicleCustomPrimaryColour(vehicle, 55, 140, 191)
            SetVehicleCustomSecondaryColour(vehicle, 55, 140, 191)
            SetVehicleNumberPlateText(vehicle, "ATHENA")
            SetVehicleNumberPlateTextIndex(vehicle, 1)
            for i = 0, 3 do
                SetVehicleNeonLightEnabled(vehicle, i, true)
            end
            SetVehicleNeonLightsColour(vehicle, 55, 140, 191)
        else
            ATH.AddNotify('Invalid vehicle model.')
        end
    else
        EmitNet('ath:Alone', 'Tried to spawn car')
    end
end)

On('ath:UpdateTeams', function(teams)
    ATH.Teams = teams
    ATH.UpdateTeamCount()
end)

On('ath:SendMessage', function(data)
    SendNUIMessage({
        action='AddMessage',
        color=data.color,
        rank=data.rank,
        id=data.id,
        name=data.name,
        text=data.msg
    })
end)