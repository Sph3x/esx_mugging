ESX = nil
local copsConnected = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

    local xPlayers = ESX.GetPlayers()
    copsConnected = 0

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            copsConnected = copsConnected + 1
        end
    end
    TriggerClientEvent('esx_mugging:copsConnected', -1, copsConnected)

    SetTimeout(60000, CountCops)

end
CountCops()

RegisterServerEvent('esx_muggings:giveMoney')
AddEventHandler('esx_muggings:giveMoney', function()
    local _source = source
    local player = ESX.GetPlayerFromId(_source)
    local amount = math.random(Config.MinMoney, Config.MaxMoney)
    player.addMoney(amount)
    TriggerClientEvent("esx:showNotification", source, ("You stole $%s"):format(amount))
end)

RegisterServerEvent('esx_muggings:giveItems')
AddEventHandler('esx_muggings:giveItems', function(itemName)
    local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
        xPlayer.addInventoryItem(itemName, 1)

end)

RegisterServerEvent('esx_mugging:muggingAlert')
AddEventHandler('esx_mugging:muggingAlert', function(street1, street2, sex)
	TriggerClientEvent("muggingNotify", -1, "~r~Reported Mugging by ~w~ "..sex.." ~r~near~w~  "..street1.." ~r~ and ~w~  "..street2)
end)

RegisterServerEvent('esx_mugging:muggingAlertS1')
AddEventHandler('esx_mugging:muggingAlertS1', function(street1, sex)
	TriggerClientEvent("muggingNotify", -1, "~r~Reported Mugging by ~w~ "..sex.." ~r~near~w~  "..street1)
end)
RegisterServerEvent('esx_mugging:muggingAlertS2')
AddEventHandler('esx_mugging:muggingAlertS2', function(street1, sex)
      TriggerClientEvent("muggingNotify", -1, "~r~Reported Murder by ~w~ "..sex.." ~r~near~w~  "..street1)
end)

RegisterServerEvent('esx_mugging:muggingPos')
AddEventHandler('esx_mugging:muggingPos', function(gx, gy, gz)
	TriggerClientEvent('esx_mugging:muggingPos', -1, gx, gy, gz)
end)
