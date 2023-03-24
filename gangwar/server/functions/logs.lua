AddEventHandler('playerDropped', function(reason)
    local s = source
    local ids = ExtractIdentifiers(s)
    SendToDiscord(('Spieler **%s** hat den Server verlassen. \n\n**[DETAILS]**\n```Reason: %s\nDiscord: %s\nSteam: %s\nLicense: %s\nLive: %s\nXBL: %s\nIP: %s```'):format(
        GetPlayerName(s),
        reason,
        ids.discord,
        ids.steam,
        ids.license,
        ids.live,
        ids.xbl,
        ids.ip
    ))
    ATH.Players[s] = nil
end)

AddEventHandler('playerConnecting', function()
    local s = source
    local ids = ExtractIdentifiers(s)
    SendToDiscord(('Spieler **%s** betritt den Server. \n\n**[DETAILS]**\n```Discord: %s\nSteam: %s\nLicense: %s\nLive: %s\nXBL: %s\nIP: %s```'):format(
        GetPlayerName(s),
        ids.discord,
        ids.steam,
        ids.license,
        ids.live,
        ids.xbl,
        ids.ip
    ))
end)

AddEventHandler('core:killedPlayer', function(killer)
    local s = source
    local k = killer
    local id = ExtractIdentifiers(s)
    local ids = ExtractIdentifiers(k)
    SendToDiscord(('Spieler **%s** hat Spieler **%s** getötet. \n\n**[KILLER]**\n```Discord: %s\nSteam: %s\nLicense: %s\nLive: %s\nXBL: %s\nIP: %s```\n\n**[SOURCE]**\n```Discord: %s\nSteam: %s\nLicense: %s\nLive: %s\nXBL: %s\nIP: %s```'):format(
        GetPlayerName(k),
        ids.discord,
        ids.steam,
        ids.license,
        ids.live,
        ids.xbl,
        ids.ip,
        GetPlayerName(s),
        id.discord,
        id.steam,
        id.license,
        id.live,
        id.xbl,
        id.ip
    ))
end)

function ExtractIdentifiers(src)
    local identifiers = {
        steam = '',
        ip = '',
        discord = '',
        license = '',
        xbl = '',
        live = ''
    }
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, 'steam') then
            identifiers.steam = id
        elseif string.find(id, 'ip') then
            identifiers.ip = id
        elseif string.sub(id, 1, string.len('discord:')) == 'discord:' then
            discordid = string.sub(id, 9)
            identifiers.discord = '<@' .. discordid .. '>'
        elseif string.find(id, 'license') then
            identifiers.license = id
        elseif string.find(id, 'xbl') then
            identifiers.xbl = id
        elseif string.find(id, 'live') then
            identifiers.live = id
        end
    end
    return identifiers
end

function SendToDiscord(Message, Username, AuthName, Color, Icon, Title, Webhook)
    local message = {
        username = Username,
        embeds = {{
            color = Color,
            author = {
                name = AuthName,
                icon_url = Icon
            },
            title = Title,
            description = Message,
            footer = {
                text = 'Send: ' .. os.date('%x %X %p'),
                icon_url = Icon,
            },
        }},
        avatar_url = Icon
    }
    PerformHttpRequest(Webhook, function(err, text, headers)
    end, 'POST', json.encode(message), {['Content-Type'] = 'application/json'})
end
