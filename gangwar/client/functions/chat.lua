RegisterNetEvent('core:addChatMessage', function(msg)
    SendNUIMessage({
        action = 'addChatMessage',
        msg = msg
    })
end)

RegisterNetEvent('__cfx_internal:serverPrint', function(msg)
    print(msg)
    SendNUIMessage({
        action = 'addChatMessage',
        msg = msg
    })
end)

RegisterNUICallback('sendChatMessage', function(data, cb)
    if data.msg:sub(1, 1) == '/' then
        ExecuteCommand(data.msg:sub(2))
    else
        TriggerServerEvent('core:sendPublicMessage', data.msg)
    end
    SetNuiFocus(false, false)
    cb('ok')
end)
