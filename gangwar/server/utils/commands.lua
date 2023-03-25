ATH.AddCommand('ban', Config.Perms['ban'], function(s, args)
    local target = tonumber(args[1])
    if ATH.GetPlayer(target) then
        ATH.AddBan(target, 'PERM', (args[2] and table.concat(args, " ", 2, #args)) or false)
    end
end)

ATH.AddCommand('unban', Config.Perms['ban'], function(s, args)
    if args[1] then
        ATH.RemoveBan(tonumber(args[1]))
    else
        print('/unban <BANNID>')
    end
end)

ATH.AddCommand('save', Config.Perms['all'], function(s, args)
    if args[1] then
        ATH.SavePlayer(ATH.GetPlayer(tonumber(args[1])), false)
    else
        print('/save <PLAYERID>')
    end
end)

ATH.AddCommand('setrank', Config.Perms['all'], function(s, args)
    local target = tonumber(args[1])
    local Player = ATH.GetPlayer(target)
    if Player then
        Player.SetRank(args[2])
    end
end)

ATH.AddCommand('bring', Config.Perms['all'], function(s, args)
    local target = tonumber(args[1])
    local Player = ATH.GetPlayer(s)
    local Target = ATH.GetPlayer(target)
    if Player and Target then
        Target.SetCoords(Player.GetCoords())
    end
end)

ATH.AddCommand('clearcars', Config.Perms['all'], function(s, args)
    local vehs = GetAllVehicles()
    for i=1, #vehs do
        DeleteEntity(vehs[i])
    end
end)

ATH.AddCommand('dv', Config.Perms['all'], function(s, args)
    local radius = tonumber(args[1]) or 4.0
    local vehs = GetAllVehicles()
    local coords = GetEntityCoords(GetPlayerPed(s))
    for i=1, #vehs do
        local veh = vehs[i]
        local dist = #(coords-GetEntityCoords(veh))
        if dist <= radius then
            DeleteEntity(vehs[i])
        end
    end
end, false)

ATH.AddCommand('car', Config.Perms['all'], function(s, args)
    TriggerClientEvent('ath:SpawnCar', s, args[1] or 'THRAX')
end, false)

ATH.AddCommand('addweapon', Config.Perms['weapon'], function(s, args)
    local target = tonumber(args[1])
    local Player = ATH.GetPlayer(target)
    if Player then
        if args[2] then
            Player.AddWeapon(args[2]:upper(), tonumber(args[3]) or false)
        else
            print('/addweapon <ID> <WEAPON>')
        end
    end
end)

ATH.AddCommand('addcomponent', Config.Perms['weapon'], function(s, args)
    local target = tonumber(args[1])
    local Player = ATH.GetPlayer(target)
    if Player then
        if args[2] and args[3] then
            Player.AddComponent(args[2]:upper(), args[3]:lower())
        else
            print('/addcomponent <ID> <WEAPON> <COMPONENT>')
        end
    end
end)

ATH.AddCommand('announce', Config.Perms['all'], function(s, args)
    TriggerClientEvent('ath:AddAnnounce', -1, table.concat(args, ' '), 'ANKÜNDIGUNG', 11000)
end)