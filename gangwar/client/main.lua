CreateThread(function()
    while true do
        Wait(0)
        if NetworkIsPlayerActive(PlayerId()) then
            DoScreenFadeOut(0)
            Wait(500)
            EmitNet('ath:PlayerReady')
            Emit('ath:PlayerReady')
            return
        end
    end
end)

local AppendTeams = function()
    for name, team in pairs(Teams) do
        local msg = team
        msg.action = 'AppendFrak'
        SendNUIMessage(msg)
    end
    ATH.UpdateTeamCount()
    SendNUIMessage({
        action = 'ToggleHUD',
        bool = false
    })
    SendNUIMessage({
        action = 'ToggleFraction',
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
    SetModelAsNoLongerNeeded(defaultModel)
    SetEntityCoordsNoOffset(PlayerPedId(), vector3(-1.5, 19.2501, 71.1215))
    SetEntityHeading(PlayerPedId(), 0.0)
    ShutdownLoadingScreen()
    FreezeEntityPosition(PlayerPedId(), true)
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

On('ath:PlayerJoined', function(data, teams)
    ATH.Teams = teams
    ATH.PlayerData = {
        identifier = data.identifier,
        source = data.source,
        name = data.name,
        loadout = data.loadout,
        rank = data.rank,
        kills = data.kills,
        deaths = data.deaths,
        xp = data.xp,
        name = data.name,
        ped = nil,
        isSpawned = false,
        playerId = nil,
        isDead = false,
        isDuty = false
    }

    CreateDefaultPed()
    SetEntityHealth(ATH.PlayerData.ped, 200)
    SetPedArmour(ATH.PlayerData.ped, 100)
    AddWeapons(ATH.PlayerData.loadout)
    NetworkSetFriendlyFireOption(true)
    SetPlayerInvincible(ATH.PlayerData.playerId, false)

    while not ATH.PlayerData.isSpawned do Wait() end
    local level, needed = ATH.GetLevel(data.xp)
    SendNUIMessage({
        action='SetId',
        id=data.source,
        xp=data.xp,
        level=level,
        needed=needed
    })
    SendNUIMessage({
        action='SetStats',
        kills=data.kills,
        deaths=data.deaths,
    })
end)

function StartLoops()
    CreateThread(function()
        while not IsControlJustPressed(0, 32) and
            not IsControlJustPressed(0, 33) and
            not IsControlJustPressed(0, 34) and
            not IsControlJustPressed(0, 35)
        do
            SetLocalPlayerAsGhost(true)
            SetGhostedEntityAlpha(128)
            SetEntityAlpha(PlayerPedId(), 128, false)
            Wait()
        end
        ResetEntityAlpha(PlayerPedId())
        SetLocalPlayerAsGhost(false)
    end)
    FreezeEntityPosition(ATH.PlayerData.ped, false)
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
            Wait(230)
            local __, weapon = GetCurrentPedWeapon(ATH.PlayerData.ped, 0)
            if ATH.PlayerData.currentWeapon ~= weapon then
                ATH.PlayerData.currentWeapon = weapon
                RefillAmmoInstantly(ATH.PlayerData.ped)
                SetCurrentPedWeapon(ATH.PlayerData.ped, ATH.PlayerData.currentWeapon, true)
            end
            if not ATH.PlayerData.forceHud then
                SendNUIMessage({
                    action = 'ToggleHUD',
                    bool = not IsPauseMenuActive()
                })
            end
        end
    end)

    CreateThread(function()
        while true do
            local sleep = 200
            if IsPedArmed(ATH.PlayerData.ped, 6) then
                sleep = 1
                DisableControlAction(0, 140, true)
                DisableControlAction(0, 142, true)
            end
            Wait(sleep)
        end
    end)
end
