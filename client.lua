local ESX = exports['es_extended']:getSharedObject()

-- Create Blips for Mechanic Shops
Citizen.CreateThread(function()
    for _, location in ipairs(Config.MechanicShop.Locations) do
        local blip = AddBlipForCoord(location.x, location.y, location.z)
        SetBlipSprite(blip, Config.MechanicShop.Blip.Sprite)
        SetBlipColour(blip, Config.MechanicShop.Blip.Color)
        SetBlipScale(blip, Config.MechanicShop.Blip.Scale)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString('Mechanic Shop')
        EndTextCommandSetBlipName(blip)
    end
end)

-- Open Mechanic Shop Menu
function OpenMechanicShopMenu()
    local elements = {
        {label = 'Repair Vehicle', value = 'repair'},
        {label = 'Customize Vehicle', value = 'customize'}
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_shop', {
        title = 'Mechanic Shop',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'repair' then
            TriggerServerEvent('mechanic_shop:repairVehicle')
        elseif data.current.value == 'customize' then
            TriggerServerEvent('mechanic_shop:customizeVehicle')
        end
    end, function(data, menu)
        menu.close()
    end)
end

-- Check if player is near a Mechanic Shop
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, location in ipairs(Config.MechanicShop.Locations) do
            local distance = #(playerCoords - vector3(location.x, location.y, location.z))
            if distance < 2.0 then
                ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to open the Mechanic Shop')
                if IsControlJustReleased(0, 38) then
                    OpenMechanicShopMenu()
                end
            end
        end
    end
end)