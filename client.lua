local spawnedProps = {}
local farming = false

function SpawnProp(job)
    local data = Config.FarmJobs[job]
    local randomIndex = math.random(1, #data.locations)
    local coord = data.locations[randomIndex]

    local prop = CreateObject(GetHashKey(data.prop), coord.x, coord.y, coord.z - 1.0, false, true, true)
    PlaceObjectOnGroundProperly(prop)
    FreezeEntityPosition(prop, true)

    spawnedProps[job] = {entity = prop, coord = coord}
end

Citizen.CreateThread(function()
    Wait(1000) 
    for job, _ in pairs(Config.FarmJobs) do
        SpawnProp(job)
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        for job, data in pairs(Config.FarmJobs) do
            local propData = spawnedProps[job]
            if propData then
                local distance = #(coords - propData.coord)
                if distance < 4.0 then
                    DrawText3D(propData.coord.x, propData.coord.y, propData.coord.z + 1.0, "[E] " .. data.label)
                    if IsControlJustPressed(0, 38) and not farming then
                        StartFarming(job, data)
                    end
                end
            end
        end
    end
end)

function StartFarming(job, data)
    farming = true
    ClearPedTasksImmediately(PlayerPedId())
    TaskStartScenarioInPlace(PlayerPedId(), "world_human_gardener_plant", 0, true)
    Wait(data.timePerCollect)
    ClearPedTasksImmediately(PlayerPedId())

    TriggerServerEvent("whitejob:giveItem", data.reward)

    if spawnedProps[job] and DoesEntityExist(spawnedProps[job].entity) then
        DeleteEntity(spawnedProps[job].entity)
    end
    SpawnProp(job)

    farming = false
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    if onScreen then
        DrawText(_x, _y)
    end
end
