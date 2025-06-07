AddEventHandler('onClientResourceStart', function(ressourceName)
    if(GetCurrentResourceName() ~= ressourceName) then 
        return 
    end 
    print("" ..ressourceName.." started sucessfully")
end)

ESX = exports["es_extended"]:getSharedObject()

local klimaklebing = false
local DisableControl = false
local dry = false

RegisterNetEvent("phoenix_klimakleber:startglue")
AddEventHandler("phoenix_klimakleber:startglue", function()
    local playerPed = PlayerPedId()
    local playercoords = GetEntityCoords(playerPed)
    if IsPedInAnyVehicle(playerPed, true) then 
        Config.Notify(Config.Translation['not_in_vehicle'])
    else 
        if IsPedOnFoot(playerPed) then
            startglue()
        else 
            Config.Notify(Config.Translation['be_on_ground'])
        end
    end
end)


startglue = function()
    klimakleber = PlayerPedId()
    klimaklebecoords = GetEntityCoords(klimakleber) 
    klimaklebing = true
    StartAnim(klimakleber, 'amb@lo_res_idles@', 'world_human_picnic_male_lo_res_base', 3)
    TriggerServerEvent("phoenix_kleber:removeitem", Config.GlueItem)
    Config.Notify(Config.Translation['glue_used'])
    dry = true
    Citizen.Wait(Config.GlueTimeStart * 1000)
    dry = false
    if klimaklebing then
        Config.Notify(Config.Translation['glue_dried'])
        Citizen.Wait(Config.GlueTime * 1000)
        if klimaklebing then
            DisableControl = false
            klimaklebing = false
            ClearPedTasks(klimakleber)
            Config.Notify(Config.Translation['glue_not_working'])
        end
    end
end 

RegisterNetEvent("phoenix:sendtarget_c")
AddEventHandler("phoenix:sendtarget_c", function(klimakleber) --Target Player
    local playerPed = PlayerPedId()
    if klimaklebing then
        klimaklebing = false
        DisableControl = false
        ClearPedTasks(playerPed)
        Config.Notify(Config.Translation['someone_removed_glue'])
    end
end)

RegisterNetEvent("phoenix:kleber_ab")
AddEventHandler("phoenix:kleber_ab", function()
    local PlayerPed = PlayerPedId() 
    local playercoords = GetEntityCoords(PlayerPed)
    local klimakleber , klimakleberDistance = ESX.Game.GetClosestPlayer()
    if klimakleber == -1 or klimakleberDistance > 3.0 then
        Config.Notify(Config.Translation['no_player_nearby'])
    else
        local targetkleber = GetPlayerServerId(klimakleber)
        TriggerServerEvent("phoenix_kleber:removeitem", Config.RemoveGlueItem)
        TriggerServerEvent("phoenix:sendtarget_s", targetkleber)
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if DisableControl then 
            local PlayerPed = PlayerPedId()
            DisableAllControlActions(0) 
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
        end 
        if klimaklebing then 
            local coords = GetEntityCoords(PlayerPedId())
            local distance = Vdist(coords, klimaklebecoords) 
            if distance > 3 then 
                klimaklebing = false
                DisableControl = false
                ClearPedTasks(PlayerPedId())
                if not dry then
                    Config.Notify(Config.Translation['glue_removed_violent'])
                    nowhealth = GetEntityHealth(PlayerPedId())
                    SetEntityHealth(PlayerPedId(), nowhealth - 15)
                else 
                    Config.Notify(Config.Translation['too_fast'])
                end
            end 
        end
    end
end)

function StartAnim(entity, dictionary, animation, flag)
    RequestAnimDict(dictionary)
    while not HasAnimDictLoaded(dictionary) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(entity, dictionary, animation, 1.0, -1, -1, 3, 0, false, false, false)
end
