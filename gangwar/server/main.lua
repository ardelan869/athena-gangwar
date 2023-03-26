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

RegisterNetEvent('ath:PlayerReady', function()
	local s = source
	local name = GetPlayerName(s)
	local identifier = ATH.GetIdentifier(s)
	MySQL.query('SELECT * FROM accounts WHERE identifier=?', {identifier}, function(_r)
		if #_r > 0 then
			local r = _r[1]
			MySQL.update('UPDATE accounts SET username=? WHERE identifier=?', {name, identifier})
			local Player = CreatePlayer(identifier, s, json.decode(r.loadout), name, r.rank, r.kills, r.deaths, r.xp)
			ATH.Players[s] = Player
			TriggerEvent('ath:PlayerJoined', s, Player)
			Player.Emit('ath:PlayerJoined', Player, ATH.Teams)
		else
			MySQL.insert('INSERT INTO accounts (username, identifier) VALUES (?, ?)', {name, identifier})
			local Player = CreatePlayer(identifier, s)
			ATH.Players[s] = Player
			TriggerEvent('ath:PlayerJoined', s, Player)
			TriggerEvent('ath:CreateName', s, Player)
			Player.Emit('ath:PlayerJoined', Player, ATH.Teams)
		end
	end)
end)

RegisterNetEvent('ath:OnPlayerDeath', function(data)
	local s = source
	if data.killerServerId then
		local Source = ATH.GetPlayer(s)
		local Killer = ATH.GetPlayer(data.killerServerId)
		Source.AddDeath()
		Killer.AddKill()
		if Killer.Get('team') == Source.Get('team') then
			Killer.RemoveXP('Teamkill')
		else
			Killer.AddXP('Kill')
		end
		TriggerClientEvent('ath:UpdateStats', s, {
			kills=Source.GetKills(),
			deaths=Source.GetDeaths()
		})
		TriggerClientEvent('ath:UpdateStats', data.killerServerId, {
			kills=Killer.GetKills(),
			deaths=Killer.GetDeaths()
		})
		TriggerClientEvent('ath:AddNotify', s, 'Du wurdest von '..GetPlayerName(data.killerServerId)..'['..data.killerServerId..'] gekillt!', 'DEATH', 3000, 'skull')
		TriggerClientEvent('ath:AddNotify', data.killerServerId, 'Du hast '..GetPlayerName(s)..'['..s..'] gekillt!', 'KILL', 3000, 'cross')
	end
end)

RegisterNetEvent('ath:SendMessage', function(data)
	TriggerClientEvent('ath:SendMessage', -1, data)
end)

CreateThread(function()
	while true do
		Wait(2500)
		TriggerClientEvent('ath:UpdatePlayers', -1, GetNumPlayerIndices())
	end
end)

AddEventHandler('weaponDamageEvent',function(source, args)
    local s = source
	local target = NetworkGetEntityOwner(NetworkGetEntityFromNetworkId(args.hitGlobalId))
	if ATH.Players[target] then
		TriggerClientEvent('ath:ShowHitmarker', s, args.weaponDamage, args.willKill)
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
	local s = source
	local identifier = ATH.GetIdentifier(s)
	local isbanned, expire, reason, banner, banid, date = ATH.IsBanned(s)
	deferrals.update('Checke Bann\'s...')
	if isbanned then
		deferrals.done(('\nDu wurdest von diesem server gebannt,\nGrund: %s,\nBann Läuft am %s ab\nDeine Bann-ID lautet #%s.\nGebannt von: %s'):format(reason, (type(expire) == 'number' and date or 'Permanent'), banid, banner))
	else
		if identifier then
			if not ATH.GetPlayer(identifier) then
				deferrals.done()
				TriggerEvent('ath:PlayerConnecting', s, name, __, deferrals)
			else
				deferrals.done('Es ist bereits jemand mit deinem Account drauf!\n\nIdentifier: '..identifier)
			end
		else
			deferrals.done('Du benötigst Steam, um auf diesen Server spielen zu können.')
		end
	end
end)

AddEventHandler('playerDropped', function()
	local s = source
	local Player = ATH.GetPlayer(s)
	if Player.Get('team') then
		ATH.Teams[Player.Get('team')] = ATH.Teams[Player.Get('team')]-1
		TriggerClientEvent('ath:UpdateTeams', -1, ATH.Teams)
	end
	ATH.SavePlayer(Player, true)
end)