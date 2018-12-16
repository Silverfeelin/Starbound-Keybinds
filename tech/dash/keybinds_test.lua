require "/scripts/keybinds.lua"
require "/tech/dash/keybinds_scriptHooks.lua"

hook("init", function()
   Bind.create("specialOne", function(bind)
    world.spawnItem("money", tech.aimPosition())
    bind:unbind()
  end)
end)
