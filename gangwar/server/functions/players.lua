function CreatePlayer(identifier, source, weapons)
    local player = {}
    player.source = source
    player.identifier = identifier
    player.weapons = type(weapons) == 'string' and json.decode(weapons) or weapons

    player.getWeapons = function()
        return player.weapons
    end

    player.removeWeapon = function(weapon)
        for index, data in pairs(player.weapons) do
            if data.name == weapon then
                table.remove(player.weapons, index)
                break
            end
        end
    end

    player.addWeapon = function(weapon, ammo, comps)
        table.insert(player.weapons, {name=weapon,ammo=ammo,components=comps or {}})
    end

    player.addComponent = function(weapon, compName)
        for index, data in pairs(player.weapons) do
            if data.name == weapon then
                table.insert(player.weapons[index].components, {name=compName})
                break
            end
        end
    end

    player.removeComponent = function(weapon, compName)
        for index, data in pairs(player.weapons) do
            if data.name == weapon then
                for k, v in pairs(data.components) do
                    if v.name == compName then
                        table.remove(player.weapons[index].components, k)
                        break
                    end
                end
            end
        end
    end

    return player
end
