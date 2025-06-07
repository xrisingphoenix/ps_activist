Config = {}

Config.Debug = false -- default false (just true for enabling commands)

Config.GlueItem = 'glue'

Config.RemoveGlueItem = 'glue_remover'

Config.GlueTime = 3000 -- How long should the Player not be able to move in Seconds after the Glue is not working anymore

Config.GlueTimeStart = 10 -- How long should the Glue take to dry (so the player cant move after this countdown) in seconds

Config.Notify = function(msg)
    ESX.ShowNotification(msg)
end

Config.Translation = {
    ['glue_used'] = 'You used the Glue. Now wait for it to dry',
    ['glue_dried'] = 'The glue is now dry. You can no longer move, both hands are glued',
    ['glue_not_working'] = 'The Glue is not working anymore',
    ['someone_removed_glue'] = 'Someone removed the Glue',
    ['no_player_nearby'] = 'No Player nearby, that is glued',
    ['be_on_ground'] = 'You need to be on the Ground',
    ['not_in_vehicle'] = 'You cant do this in a vehicle',
    ['glue_removed_violent'] = 'The glue was removed by force. youre Hands are injured',
    ['too_fast'] = 'You left the place too quickly so youre not glued yet',
}