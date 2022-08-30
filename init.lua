local jets = {}
local makesmoke = core.get_modpath("tnt")
core.register_globalstep(function(dtime)
    for player,_ in pairs(jets) do
        if not player then return end
        local ctrl = player:get_player_control()
        if ctrl.jump then
            local velo = player:get_velocity()
            local jet = 2 - velo.y/10
            player:add_velocity({x=0,z=0,y=jet})
            if makesmoke then
                core.add_particle({
                pos = player:get_pos(),
                velocity = {x=math.random(-1,1),y=math.random(-1,1),z=math.random(-1,1)},
                expirationtime = 1,
                size = 5+math.random(-1,1),
                collisiondetection = false,
                vertical = false,
                texture = "tnt_smoke.png",
                glow = 15})
            end
        end
    end
end)

armor:register_armor("simple_jetpack:jetpack", {
	description = "Simple Jetpack",
	inventory_image = "simple_jetpack_preview.png",
	armor_groups = {fleshy=10},
	groups = {armor_torso=1, armor_heal=100, armor_use=500,},
})

armor:register_on_equip(function(player, index, stack)
    if stack:get_name() == "simple_jetpack:jetpack" then
        jets[player] = true
    end
end)

armor:register_on_unequip(function(player, index, stack)
    if stack:get_name() == "simple_jetpack:jetpack" then
        jets[player] = nil
    end
end)

core.register_craft({
    output = "simple_jetpack:jetpack",
    recipe = {{"farming:string","default:steel_ingot","farming:string"},
            {"default:steel_ingot","default:mese_crystal","default:steel_ingot"},
            {"default:steel_ingot","","default:steel_ingot"}}})
