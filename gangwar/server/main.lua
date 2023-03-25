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
	ATH.SavePlayer(Player, true)
	ATH.Log()
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
			local Player = CreatePlayer(identifier, s, json.decode(r.loadout), name, r.rank)
			ATH.Players[s] = Player
			TriggerEvent('ath:PlayerJoined', s, Player)
			Player.Emit('ath:PlayerJoined', Player)
		else
			MySQL.insert('INSERT INTO accounts (username, identifier) VALUES (?, ?)', {name, identifier})
			local Player = CreatePlayer(identifier, s)
			ATH.Players[s] = Player
			TriggerEvent('ath:PlayerJoined', s, Player)
			TriggerEvent('ath:CreateName', s, Player)
			Player.Emit('ath:PlayerJoined', Player)
		end
	end)
end)

RegisterNetEvent('ath:OnPlayerDeath', function(data)
	local s = source
end)

RegisterNetEvent('ath:OnPlayerRevive', function()
	local s = source
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
	if ATH.Players[target] > 0 then
		TriggerClientEvent('ath:ShowHitmarker', s, args.weaponDamage)
	end
    -- if IsPedAPlayer(NetworkGetEntityFromNetworkId(args.hitGlobalId)) then
    --     if (args.weaponDamage > 36) then
    --         if not args.hasVehicleData then
    --             if args.damageType == 3 then
    --                 if not IgnoredWeapons[args.weaponType] then
    --                     if args.weaponDamage ~= 9999 and args.weaponDamage ~= 500 and args.weaponDamage ~= 200 and args.weaponDamage ~= 30 and args.weaponDamage ~= 50 and args.weaponDamage ~= 71 and args.weaponDamage ~= 58 then
    --                         BanPlayer(s, 'Damage Mutliplier')
    --                     end
    --                 end
    --             end
    --         end
    --     end
    -- end
end)