On('__cfx_internal:serverPrint', function(msg)
    if #msg > 0 then
        print(msg)
        SendNUIMessage({
            action='AddMessage',
            text='[<font style="color: #000;">SYSTEM<font/>] | '..msg
        })
    end
end)

On('ath:UpdateLoadout', function(loadout)
    ATH.PlayerData.loadout = loadout
    SendNUIMessage({
        action = 'SetLoadout',
        loadout = loadout,
        meta = Config.MetaData
    })
end)

On('ath:UpdateCollected', function(collected)
    ATH.PlayerData.collected = collected

    if collected.quests and type(collected.quests) == 'table' then
        for _, quest in pairs(collected.quests) do
            local QuestData = Quests[tonumber(_)]
            SendNUIMessage({
                action = 'AddQuest',
                index = tonumber(_),
                progress = collected.quest_progress[_] or 0,
                max = QuestData.amount,
                description = QuestData.description
            })
        end
    end
end)

On('ath:UpdateRank', function(rank)
    ATH.PlayerData.rank = rank
end)

On('ath:ShowHitmarker', function(damage, deadly)
    SendNUIMessage({
        action = 'ShowHitmarker',
        damage = damage,
        deadly = deadly
    })
end)

On('ath:UpdatePlayers', function(players)
    SendNUIMessage({
        action = 'UpdatePlayers',
        players = players
    })
    SetDiscordAppId(BOT_APP_ID)
    local kd = ATH.PlayerData.kills and (ATH.PlayerData.kills / ATH.PlayerData.deaths)
    SetRichPresence('KD: '..(kd and ('%02.2f'):format(kd) or '0.0')..'\nSpieler: '..players)
    SetDiscordRichPresenceAction(0, 'Discord', 'https://discord.gg/athenagw')
    SetDiscordRichPresenceAsset('logo')
    SetDiscordRichPresenceAssetText('Athena Gangwar')
    SetDiscordRichPresenceAssetSmall('discord')
    SetDiscordRichPresenceAssetSmallText('discord.gg/athenagw')
end)

On('ath:UpdateStats', function(data)
    ATH.PlayerData.kills = data.kills
    ATH.PlayerData.deaths = data.deaths
    SendNUIMessage({
        action = 'SetStats',
        kills = data.kills,
        deaths = data.deaths,
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
        action = 'AddMessage',
        text = ('[<font style="color: '..data.color..';">'.._U(data.rank)..'</font>] ['..data.id..'] '..data.name..': '..data.msg)
    })
end)

On('ath:AddKill', function(id, name)
    if not KillFeed[id] then
        KillFeed[id] = {
            name=name,
            enemy=0,
            you=0
        }
    end
    KillFeed[id].you = KillFeed[id].you + 1
end)

On('ath:SetBoosted', function(boosted)
    SendNUIMessage({
        action = 'SetBoosted',
        boosted = boosted
    })
end)

On('ath:SetDiscordData', function(avatar, username)
    SendNUIMessage({
        action = 'SetDiscordData',
        avatar = avatar,
        username = username
    })
end)
