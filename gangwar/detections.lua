local lastHit = {}
function AntiRapidFireRate(startCoords, endCoords, weaponname, owner)
    local time = GetGameTimer()
    local weaponname = GetWeapontypeModel(weaponname)
    Citizen.Wait(290)
    if NetworkGetEntityIsNetworked(owner) then
        if lastHit[owner] and (time - lastHit[owner]) < 1000 then
            CancelEvent()
            TriggerServerEvent("banihnweg:veuqx", source, "Rapid fire")
            print(lastHit[owner])
        else
            lastHit[owner] = time
        end
    end
end

AddEventHandler('entityCreating', function(entity)
    if DoesEntityExist(entity) and IsEntityProjectile(entity) then
        local owner = NetworkGetEntityOwner(entity)
        local weaponname = GetPedWeaponType(owner)
        if IsEntityAPed(owner) and NetworkIsPlayerActive(owner) then
            local startCoords = GetEntityCoords(entity)
            local endCoords = GetEntityVelocity(entity) + startCoords
            AntiRapidFireRate(startCoords, endCoords, weaponname, owner)
        end
    end
end)

-- Magic Bullets
AddEventHandler('weaponDamageEvent', function(sender, data)
    if data.weaponType == GetHashKey('WEAPON_REVOLVER') and data.ammoType == GetHashKey('AMMO_REVOLVER_AP') then
        CancelEvent()
    end
end)

-- block max range lock
AddEventHandler('entityFire', function(shooter, weapon, shootSrc, shootDst, shotData)
    if not IsPlayerAiming(PlayerId()) then
        return -- Wenn der Spieler nicht zielt, beenden wir die Funktion
    end
    
    local hitEntity = shotData.hitEntity
    if DoesEntityExist(hitEntity) and IsEntityAPed(hitEntity) then
        local pedCoords = GetEntityCoords(hitEntity)
        local pedDistance = #(pedCoords - GetEntityCoords(PlayerPedId()))
        if pedDistance > 200 then
            CancelEvent() -- Das Schießen auf entfernte Peds verhindern
        end
    end
end)