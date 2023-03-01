require "util"

global.spawns = {{name = 'player', x = 0, y = 0, lock = true}}

function ui()
	for playerIndex, player in pairs(game.players) do
		if player.gui.top.spawn == nil then
			player.gui.top.add{name = "spawn", type = "button", caption = "Set Spawn", style="spc_fentus_button"}
		end
    end
end

script.on_configuration_changed(function(_)
    ui()
end)


script.on_event(defines.events, function(event)
	if event.name == defines.events.on_player_joined_game then
		ui()
	end
	
	-- on_gui_click
	if event.name == defines.events.on_gui_click then
		if event.element.name == "spawn" then
            local player = game.players[event.player_index]
			
			game.print("Set " .. player.name .. "'s spawn point.")
			table.insert(global.spawns, {name = player.name, player = player.name, x = player.position.x, y = player.position.y, lock = true, tries = 0})
		end
	end
	
	if event.name == defines.events.on_player_respawned then
        -- Get Current Player
        local player = game.players[event.player_index]
		
		for _, spawn in pairs(global.spawns) do
			if spawn.name == player.name then
				player.teleport({spawn.x, spawn.y}, player.surface)
			end
		end
	end
end)
