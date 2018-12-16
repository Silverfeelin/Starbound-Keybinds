# Starbound Keybinds

Easily bind functions to one or more input methods.

Write:

```lua
require "/scripts/keybinds.lua"

function init()
  Bind.create("up down specialOne", toggleNoclip)
  Bind.create("up=false down=false specialOne", toggleSit)
end
```

Instead of:

```lua
local firedNoclip, firedSit = false, false

function update(args)
  if args.moves.up and args.moves.down and args.moves.special1 then
    if not firedNoclip then
      firedNoclip = true
      toggleNoclip()
    end
  else
    firedNoclip = false
  end

  if not args.moves.up and not args.moves.down and args.moves.special1 then
    if not firedSit then
      firedSit = true
      toggleSit()
    end
  else
    firedSit = false
  end
end
```

## Wiki

You should be able to find the information you need on [the wiki](https://github.com/Silverfeelin/Starbound-Keybinds/wiki).

* [Installation](https://github.com/Silverfeelin/Starbound-Keybinds/wiki/Installation)
* [Usage](https://github.com/Silverfeelin/Starbound-Keybinds/wiki/Usage)
* [Options](https://github.com/Silverfeelin/Starbound-Keybinds/wiki/Options)
    * [Value Types](https://github.com/Silverfeelin/Starbound-Keybinds/wiki/Value-Types)
* [Bind Object](https://github.com/Silverfeelin/Starbound-Keybinds/wiki/Bind-Object)

## Contributing
If you have any suggestions or feedback that might help improve this library, please create an issue on the [Issues page](https://github.com/Silverfeelin/Starbound-Keybinds/issues).
You can also create pull requests and contribute directly!

[Back to Top](#starbound-keybinds)
