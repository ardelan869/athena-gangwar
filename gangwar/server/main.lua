-- MySQL.ready(function()
--     MySQL.query([[CREATE DATABASE IF NOT EXISTS `athena`;
-- USE `athena`;

-- CREATE TABLE IF NOT EXISTS `accounts` (
--   `id` int(255) NOT NULL AUTO_INCREMENT,
--   `username` varchar(255) DEFAULT NULL,
--   `identifier` varchar(255) DEFAULT NULL,
--   `loadout` longtext DEFAULT '[]',
--   `rank` varchar(255) DEFAULT NULL,
--   `xp` int(255) DEFAULT NULL,
--   `kills` int(255) DEFAULT 0,
--   `deaths` int(255) DEFAULT 0,
--   `collected` longtext DEFAULT '{"free":{},"premium":{}}',
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `id` (`id`),
--   KEY `username` (`username`),
--   KEY `identifier` (`identifier`),
--   KEY `loadout` (`loadout`(768)),
--   KEY `rank` (`rank`),
--   KEY `xp` (`xp`),
--   KEY `kills` (`kills`),
--   KEY `deaths` (`deaths`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;]])
-- end)

RegisterNetEvent('ath:UpdateTeam', function(team)
    local s = source
    local Source = ATH.GetPlayer(s)
    local oldTeam = Source.Get('team')
    if oldTeam then
        ATH.Teams[oldTeam] = ATH.Teams[oldTeam] - 1
    end
    Source.Set('team', team)
    ATH.Teams[team] = ATH.Teams[team] + 1
    TriggerClientEvent('ath:UpdateTeams', -1, ATH.Teams)
end)

RegisterNetEvent('ath:Alone', function(reason)
    local s = source
    ATH.AddBan(s, 'PERM', reason)
end)

RegisterNetEvent('ath:Kobold', function(data)
    local s = source
    local Source = ATH.GetPlayer(s)
    Source.Collect(data.type, data.index)

    if data.type == 'quests' then
        Source.AddXP(Quests[data.index].reward)
    else
        local Reward = Rewards[data.type][data.index]
        if Reward.type == 'weapon' then
            Source.AddWeapon(Reward.name:upper())
        elseif Reward.type == 'xp' then
            Source.AddXP(Reward.amount)
        end
    end
end)

RegisterNetEvent('ath:PlayerReady', function()
    local s = source
    local name = GetPlayerName(s)
    local identifier = ATH.GetIdentifier(s)
    MySQL.query('SELECT * FROM accounts WHERE identifier=?', { identifier }, function(_r)
        if #_r > 0 then
            local r = _r[1]
            MySQL.update('UPDATE accounts SET username=? WHERE identifier=?', { name, identifier })
            local Player = CreatePlayer(identifier, s, json.decode(r.loadout), name, r.rank, r.kills, r.deaths, r.xp,
                r.id, json.decode(r.collected))
            ATH.Players[s] = Player
            TriggerEvent('ath:PlayerJoined', s, Player)
            Player.Emit('ath:PlayerJoined', Player, ATH.Teams)
        else
            MySQL.insert('INSERT INTO accounts (username, identifier) VALUES (?, ?)', { name, identifier }, function(r)
                local Player = CreatePlayer(identifier, s, Config.StartWeapons, name, false, false, false, false, r, {})
                ATH.Players[s] = Player
                TriggerEvent('ath:PlayerJoined', s, Player)
                Player.Emit('ath:PlayerJoined', Player, ATH.Teams)
            end)
        end
    end)
end)

AddEventHandler('ath:PlayerJoined', function(source, Source)
    local __, roles, raw = ATH.GetDiscordData(source)
    if roles and roles[1] then
        local role = roles[1]:lower()
        if ATH.Roles[role] then
            Source.SetRank(ATH.Roles[role].name:lower())
        end

        local avatar = 'https://cdn.discordapp.com/avatars/' .. raw.user.id .. '/' .. raw.user.avatar .. '.png'
        Source.Emit('ath:SetDiscordData', avatar, raw.user.username)
        for _, role in pairs(roles) do
            if role == Config.BoosterRole then
                return Source.Emit('ath:SetBoosted', true)
            end
        end
        return Source.Emit('ath:SetBoosted', false)
    end
end)

exports('SetRank', function(s, rank)
    ATH.GetPlayer(tonumber(s)).SetRank(rank)
end)

RegisterNetEvent('ath:OnPlayerDeath', function(data)
    local s = source
    local idString = ATH.IdentifierString(s)
    local target = data.killerServerId
    if target then
        local Source = ATH.GetPlayer(s)
        local Killer = ATH.GetPlayer(target)
        Source.AddDeath()
        Killer.AddKill(s, GetPlayerName(s))
        if Killer.Get('team') == Source.Get('team') then
            Killer.RemoveXP('Teamkill')
        else
            Killer.AddXP('Kill')
        end
        TriggerClientEvent('ath:UpdateStats', s, {
            kills = Source.GetKills(),
            deaths = Source.GetDeaths()
        })
        TriggerClientEvent('ath:UpdateStats', target, {
            kills = Killer.GetKills(),
            deaths = Killer.GetDeaths()
        })
        TriggerClientEvent('ath:AddNotify', s,
            'Du wurdest von ' .. GetPlayerName(target) .. '[' .. target .. '] gekillt!', 'DEATH', 3000, 'skull')
        TriggerClientEvent('ath:AddNotify', target, 'Du hast ' .. GetPlayerName(s) .. '[' .. s .. '] gekillt!', 'KILL',
            3000, 'cross')
        ATH.Log(('%s\nLoser:\n```%s```\nKiller:\n```%s```'):format(
            WEBHOOK_TEXT['Kill']:format(GetPlayerName(s), GetPlayerName(target), data.deathCause),
            idString,
            ATH.IdentifierString(target)
        ), '🔫 | Kill', WEBHOOKS['Kill'])
    end
end)

RegisterNetEvent('ath:SendMessage', function(data)
    TriggerClientEvent('ath:SendMessage', -1, data)
end)

RegisterNetEvent('ath:SetDimension', function(dim)
    SetPlayerRoutingBucket(source, tonumber(dim))
end)

CreateThread(function()
    while true do
        Wait(2500)
        TriggerClientEvent('ath:UpdatePlayers', -1, GetNumPlayerIndices())
    end
end)

AddEventHandler('weaponDamageEvent', function(source, args)
    local s = tonumber(source)
    local entity = NetworkGetEntityFromNetworkId(args.hitGlobalId)
    local target = NetworkGetEntityOwner(entity)
    if ATH.Players[target] and IsPedAPlayer(entity) then
        TriggerClientEvent('ath:ShowHitmarker', s, args.weaponDamage, args.willKill)
        local Player = ATH.GetPlayer(s)
        local Collected = Player.GetCollected()
        for index, bool in pairs(Collected.quests) do
            local Quest = Quests[tonumber(index)]
            if Quest.type == 'kills' then
                if
                    args.willKill and
                    (Collected.quest_progress[index] or 0) < Quest.amount
                then
                    Player.Progress(index, Quest.amount)
                end
            elseif Quest.type == 'headshot_kill' then
                if
                    args.willKill and
                    args.hitComponent == 20 and
                    (Collected.quest_progress[index] or 0) < Quest.amount
                then
                    Player.Progress(index, Quest.amount)
                end
            elseif Quest.type == 'headshot_hit' then
                if
                    args.hitComponent == 20 and
                    (Collected.quest_progress[index] or 0) < Quest.amount
                then
                    Player.Progress(index, Quest.amount)
                end
            end
        end

        -- args.willKill
        -- args.hitComponent == 20 -- headshot
        -- args.damageType == 3
    end
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 60 then
        Wait(50000)
        ATH.SavePlayers()
    end
end)

AddEventHandler('txAdmin:events:serverShuttingDown', function()
    ATH.SavePlayers()
end)

AddEventHandler('playerConnecting', function(name, __, deferrals)
    deferrals.defer()
    local s = source
    local identifier = ATH.GetIdentifier(s)
    local isInGuild, __ = ATH.GetDiscordData(s)
    local isbanned, expire, reason, banner, banid, date = ATH.IsBanned(s)
    ATH.Log(('%s\n```%s```'):format(
        WEBHOOK_TEXT['Join']:format(name), ATH.IdentifierString(s)
    ), '👋 | Join', WEBHOOKS['Join'])
    deferrals.update('Checke Bann\'s...')
    if isbanned then
        deferrals.done(('\nDu wurdest von diesem server gebannt,\nGrund: %s,\nBann Läuft am %s ab\nDeine Bann-ID lautet #%s.\nGebannt von: %s')
        :format(reason, (type(expire) == 'number' and date or 'Permanent'), banid, banner))
    else
        if identifier then
            if ATH.GetPlayer(identifier) then
                deferrals.done('Es ist bereits jemand mit deinem Account drauf!\n\nIdentifier: ' .. identifier)
            else
                if isInGuild then
                    deferrals.done()
                    TriggerEvent('ath:PlayerConnecting', s, name, __, deferrals)
                else
                    deferrals.done(
                    'Du musst auf dem Discord sein um den Server betreten zu können https://discord.gg/athenagw')
                end
            end
        else
            deferrals.done('Du benötigst Steam, um auf diesen Server spielen zu können.')
        end
    end
end)

AddEventHandler('playerDropped', function()
    local s = source
    local Player = ATH.GetPlayer(s)
    ATH.Log(('%s\n```%s```'):format(
        WEBHOOK_TEXT['Leave']:format(GetPlayerName(s)), ATH.IdentifierString(s)
    ), '🚪 | Leave', WEBHOOKS['Leave'])
    if Player and Player.Get('team') then
        ATH.Teams[Player.Get('team')] = ATH.Teams[Player.Get('team')] - 1
        TriggerClientEvent('ath:UpdateTeams', -1, ATH.Teams)
    end
    ATH.SavePlayer(Player, true)
end)
