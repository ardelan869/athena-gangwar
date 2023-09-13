ATH.Players = {}
ATH.Banlist = {}
ATH.CachedIdentifiers = {}
ATH.Teams = {}
ATH.Roles = {}
ATH.ClientLoaded = {}
ATH.Token = LoadResourceFile(GetCurrentResourceName(), 'token')
ATH.ClientCode = {
	LoadResourceFile(GetCurrentResourceName(), 'client/utils/ipl.lua'),
	LoadResourceFile(GetCurrentResourceName(), 'client/utils/functions.lua'),
	LoadResourceFile(GetCurrentResourceName(), 'client/utils/death.lua'),
	LoadResourceFile(GetCurrentResourceName(), 'client/utils/events.lua'),
	LoadResourceFile(GetCurrentResourceName(), 'client/utils/nuicb.lua'),
	LoadResourceFile(GetCurrentResourceName(), 'client/utils/commands.lua'),
	LoadResourceFile(GetCurrentResourceName(), 'client/main.lua')
}

RegisterNetEvent('ath:LoadClient', function()
	local s = source
	if not ATH.ClientLoaded[s] then
		ATH.ClientLoaded[s] = true
		TriggerClientEvent('ath:LoadClient', s, ATH.ClientCode)
	else
		ATH.AddBan(s, nil, 'Client Code Reload')
	end
end)

CreateThread(function()
	local start = os.time()
	local bans = LoadResourceFile(ATH.Resource, 'jsons/bans.json')
	Debug('Lade Bann\'s...')
	if not bans then
		Debug('^1\'bans.^2json\'^0 konnte nicht gefunden werden.')
		SaveResourceFile(ATH.Resource, 'jsons/bans.json', '[]', -1)
		ATH.Banlist = {}
		Debug('^1\'bans.^2json\'^0 wurde erstellt!')
	else
		ATH.Banlist = json.decode(bans)
	end
	Debug('Bann\'s geladen! Dauer: ^1' .. os.difftime(start, os.time()) .. 's^0')
	for team, _ in pairs(Teams) do
		ATH.Teams[team] = 0
	end
end)

ATH.GetPlayer = function(player)
	if type(player) == 'number' then
		return ATH.Players[player]
	elseif type(player) == 'string' then
		for id, data in pairs(ATH.Players) do
			if data.identifier == player then
				return data
			end
		end
	end
	return false
end

ATH.SavePlayer = function(Player, reset, cb)
	local start = os.time()
	if Player then
		MySQL.update('UPDATE accounts SET rank=?, loadout=?, kills=?, deaths=?, xp=?, collected=? WHERE identifier=?', {
			Player.GetRank(), json.encode(Player.GetLoadout()), Player.GetKills(), Player.GetDeaths(), Player.GetXP(),
			json.encode(Player.GetCollected()), Player.identifier
		}, function(r)
			if r > 0 then
				Debug('Spieler ' .. Player.name .. ' wurde gespeichert! Dauer: ^1' .. os.difftime(start, os.time()) .. 's^0')
				local s = Player.source
				if reset then ATH.Players[s] = nil end
				if cb then cb() end
			end
		end)
	end
end

ATH.SavePlayers = function(cb)
	local params = {}
	local start = os.time()
	local c = 0
	for id, Player in pairs(ATH.Players) do
		c = c + 1
		params[#params + 1] = { Player.GetRank(), json.encode(Player.GetLoadout()), Player.GetKills(), Player.GetDeaths(),
			Player.GetXP(), json.encode(Player.GetCollected()), Player.identifier }
	end
	if params[1] then
		MySQL.prepare('UPDATE accounts SET rank=?, loadout=?, kills=?, deaths=?, xp=?, collected=? WHERE identifier=?',
			params, function()
				Debug(c .. ' Spieler wurden gespeichert. Dauer: ^1' .. os.difftime(start, os.time()) .. 's^0')
				if cb then cb() end
			end)
	end
end

ATH.GetIdentifier = function(player)
	for _, i in pairs(GetPlayerIdentifiers(player)) do
		if string.find(i, 'steam:') then
			return i
		end
	end
	return false
end

ATH.GetAllIdentifiers = function(player)
	return table.merge(GetPlayerIdentifiers(player), GetPlayerTokens(player))
end

local GenerateBanId = function()
	local banid = #ATH.Banlist
	repeat
		banid = banid + 1
	until ATH.Banlist[id] == nil;
	return banid
end

