CreateThread(function()
    while true do
        Wait()
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
        ATH.AddBlip(team.spawn, 429, team.color.blip, 0.9, team.label)
        ATH.CreatePed(GetHashKey('a_c_chimp'), team.garage.pos, 1.3)
        ATH.CreatePed(GetHashKey('a_c_rhesus'), team.clothing, 1.4)
    end
    ATH.UpdateTeamCount()
    SendNUIMessage({action = 'ToggleHUD', bool = false})
    SendNUIMessage({action = 'ToggleFraction', bool = true})
    SetNuiFocus(true, true)
end

local CreateDefaultPed = function()
    local defaultModel = GetHashKey('mp_m_freemode_01')
    while not HasModelLoaded(defaultModel) do
        RequestModel(defaultModel)Wait()
    end
    SetPlayerModel(PlayerId(), defaultModel)
    SetModelAsNoLongerNeeded(defaultModel)
    SetEntityCoordsNoOffset(PlayerPedId(), vector3(-1.5, 19.2501, 71.1215))
    SetEntityHeading(PlayerPedId(), 0.0)
    FreezeEntityPosition(PlayerPedId(), true)
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
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
        if data.components and type(data.components) == 'table' and #data.components > 0 then
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
        static = data.static,
        ped = nil,
        isSpawned = false,
        playerId = nil,
        isDead = false,
        collected = data.collected
    }
    
    local level, needed, show = ATH.GetLevel(data.xp)
    ATH.PlayerData.level = level
    
    CreateDefaultPed()
    SetEntityHealth(ATH.PlayerData.ped, 200)
    SetPedArmour(ATH.PlayerData.ped, 100)
    AddWeapons(ATH.PlayerData.loadout)
    NetworkSetFriendlyFireOption(true)
    SetPlayerInvincible(ATH.PlayerData.playerId, false)
    
    while not ATH.PlayerData.isSpawned do Wait() end
    
    SendNUIMessage({
        action = 'SetId',
        id = data.source,
        xp = show,
        level = level,
        needed = needed
    })
    
    SendNUIMessage({
        action = 'SetStats',
        kills = data.kills,
        deaths = data.deaths,
    })

    local settings = GetResourceKvpString('settings')
    settings = settings and json.decode(settings) or false
    SendNUIMessage({
        action = 'SetSettings',
        settings = settings,
        loadout = ATH.PlayerData.loadout,
        meta = Config.MetaData,
        rewards = Rewards,
        collected = ATH.PlayerData.collected
    })

    if data.collected.quests and type(data.collected.quests) == 'table' then
        for _, quest in pairs(data.collected.quests) do
            if quest == false then
                local QuestData = Quests[tonumber(_)]
                SendNUIMessage({
                    action = 'AddQuest',
                    index = tonumber(_),
                    progress = data.collected.quest_progress[_] or 0,
                    max = QuestData.amount,
                    description = QuestData.description
                })
            end
        end
    end
    
    ATH.Weather = settings and WEATHER_TYPES[settings.Weather] or 'EXTRASUNNY'

    if settings.Weapons then
        for weapon, enabled in pairs(settings.Weapons) do
            local hash = StringToHash(weapon)
            if enabled == true and not HasPedGotWeapon(ATH.PlayerData.ped, hash) then
                GiveWeaponToPed(ATH.PlayerData.ped, hash, 100, false, false)
                if ATH.PlayerData.loadout[weapon] then
                    local components = ATH.PlayerData.loadout[weapon].components
                    if #components > 0 then
                        for index, component in pairs(components) do
                            GiveWeaponComponentToPed(ATH.PlayerData.ped, hash, component.hash)
                        end
                    end
                end
            elseif enabled == false and HasPedGotWeapon(ATH.PlayerData.ped) then
                RemoveWeaponFromPed(ATH.PlayerData.ped, hash)
            end
        end
    end
end)

