cam = nil
frak = nil
firstspawn = false

CreateThread(function()
    while not firstspawn do
        spawnPlayer()
        Wait(500)
    end
end)

CreateThread(function()
    Wait(1500)
    for _, i in pairs(Shared.Fraks) do
        SendNUIMessage({
            action = 'appendFraks',
            name = i.name,
        })
        print(i.name)
    end
    while true do
        SetPlayerWantedLevel(PlayerId(), 0, false)
        SetPlayerWantedLevelNow(PlayerId(), false)
        if IsControlPressed(0, 245) then
            SendNUIMessage({action = 'openChat'})
            SetNuiFocus(true, true)
        end
        Wait(100)
    end
end)

function spawnPlayer()
    local defaultModel = GetHashKey('mp_m_freemode_01')
    while not HasModelLoaded(defaultModel) do
        RequestModel(defaultModel) Wait()
    end
    firstspawn = true
    SetPlayerModel(PlayerId(), defaultModel)
    for i = 0, 19 do
        SetPedComponentVariation(PlayerPedId(), 0, i, 0, 0)
    end
    SetModelAsNoLongerNeeded(defaultModel)
    SetEntityCoordsNoOffset(PlayerPedId(), 3000.0, 3400.0, 3000.0, false, false, false, true)
    ShutdownLoadingScreen()
    FreezeEntityPosition(PlayerPedId(), false)
    DoScreenFadeIn(1000)
    SetPedInfiniteAmmo(PlayerPedId(), true)
    ResurrectPed(PlayerPedId())
    -- display(true)
end

RegisterCommand('test', function()
    PlaystatsRankUp(2000000)
end, false)
