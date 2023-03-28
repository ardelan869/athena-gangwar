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
    local level, needed, show = ATH.GetLevel(xp)
    ATH.PlayerData.level = level
    SendNUIMessage({
        action = 'AddXPFeed',
        type = string.find(tostring(Levels.On[t]), '-') and 'subtract' or 'add',
        amount = string.find(tostring(Levels.On[t]), '-') and toPlus(Levels.On[t]) or Levels.On[t],
        reason = t,
        xp = show,
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
            ATH.SpawnCar(model, 'ATHENA')
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