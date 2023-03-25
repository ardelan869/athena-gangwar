RegisterNUICallback('close', function()
	SetNuiFocus(false, false)
end)

RegisterNUICallback('FetchClothing', function(data, cb)
	cb(Teams[data.team])
end)

RegisterNUICallback('SelectClothing', function(data, cb)
	SetNuiFocus(false, false)
	ATH.PlayerData.team = data.team
	ATH.PlayerData.clothes = Teams[data.team].clothes[tonumber(data.id)]
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
    StartLoops()
end)
