local PlayerKilledByPlayer = function(killerServerId, killerClientId, deathCause)
	local victimCoords = GetEntityCoords(PlayerPedId())
	local killerCoords = GetEntityCoords(GetPlayerPed(killerClientId))
	local distance = #(victimCoords - killerCoords)

	local data = {
		victimCoords = {x = math.round(victimCoords.x, 1), y = math.round(victimCoords.y, 1), z = math.round(victimCoords.z, 1)},
		killerCoords = {x = math.round(killerCoords.x, 1), y = math.round(killerCoords.y, 1), z = math.round(killerCoords.z, 1)},

		killedByPlayer = true,
		deathCause = deathCause,
		distance = math.round(distance, 1),

		killerServerId = killerServerId,
		killerClientId = killerClientId
	}

	TriggerEvent('ath:OnPlayerDeath', data)
	TriggerServerEvent('ath:OnPlayerDeath', data)
	return data
end
local PlayerKilled = function(deathCause)
	local playerPed = PlayerPedId()
	local victimCoords = GetEntityCoords(playerPed)
	local data = {
		victimCoords = {x = math.round(victimCoords.x, 1), y = math.round(victimCoords.y, 1), z = math.round(victimCoords.z, 1)},

		killedByPlayer = false,
		deathCause = deathCause
	}

	TriggerEvent('ath:OnPlayerDeath', data)
	TriggerServerEvent('ath:OnPlayerDeath', data)
end
local deathCam = nil
local MakeDeathCam = function(ped, id)
	SendNUIMessage({
		action='ToggleKillfeed',
		bool=true,
		enemy=KillFeed[id].name,
		enemyp=KillFeed[id].enemy,
		you=ATH.PlayerData.name,
		youp=KillFeed[id].you
	})
	deathCam = CreateCam('DEFAULT_SCRIPTED_CAMERA')
	SetCamCoord(deathCam, GetOffsetFromEntityInWorldCoords(ped, 0.0, -1.6, 1.2))
	PointCamAtEntity(deathCam, ped, 0.0, 0.0, 0.0, 0)
	SetCamActive(deathCam, true)
	RenderScriptCams(true, false, 500, true, true)
	while ATH.PlayerData.isDead do
		SetCamCoord(deathCam, GetOffsetFromEntityInWorldCoords(ped, 0.0, -1.6, 1.2))
		PointCamAtEntity(deathCam, ped, 0.0, 0.0, 0.4, 0)
		SetCamActive(deathCam, true)
		Wait()
	end
	RenderScriptCams(0)
	DestroyCam(deathCam, true)
	SendNUIMessage({
		action='ToggleKillfeed',
		bool=false
	})
end
local std = {
	enemy = 0,
	you = 0
}

CreateThread(function()
	while not ATH.PlayerData.isSpawned do Wait() end
	while true do
		local sleep = 100
		local player = PlayerId()

		if NetworkIsPlayerActive(player) then
			local playerPed = ATH.PlayerData.ped

			if IsPedFatallyInjured(playerPed) and not ATH.PlayerData.isDead then
				sleep = 0
				ATH.PlayerData.isDead = true

				local killerEntity, deathCause = GetPedSourceOfDeath(playerPed), GetPedCauseOfDeath(playerPed)
				local killerClientId = NetworkGetPlayerIndexFromPed(killerEntity)

				if killerEntity ~= playerPed and killerClientId and NetworkIsPlayerActive(killerClientId) then
					local data = PlayerKilledByPlayer(GetPlayerServerId(killerClientId), killerClientId, deathCause)
					if not KillFeed[data.killerServerId] then
						local s = std
						std.name = GetPlayerName(data.killerClientId)
						KillFeed[data.killerServerId] = s
					end
					KillFeed[data.killerServerId].enemy = KillFeed[data.killerServerId].enemy + 1
					CreateThread(function()
						MakeDeathCam(killerEntity, data.killerServerId)
					end)
				else
					PlayerKilled(deathCause)
				end

				if ATH.PlayerData.isDead then
					Wait(3500)
					if ATH.PlayerData.isDead then
						ATH.RevivePed()
					end	
				end
			end
		end
	    Wait(sleep)
	end
end)