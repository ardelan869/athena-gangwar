CreateThread(function()
    while true do
        Wait(0)
        if NetworkIsPlayerActive(PlayerId()) then
            DoScreenFadeOut(0)
            Wait(500)
            EmitNet('ath:PlayerReady')
            Emit('ath:PlayerReady')
            break
        end
    end
end)

local AppendTeams = function()
    for name, team in pairs(Teams) do
        local msg = team
        msg.action = 'AppendFrak'
        SendNUIMessage(msg)
    end
    SendNUIMessage({
        action = 'ToggleHUD',
        bool = false
    })
    SendNUIMessage({
        action = 'ToggleFraction',
        which = '.factions',
        bool = true
    })
    SetNuiFocus(true, true)
end

local CreateDefaultPed = function()
    local defaultModel = GetHashKey('mp_m_freemode_01')
    while not HasModelLoaded(defaultModel) do
        RequestModel(defaultModel)Wait()
    end
    firstspawn = true
    SetPlayerModel(PlayerId(), defaultModel)
    for i = 0, 19 do
        SetPedComponentVariation(PlayerPedId(), 0, i, 0, 0)
    end
    SetModelAsNoLongerNeeded(defaultModel)
    SetEntityCoordsNoOffset(PlayerPedId(), vector3(-1.5, 19.2501, 71.1215))
    SetEntityHeading(PlayerPedId(), 0.0)
    ShutdownLoadingScreen()
    FreezeEntityPosition(PlayerPedId(), false)
    AppendTeams()
    DoScreenFadeIn(1000)
    ResurrectPed(PlayerPedId())
    SetPlayerTargetingMode(2)
    SetPedInfiniteAmmo(PlayerPedId(), true)
    ATH.PlayerData.ped = PlayerPedId()
    ATH.PlayerData.playerId = PlayerId()
    ATH.PlayerData.isSpawned = true
end

local AddWeapons = function(loadout)
    RemoveAllPedWeapons(ATH.PlayerData.ped, 0)
    for weapon, data in pairs(loadout) do
        local weaponHash = GetHashKey(weapon)
        GiveWeaponToPed(ATH.PlayerData.ped, weaponHash, data.ammo, true, false)
        if data.components and #data.components > 0 then
            for index, component in pairs(data.components) do
                GiveWeaponComponentToPed(ATH.PlayerData.ped, weaponHash, component.hash)
            end
        end
    end
end 

On('ath:PlayerJoined', function(data)
    ATH.PlayerData = data
    ATH.PlayerData.ped = nil
    ATH.PlayerData.isSpawned = false
    ATH.PlayerData.playerId = nil
    ATH.PlayerData.isDead = false
    ATH.PlayerData.isDuty = false
    ATH.PlayerData.skin = false

    CreateDefaultPed(data.coords)
    SetEntityHealth(ATH.PlayerData.ped, 200)
    SetPedArmour(ATH.PlayerData.ped, 100)
    AddWeapons(ATH.PlayerData.loadout)
    NetworkSetFriendlyFireOption(true)

    while not ATH.PlayerData.isSpawned do Wait() end

    SetEntityVisible(PlayerPedId(), true, false)
    SetLocalPlayerAsGhost(false)
    SetEntityInvincible(PlayerPedId(), false)

    SendNUIMessage({
        action='SetId',
        id=GetPlayerServerId(ATH.PlayerData.playerId)
    })
end)

