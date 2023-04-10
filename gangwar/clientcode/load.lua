RegisterNetEvent('ath:LoadClient', function(codes)
    for i=1, #codes do
        assert(load(codes[i]))()
    end
end)
TriggerServerEvent('ath:LoadClient')