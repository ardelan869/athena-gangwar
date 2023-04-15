AddEventHandler('playerConnecting', function(_, _, deferrals)
    local s = source
    MySQL.query('SELECT id, kills, deaths, xp FROM accounts WHERE identifier=?', {GetPlayerIdentifierByType(s, 'steam')}, function(r)
        if #r > 0 then
            local data = r[1]
            deferrals.handover({
                static=data.id,
                players=('%s<font>/%s<font/>'):format(
                    GetNumPlayerIndices()+1,
                    GetConvarInt('sv_maxclients', 'ERROR')
                ),
                level=exports.gangwar:CalcLevel(data.xp),
                kd=data.kills / data.deaths,
                kills=data.kills,
                deaths=data.deaths
            })
        else
            deferrals.handover({
                static='N/A',
                players=('%s<font>/%s<font/>'):format(
                    GetNumPlayerIndices()+1,
                    GetConvarInt('sv_maxclients', 'ERROR')
                ),
                level=0,
                kd='0.0',
                kills=0,
                deaths=0
            })
        end
    end)
end)