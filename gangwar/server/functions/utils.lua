ATH.GetPlayer = function(player)
    if type(player) == 'string' then
        for index, data in pairs(ATH.Players) do
            if data.identifier == player then
                return data
            end
        end
    elseif type(player) == 'number' then
        return ATH.Players[player] or false
    end
end

ATH.GetIdentifier = function(player)
    for _, i in pairs(GetPlayerIdentifiers(player)) do
        if string.find(i, 'steam:') then
            return i:sub(7)
        end
    end
end