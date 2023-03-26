RegisterNUICallback('close', function()
	ATH.PlayerData.forceHud = false
	SetNuiFocus(false, false)
end)

RegisterNUICallback('FetchClothing', function(data, cb)
	cb(Teams[data.team])
end)

local firstTime = true
RegisterNUICallback('SelectClothing', function(data, cb)
	SetNuiFocus(false, false)
	ATH.PlayerData.team = data.team
	EmitNet('ath:UpdateTeam', data.team)
	local rgb = Teams[data.team].color.rgb
	ReplaceHudColourWithRgba(143, rgb.r, rgb.g, rgb.b, 255)
    ReplaceHudColourWithRgba(116, rgb.r, rgb.g, rgb.b, 255)
	ATH.PlayerData.clothes = Teams[data.team].clothes[tonumber(data.id)]
	ATH.PlayerData.forceHud = false
	for _, cloth in pairs(ATH.PlayerData.clothes) do
		SetPedComponentVariation(
			ATH.PlayerData.ped, 
			cloth.componentId, 
			cloth.drawableId, 
			cloth.textureId, 
			cloth.paletteId
		)
	end
	SetEntityCoords(ATH.PlayerData.ped, Teams[data.team].spawn)
	if firstTime then
		firstTime = false
		StartLoops()
	end
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