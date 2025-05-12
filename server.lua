RegisterServerEvent("whitejob:giveItem")
AddEventHandler("whitejob:giveItem", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if xPlayer.canCarryItem(item, 1) then
            xPlayer.addInventoryItem(item, 1)
        else
            TriggerClientEvent('chat:addMessage', source, {
                args = {"^1ของเต็ม! เก็บของต่อไม่ได้"}
            })
        end
    end
end)
RegisterServerEvent("whitejob:giveItem")
AddEventHandler("whitejob:giveItem", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.addInventoryItem(item, 1)
    end
end)
