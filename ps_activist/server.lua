ESX = exports["es_extended"]:getSharedObject()

if Config.Debug then
	RegisterCommand('glue', function(source, args, RawCommand)
		TriggerClientEvent("phoenix_klimakleber:startglue", source)
	end)

	RegisterCommand('glueremover', function(source, args, RawCommand)
		TriggerClientEvent("phoenix:kleber_ab", source)
	end)
end

ESX.RegisterUsableItem(Config.GlueItem, function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("phoenix_klimakleber:startglue", source)
end)

ESX.RegisterUsableItem(Config.RemoveGlueItem, function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("phoenix:kleber_ab", source)
end)

RegisterServerEvent("phoenix_kleber:removeitem")
AddEventHandler("phoenix_kleber:removeitem", function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)
end)


RegisterServerEvent("phoenix:sendtarget_s")
AddEventHandler("phoenix:sendtarget_s", function(targetid)
	local xPlayer = ESX.GetPlayerFromId(targetid)
	TriggerClientEvent("phoenix:sendtarget_c", targetid)
end)