local ESX = exports['es_extended']:getSharedObject()

-- Repair Vehicle
RegisterServerEvent('mechanic_shop:repairVehicle')
AddEventHandler('mechanic_shop:repairVehicle', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(source), false)
    local plate = GetVehicleNumberPlateText(vehicle)

    if xPlayer.getMoney() >= Config.MechanicShop.RepairCost then
        xPlayer.removeMoney(Config.MechanicShop.RepairCost)
        MySQL.Async.execute('UPDATE mechanic_shop_vehicles SET health = 1000 WHERE plate = @plate', {['@plate'] = plate}, function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('esx:showNotification', source, 'Vehicle repaired successfully!')
                SetVehicleEngineHealth(vehicle, 1000.0)
                SetVehicleFixed(vehicle)
            else
                TriggerClientEvent('esx:showNotification', source, 'Failed to repair vehicle!')
            end
        end)
    else
        TriggerClientEvent('esx:showNotification', source, 'Not enough money to repair the vehicle!')
    end
end)

-- Customize Vehicle
RegisterServerEvent('mechanic_shop:customizeVehicle')
AddEventHandler('mechanic_shop:customizeVehicle', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(source), false)
    local plate = GetVehicleNumberPlateText(vehicle)

    if xPlayer.getMoney() >= Config.MechanicShop.CustomizationCost then
        xPlayer.removeMoney(Config.MechanicShop.CustomizationCost)
        TriggerClientEvent('esx:showNotification', source, 'Vehicle customization started!')
        Citizen.Wait(Config.Vehicles.CustomizationTime)
        TriggerClientEvent('esx:showNotification', source, 'Vehicle customization completed!')
    else
        TriggerClientEvent('esx:showNotification', source, 'Not enough money to customize the vehicle!')
    end
end)