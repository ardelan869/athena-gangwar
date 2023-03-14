RegisterKeyMapping('team', 'Öffne die Frakauswahl', 'keyboard', 'F1')
RegisterCommand('team', function()
    display(true)
end, false)

RegisterNUICallback('joinFrak', function(d, cb)
    frak = d.frak
    setOutfit()
    display(false)
    cb('ok')
end)

function freezePlayer(id, freeze)
    local player = id
    SetPlayerControl(player, not freeze, false)
    local ped = GetPlayerPed(player)
    if not freeze then
        if not IsEntityVisible(ped) then
            SetEntityVisible(ped, true)
        end
        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end
        FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    else
        if IsEntityVisible(ped) then
            SetEntityVisible(ped, false)
        end
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(player, true)
        if not IsPedFatallyInjured(ped) then
            ClearPedTasksImmediately(ped)
        end
    end
end

function display(bool)
    freezePlayer(PlayerId(), bool)
    SetNuiFocus(bool, bool)
    if (bool) then
        SendNUIMessage({action = 'openFrak'})
    end
end

function setOutfit()
    RemoveAllPedWeapons(PlayerPedId(), 0)
    for _, i in pairs(Shared.Fraks) do
        if frak == i.name then
            for k, v in pairs(i.clothes) do
                SetPedComponentVariation(PlayerPedId(), v.cID, v.dID, v.tID, 0)
            end
            SetEntityCoords(PlayerPedId(), i.spawns[math.random(1, #i.spawns)])
        end
    end
    for _, i in pairs(Shared.Weapons) do
        GiveWeaponToPed(PlayerPedId(), GetHashKey(i), 500, 0, 0)
    end
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
end
