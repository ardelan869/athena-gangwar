ATH = {}
ATH.Players = {
    [1] = {}
}

MySQL.ready(function()
    AddEventHandler('playerConnecting', function(name, kick, deferrals)
        local s = source
        local identifier = ATH.GetIdentifier(s)
        local Player = ATH.GetPlayer(identifier)
        if not Player then
            MySQL.query('SELECT * FROM accounts WHERE identifier=?', {identifier}, function(r)
                if #r > 0 then
                    MySQL.query('UPDATE accounts SET username=? WHERE identifier=?', {name, identifier})
                    ATH.Players[s] = CreatePlayer(identifier, s, r[1].weapons)
                else
                    MySQL.query('INSERT INTO accounts (username, identifier) VALUES (?, ?)', {name, identifier})
                    ATH.Players[s] = CreatePlayer(identifier, s, {})
                end
            end)
        else
            kick('Es ist bereits jemand mit deinem Account drauf!')
        end
    end)
end)