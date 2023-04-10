local isTurning = false

RegisterNUICallback('close', function()
	ATH.PlayerData.forceHud = false
	SetNuiFocus(false, false)
	ATH.ApplyClothes()
end)

RegisterNUICallback('FetchClothing', function(data, cb)
	cb(Teams[data.team])
end)

RegisterNUICallback('FetchPieces', function(data, cb)
	cb(Teams[ATH.PlayerData.team])
end)

local ownOutfit = {}
RegisterNUICallback('SaveClothes', function(data, cb)
	SetNuiFocus(false, false)
	for cat, data in pairs(ownOutfit) do
		for _, cloth in pairs(ATH.PlayerData.clothes) do
			if cloth.componentId == data.componentId then
				local isDrop = cloth.isDrop
				if isDrop == nil then isDrop = false end
				if isDrop == data.isDrop then
					ATH.PlayerData.clothes[_] = data
					goto continue
				end
			end
		end
		ATH.PlayerData.clothes[#ATH.PlayerData.clothes+1] = data
		::continue::
	end
	ATH.ApplyClothes()
	SetResourceKvp(ATH.PlayerData.team..'_clothes', json.encode(ATH.PlayerData.clothes))
	ATH.PlayerData.forceHud = false
end)

RegisterNUICallback('SelectPiece', function(data, cb)
	local isDrop = (data.cat == 'earrings' or data.cat == 'glasses' or data.cat == 'hat')
	ownOutfit[data.cat] = {
		componentId=Config.Component[data.cat],
		drawableId=data.drawable,
		textureId=data.texture,
		isDrop = isDrop
	}
	if isDrop then
		SetPedPropIndex(ATH.PlayerData.ped, Config.Component[data.cat], data.drawable, data.texture, 2)
	else
		SetPedComponentVariation(ATH.PlayerData.ped, Config.Component[data.cat], data.drawable, data.texture, 2)
	end
end)

local firstTime = true
RegisterNUICallback('SelectClothing', function(data, cb)
	SetPedDefaultComponentVariation(ATH.PlayerData.ped)
	for i=0,2 do
		ClearPedProp(ATH.PlayerData.ped, i)
	end
	SetNuiFocus(false, false)
	ATH.PlayerData.team = data.team
	ATH.PlayerData.forceHud = false
	local rgb = Teams[data.team].color.rgb
	EmitNet('ath:UpdateTeam', data.team)
	ReplaceHudColourWithRgba(143, rgb.r, rgb.g, rgb.b, 255)
    ReplaceHudColourWithRgba(116, rgb.r, rgb.g, rgb.b, 255)
	ATH.PlayerData.clothes = Teams[data.team].clothes.outfits[tonumber(data.id)]
	ATH.ApplyClothes()
	ATH.PlayerData.forceHud = false
	SendNUIMessage({action='ClearGarage'})
	for i=1, #Vehicles do
		local veh = Vehicles[i]
		SendNUIMessage({
			action = 'AppendVehicle',
			color = Teams[data.team].color,
			name = veh.name,
			label = GetDisplayNameFromVehicleModel(GetHashKey(veh.name)),
			allowed = ATH.PlayerData.level >= veh.level,
			lvl = veh.level
		})
	end
	SetEntityCoords(ATH.PlayerData.ped, Teams[data.team].spawn)
	if firstTime then
		firstTime = false
		StartLoops()
	end
end)

RegisterNUICallback('SpawnCar', function(data, cb)
	ATH.PlayerData.forceHud = false
	SetNuiFocus(false, false)
	if DoesEntityExist(ATH.PlayerData.playerVeh) then
		DeleteVehicle(ATH.PlayerData.playerVeh)
	end
	local spawns = Teams[ATH.PlayerData.team].garage.spawns
	local c = spawns[math.random(1, #spawns)]
	ATH.PlayerData.playerVeh = ATH.SpawnCar(data.name, ATH.PlayerData.static, vector3(c.x,c.y,c.z), c.w)
end)

RegisterNUICallback('chat', function(data, cb)
	SetNuiFocus(false, false)
	if data.message:sub(1,1) == '/' then
		ExecuteCommand(data.message:sub(2))
	elseif #data.message > 1 then
		EmitNet('ath:SendMessage', {
			rank=ATH.PlayerData.rank,
			name=ATH.PlayerData.name,
			color=Config.ChatColors[ATH.PlayerData.rank] or '#FFF',
			id=ATH.PlayerData.source,
			msg=data.message
		})
	end
end)

local isTurning = false
RegisterNUICallback('TurnOn', function(data, cb)
	isTurning = true
	while isTurning do
		local h = GetEntityHeading(ATH.PlayerData.ped)
		if data.l then
			SetEntityHeading(ATH.PlayerData.ped, h-0.3)
		else
			SetEntityHeading(ATH.PlayerData.ped, h+0.3)
		end
		Wait(1)
	end
end)

RegisterNUICallback('TurnOff', function(data, cb)
	isTurning = false
end)