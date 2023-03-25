ATH.Players = {}
ATH.Banlist = {}
ATH.CachedIdentifiers = {}

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
	Debug('Bann\'s geladen! Dauer: ^1'..os.difftime(start, os.time())..'s^0') 
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
	if Player then
		MySQL.update('UPDATE accounts SET rank=?, money=?, loadout=? WHERE identifier=?', {
			Player.GetRank(), Player.GetMoney(), json.encode(Player.GetLoadout()), Player.identifier
		}, function(r)
			if r > 0 then
				Debug('Spieler '..Player.name..' wurde gespeichert!')
				local s = Player.source
				if reset and ATH.Players[s] then
					ATH.Players[s] = nil
				end
				if cb then
					cb()
				end
			end
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
	local identifiers = GetPlayerIdentifiers(player)
	for i=0,GetNumPlayerTokens(player) do
		table.insert(identifiers, GetPlayerToken(player, i))
	end
	return identifiers
end

local GenerateBanId = function()
	local banid = #ATH.Banlist
	repeat
		banid = banid+1
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
	table.insert(ATH.Banlist, {
		name = GetPlayerName(player),
		reason = reason,
		expire = length or 'PERM',
		banid = banid,
		banner = banner or 'SYSTEM',
		identifiers = ATH.GetAllIdentifiers(player)
	})
	DropPlayer(player, '[Athena Gangwar] | Du wurdest gebannt.\nGrund: '..(reason or 'Kein Grund Angegeben')..'\nBann ID: #'..banid)
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
		Debug('Bann ID ^2'..banid.. '^0 wurde entbannt...')
		ATH.SaveBanList()
	else
		Debug('Bann ID ^2'..banid.. '^0 konnte nicht gefunden werden.')
	end
end
 
ATH.IsBanned = function(player)
	local identifiers = ATH.GetAllIdentifiers(player)
	for i=1, #ATH.Banlist do
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
        if table.length(perms) == 0 or ((console and s == 0) or (Player and perms[Player.GetRank()]) or (Player and Config.Perms['all'][Player.GetRank()])) then
            cb(s, args)
        end
    end)
end

ATH.Log = function()
end

--[[
hours=hours*3600
days=days*86400
weeks=weeks*518400
months=months*2678400
BanTime = hours+days+weeks+months
]]