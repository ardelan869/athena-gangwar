function CreatePlayer(identifier, source, loadout, name, rank)
	local player = {}
	player.identifier = identifier
	player.source = source
	player.name = name or false
	player.loadout = loadout or {}
	player.rank = rank or 'user'
	ATH.CachedIdentifiers[player.source] = ATH.GetAllIdentifiers(player.source)

	player.Emit = function(event, ...)
		TriggerClientEvent(event, player.source, ...)
	end

	player.AddNotify = function(text, title, time, icon)
		player.Emit("ath:AddNotify", text, title, time, icon)
	end

	player.Set = function(key, value)
		player[key] = value
	end

	player.Get = function(key)
		return player[key]
	end

	player.SetRank = function(rank)
		player.rank = rank
		player.Emit('ath:UpdateRank', rank)
	end

	player.GetRank = function()
		return player.rank
	end

	player.GetLoadout = function()
		return player.loadout
	end

	player.GetWeapon = function(w)
		local weapon = w:upper()
		return player.loadout[weapon]
	end

	player.AddWeapon = function(w, comps)
		local weapon = w:upper()
		player.loadout[weapon] = {
			components = comps or {}
		}
		GiveWeaponToPed(GetPlayerPed(player.source), GetHashKey(weapon), 9999, false, false)
		player.Emit("ath:UpdateLoadout", player.loadout)
	end

	player.RemoveWeapon = function(w)
		local weapon = w:upper()
		RemoveWeaponFromPed(GetPlayerPed(player.source), GetHashKey(weapon))
		local newTable = {}
		for _weapon, data in pairs(player.loadout) do
			if _weapon ~= weapon then
				newTable[_weapon] = data
			end
		end
		player.loadout = newTable
		player.Emit("ath:UpdateLoadout", player.loadout)
	end

	player.AddComponent = function(w, component)
		local weapon = w:upper()
		local hash = Config.Components[weapon][component]
		table.insert(
			player.loadout[weapon].components,
			{
				name = component,
				hash = hash
			}
		)
		GiveWeaponComponentToPed(GetPlayerPed(player.source), GetHashKey(weapon), hash)
		player.Emit("ath:UpdateLoadout", player.loadout)
	end

	player.RemoveComponent = function(w, component)
		local weapon = w:upper()
		for index, data in pairs(player.loadout[weapon].components) do
			if type(component) == "number" and data.hash == component then
				RemoveWeaponComponentFromPed(GetPlayerPed(player.source), GetHashKey(weapon), hash)
				table.remove(player.loadout[weapon].components, index)
			elseif type(component) == "string" and data.name == component then
				RemoveWeaponComponentFromPed(GetPlayerPed(player.source), GetHashKey(weapon), hash)
				table.remove(player.loadout[weapon].components, index)
			end
		end
		player.Emit("ath:UpdateLoadout", player.loadout)
	end

	player.GetComponents = function(w)
		local weapon = w:upper()
		if player.loadout[weapon] then
			return player.loadout[weapon].components
		end
	end

	return player
end