function StartLoops()
    CreateThread(function()
        while not IsControlJustPressed(0, 32) and
            not IsControlJustPressed(0, 33) and
            not IsControlJustPressed(0, 34) and
            not IsControlJustPressed(0, 22) and
            not IsControlJustPressed(0, 37) and
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
    SetPedConfigFlag(ATH.PlayerData.ped, 35, false)-- PutOnMotorcycleHelmet
    SetCanAttackFriendly(ATH.PlayerData.ped, true, false)
    SetPlayerCanUseCover(ATH.PlayerData.playerId, false)
    StatSetInt(GetHashKey('MP0_SHOOTING_ABILITY'), 100, true)
    StatSetInt(GetHashKey('MP0_STEALTH_ABILITY'), 100, true)
    StatSetInt(GetHashKey('MP0_FLYING_ABILITY'), 100, true)
    StatSetInt(GetHashKey('MP0_WHEELIE_ABILITY'), 100, true)
    StatSetInt(GetHashKey('MP0_LUNG_CAPACITY'), 100, true)
    StatSetInt(GetHashKey('MP0_STRENGTH'), 100, true)
    StatSetInt(GetHashKey('MP0_STAMINA'), 100, true)
    SetPedSuffersCriticalHits(ATH.PlayerData.ped, false)
    StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')

    -- for k=1,9 do
    --     SetHudComponentPosition(k,999999.0,999999.0)
    -- end

    CreateThread(function()
        while ATH.PlayerData.isSpawned do
            SetPlayerWeaponDamageModifier(ATH.PlayerData.playerId, 0.45)

            ATH.PlayerData.ped = PlayerPedId()
            ATH.PlayerData.playerId = PlayerId()
            ATH.PlayerData.pos = GetEntityCoords(ATH.PlayerData.ped)
            SetRunSprintMultiplierForPlayer(ATH.PlayerData.playerId, 1.1)

            if IsPedInAnyVehicle(ATH.PlayerData.ped, false) then
                ATH.PlayerData.veh = GetVehiclePedIsIn(ATH.PlayerData.ped, false)
            end

            local __, weapon = GetCurrentPedWeapon(ATH.PlayerData.ped, 0)
            ATH.PlayerData.currentWeapon = weapon

            SetPlayerWantedLevel(ATH.PlayerData.playerId, 0, false)
            SetPlayerWantedLevelNow(ATH.PlayerData.playerId, false)

            SetPedConfigFlag(ATH.PlayerData.ped, 35, false)-- PutOnMotorcycleHelmet
            SetCanAttackFriendly(ATH.PlayerData.ped, true, false)
            SetPlayerCanUseCover(ATH.PlayerData.ped, false)
            SetPedSuffersCriticalHits(ATH.PlayerData.ped, false)
            SetPedInfiniteAmmo(ATH.PlayerData.ped, true)

            for weaponHash, weaponString in pairs(Config.HashToString) do
                if weaponString ~= 'WEAPON_UNARMED' then
                    if HasPedGotWeapon(ATH.PlayerData.ped, weaponHash, 0) then
                        if not ATH.PlayerData.loadout[Config.HashToString[weaponHash]] then
                            EmitNet('ath:Alone', 'Weapon Cheat: ' .. Config.HashToString[weaponHash])
                            return
                        end
                    end
                end
            end

            SetWeatherTypePersist(ATH.Weather)
            SetWeatherTypeNow(ATH.Weather)
            SetWeatherTypeNowPersist(ATH.Weather)
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
            Wait(170)
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
        local DisableControlAction = DisableControlAction
        while true do
            if IsPedArmed(ATH.PlayerData.ped, 6) then
                DisableControlAction(0, 140, true)
                DisableControlAction(0, 142, true)
            end
            DisableControlAction(0, 199, true)
            Wait()
        end
    end)
    
    CreateThread(function()
        local skinCoords = vector3(298.7876, -584.5391, 43.26081)
        local AddTextEntry = AddTextEntry
        local BeginTextCommandDisplayHelp = BeginTextCommandDisplayHelp
        local EndTextCommandDisplayHelp = EndTextCommandDisplayHelp
        local IsControlJustPressed = IsControlJustPressed
        while true do
            local sleep = 500
            local team = Teams[ATH.PlayerData.team]
            local garage = #(team.garage.pos - ATH.PlayerData.pos)
            local clothing = #(team.clothing - ATH.PlayerData.pos)
            if garage < 2.0 and not IsNuiFocused() then
                sleep = 0
                AddTextEntry('I_LOVE_CATS', 'Drücke ~INPUT_CONTEXT~ um die Garage zu öffnen')
                BeginTextCommandDisplayHelp('I_LOVE_CATS')
                EndTextCommandDisplayHelp(0, false, true, -1)
                if IsControlJustPressed(0, 38) then
                    SendNUIMessage({action = 'OpenGarage'})
                    SetNuiFocus(true, true)
                end
            elseif clothing < 2.0 then
                sleep = 0
                AddTextEntry('I_LOVE_CATS', 'Drücke ~INPUT_CONTEXT~ um die Umkleide zu öffnen')
                BeginTextCommandDisplayHelp('I_LOVE_CATS')
                EndTextCommandDisplayHelp(0, false, true, -1)
                if IsControlJustPressed(0, 38) then
                    ATH.PlayerData.forceHud = true
                    local kvp = GetResourceKvpString(ATH.PlayerData.team .. '_clothes')
                    if kvp then
                        ATH.PlayerData.clothes = json.decode(kvp)
                        ATH.ApplyClothes()
                    end
                    SendNUIMessage({
                        action = 'ToggleHUD',
                        bool = false
                    })
                    SendNUIMessage({
                        action = 'OpenClothing',
                        color = team.color
                    })
                    TriggerServerEvent('ath:SetDimension', ATH.PlayerData.static)
                    SetNuiFocus(true, true)
                    SetEntityCoords(ATH.PlayerData.ped, -811.5412, 175.1593, 76.74533)
                    SetEntityHeading(ATH.PlayerData.ped, 109.7217)
                    local clothCam = CreateCam('DEFAULT_SCRIPTED_CAMERA')
                    SetCamCoord(clothCam, GetOffsetFromEntityInWorldCoords(ATH.PlayerData.ped, 0.0, 2.0, -0.5))
                    PointCamAtEntity(clothCam, ATH.PlayerData.ped, 0.0, 0.0, 0.0, 0)
                    SetCamActive(clothCam, true)
                    RenderScriptCams(true, false, 500, true, true)
                    while ATH.PlayerData.forceHud do
                        Wait()
                    end
                    RenderScriptCams(0)
                    DestroyCam(clothCam, true)
                    SetEntityCoords(ATH.PlayerData.ped, team.clothing)
                    TriggerServerEvent('ath:SetDimension', 0)
                end
            end
            Wait(sleep)
        end
    end)
end

AddEventHandler('gameEventTriggered', function(name)
    if name == 'CEventNetworkPlayerEnteredVehicle' then
        local veh = GetVehiclePedIsIn(ATH.PlayerData.ped, false)
        if GetPedInVehicleSeat(veh, -1) == ATH.PlayerData.ped then
            local team = Teams[ATH.PlayerData.team]
            local r, g, b = GetVehicleCustomPrimaryColour(veh)
            if r ~= team.color.rgb.r then
                SetVehicleNumberPlateText(veh, tostring(ATH.PlayerData.static))
                SetVehicleCustomPrimaryColour(veh, team.color.rgb.r, team.color.rgb.g, team.color.rgb.b)
                SetVehicleCustomSecondaryColour(veh, team.color.rgb.r, team.color.rgb.g, team.color.rgb.b)
            end
        end
    end
end)