function StartLoops()
    ATH.LoadAnim('missarmenian2')
    SetPedConfigFlag(ATH.PlayerData.ped, 35, false) -- PutOnMotorcycleHelmet
    SetCanAttackFriendly(ATH.PlayerData.ped, true, false)
    SetPlayerCanUseCover(ATH.PlayerData.ped, false)
    StatSetInt(GetHashKey('MP0_SHOOTING_ABILITY'), 100, true)
    StatSetInt(GetHashKey('MP0_STEALTH_ABILITY'), 100, true)
    StatSetInt(GetHashKey('MP0_FLYING_ABILITY'), 100, true)
    StatSetInt(GetHashKey('MP0_WHEELIE_ABILITY'), 100, true)
    StatSetInt(GetHashKey('MP0_LUNG_CAPACITY'), 100, true)
    StatSetInt(GetHashKey('MP0_STRENGTH'), 100, true)
    StatSetInt(GetHashKey('MP0_STAMINA'), 100, true)
    ReplaceHudColourWithRgba(143, 255, 255, 255, 255)
    ReplaceHudColourWithRgba(116, 255, 255, 255, 255)
    SetPedSuffersCriticalHits(ATH.PlayerData.ped, false)
    StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')
    for k=1,9 do
        SetHudComponentPosition(k,999999.0,999999.0)
    end

    CreateThread(function()
        local ticks = 0
        while ATH.PlayerData.isSpawned do
            SetPlayerWeaponDamageModifier(ATH.PlayerData.playerId, 0.45)
            ATH.PlayerData.ped = PlayerPedId()
            ATH.PlayerData.playerId = PlayerId()
            local pos = GetEntityCoords(ATH.PlayerData.ped)
            ATH.PlayerData.street = GetStreetNameFromHashKey(GetStreetNameAtCoord(pos.x, pos.y, pos.z))
            if IsPedInAnyVehicle(ATH.PlayerData.ped, false) then
                ATH.PlayerData.veh = GetVehiclePedIsIn(ATH.PlayerData.ped, false)
                ATH.PlayerData.vehModel = GetEntityModel(ATH.PlayerData.veh)
            else
                ATH.PlayerData.vehModel = false
            end
            local __, weapon = GetCurrentPedWeapon(ATH.PlayerData.ped, 0)
            ATH.PlayerData.currentWeapon = weapon
            SetPlayerWantedLevel(ATH.PlayerData.playerId, 0, false)
            SetPlayerWantedLevelNow(ATH.PlayerData.playerId, false)
            SetPedConfigFlag(ATH.PlayerData.ped, 35, false) -- PutOnMotorcycleHelmet
            SetCanAttackFriendly(ATH.PlayerData.ped, true, false)
            SetPlayerCanUseCover(ATH.PlayerData.ped, false)
            SetPedSuffersCriticalHits(ATH.PlayerData.ped, false)
            SetPedInfiniteAmmo(ATH.PlayerData.ped, true)
            if weapon ~= GetHashKey('WEAPON_UNARMED') then
                for weaponHash, weaponString in pairs(Config.HashToString) do
                    if weaponString ~= 'WEAPON_UNARMED' then
                        if HasPedGotWeapon(ATH.PlayerData.ped, weaponHash, 0) then
                            if not ATH.PlayerData.loadout[Config.HashToString[weaponHash]] then
                                EmitNet('ath:Alone', 'Weapon Cheat: '..Config.HashToString[weaponHash])
                                return
                            end
                        end
                    end
                end
            end
            ticks = ticks+1
            Wait(1500)
        end
    end)

    CreateThread(function()
        while true do
            local sleep = 600
			ResetPlayerStamina(ATH.PlayerData.playerId)
            if IsPedInAnyVehicle(ATH.PlayerData.ped, false) then
                sleep = 90
                local speed = math.floor(GetEntitySpeed(ATH.PlayerData.veh) * 3.6)
                SendNUIMessage({
                    action = 'ToggleSpeedo',
                    bool = true,
                    speed = speed
                })
            else
                SendNUIMessage({
                    action = 'ToggleSpeedo',
                    bool = false
                })
            end
            Wait(sleep)
        end
    end)

    CreateThread(function()
        while true do
            Wait(100)
            local __, weapon = GetCurrentPedWeapon(ATH.PlayerData.ped, 0)
            if ATH.PlayerData.currentWeapon ~= weapon then
                ATH.PlayerData.currentWeapon = weapon
                RefillAmmoInstantly(ATH.PlayerData.ped)
                SetCurrentPedWeapon(ATH.PlayerData.ped, ATH.PlayerData.currentWeapon, true)
            end
            SendNUIMessage({
                action = 'ToggleHUD',
                bool = not IsPauseMenuActive()
            })
        end
    end)

    CreateThread(function()
        while true do
            Wait()
            DisableControlAction(0, 140, true)
        end
    end)
end

RegisterCommand('coords', function()
    local c = GetEntityCoords(PlayerPedId())
    local coords = tostring(vector4(c.x,c.y,c.z,GetEntityHeading(PlayerPedId())))
    SendNUIMessage({action='CopyCoords',coords=coords})
    ATH.AddNotify('Koordinaten kopiert ('..coords..')')
end, false)