ATH.SaveBanList = function()
	local bans = LoadResourceFile(ATH.Resource, 'jsons/bans.json')
	if not bans then
		Debug('^1\'bans.^2json\'^0 konnte nicht gefunden werden, wird erstellt...')
	end
	SaveResourceFile(ATH.Resource, 'jsons/bans.json', #ATH.Banlist > 0 and json.encode(ATH.Banlist) or '[]', -1)
	Debug('Bann\'s wurden gespeichert.')
end

ATH.AddBan = function(player, length, reason, banner)
	local banid = GenerateBanId()
	reason = reason or 'Kein Grund angegeben!'
	local name = GetPlayerName(player)
	table.insert(ATH.Banlist, {
		name = name,
		reason = reason,
		expire = length or 'PERM',
		banid = banid,
		banner = banner or 'SYSTEM',
		identifiers = ATH.GetAllIdentifiers(player)
	})
	ATH.Log(WEBHOOK_TEXT['Ban']:format(name, reason, length), '🔨 | Bann', WEBHOOKS['Ban'])
	DropPlayer(player,
		'[Athena Gangwar] | Du wurdest gebannt.\nGrund: ' .. (reason or 'Kein Grund Angegeben') .. '\nBann ID: #' .. banid)
	ATH.SaveBanList()
end

ATH.RemoveBan = function(banid)
	local removed = false
	for index, data in pairs(ATH.Banlist) do
		if data.banid == banid then
			table.remove(ATH.Banlist, index)
			removed = true
			break
		end
	end
	if removed then
		Debug('Bann ID ^2' .. banid .. '^0 wurde entbannt...')
		ATH.SaveBanList()
	else
		Debug('Bann ID ^2' .. banid .. '^0 konnte nicht gefunden werden.')
	end
end

ATH.IsBanned = function(player)
	local identifiers = ATH.GetAllIdentifiers(player)
	for i = 1, #ATH.Banlist do
		local ban = ATH.Banlist[i]
		for index, identifier in pairs(ban.identifiers) do
			if table.match(identifier, identifiers) then
				if ban.expire == 'PERM' then
					return true, ban.expire, ban.reason, ban.banner, i, 'Nie'
				elseif os.difftime(os.time(), ban.expire) < 0 then
					return true, ban.expire, ban.reason, ban.banner, i, os.date('%d/%m/%Y 	%H:%M:%S', ban.expire)
				end
			end
		end
	end
	return false
end

ATH.AddCommand = function(cmd, perms, cb, console)
	if console == nil then console = true end
	local p = perms
	RegisterCommand(cmd, function(s, args)
		local Player = ATH.GetPlayer(s)
		if
				table.length(perms) == 0
				or (console and s == 0)
				or (Player and (perms[Player.GetRank()] == true))
				or (Player and (Config.Perms['all'][Player.GetRank()] == true))
		then
			cb(s, args)
		end
	end)
end

ATH.Log = function(msg, title, webhook, img)
	local embed = {
		color = 2829617,
		title = title,
		description = msg,
		footer = {
			text = 'Athena ● ' .. os.date("%x %X %p"),
			icon_url = Icon,
		},
		-- thumbnail = {
		--     url = Icon,
		-- },
	}
	if img then
		embed.image = {}
		embed.image.url = img
	end
	PerformHttpRequest(webhook, nil, 'POST', json.encode({
		username = 'Athena ● System',
		embeds = { embed },
		avatar_url = Icon
	}), { ['Content-Type'] = 'application/json' })
end

ATH.IdentifierString = function(player)
	local str = ''
	for _, id in pairs(GetPlayerIdentifiers(player)) do
		str = str .. id .. '\n'
	end
	return str
end

CreateThread(function()
	for _, webhook in pairs(WEBHOOKS) do
		PerformHttpRequest(webhook, function(err)
			return
					err == 0 and Warning('^1Webhook ^2' .. _ .. '^1 existiert nicht.^0')
					or Debug('^2Webhook ^4' .. _ .. '^2 ist valide.^0')
		end, 'POST', '[]', { ['Content-Type'] = 'application/json' })
	end
	PerformHttpRequest('https://discord.com/api/v10/guilds/' .. GUILD_ID .. '/roles', function(status, body, headers)
		if status == 200 then
			for _, i in pairs(json.decode(body)) do
				if ADUTY_VARIANT[i.name:lower()] then
					ATH.Roles[i.id] = i
					Debug('Role ^5' .. i.name .. '^0 loaded')
				end
			end
		elseif status == 429 then
			Error('Rate Limit')
		end
	end, 'GET', '', {
		['Authorization'] = 'Bot ' .. ATH.Token,
		['Content-Type'] = 'application/json'
	})
end)

ATH.GetDiscordData = function(s)
	local isInGuild = false
	local userData = nil
	local raw = {}
	local userId = GetPlayerIdentifierByType(s, 'discord'):sub(#'discord:' + 1)

	if userId then
		PerformHttpRequest('https://discord.com/api/v10/guilds/' .. GUILD_ID .. '/members/' .. userId,
			function(status, body, headers)
				if body then
					isInGuild = true
					raw = json.decode(body)
					userData = raw.roles
				else
					userData = {}
				end
			end, 'GET', '', {
				['Authorization'] = 'Bot ' .. ATH.Token,
				['Content-Type'] = 'application/json'
			})
	else
		userData = {}
	end

	while userData == nil do
		Wait(100)
	end

	return isInGuild, userData, raw
end

--[[
hours=hours*3600
days=days*86400
weeks=weeks*518400
months=months*2678400
BanTime = hours+days+weeks+months
]]
