# Starbound Keybinds
Easily bind functions to one or more input methods.

**Note: Parts of this README may be moved to [the Wiki](https://github.com/Silverfeelin/Starbound-Keybinds/wiki) in the future to keep everything neat and tidy.**

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Syntax Options](#syntax-options)
- [Value Types](#value-types)
- [Bind Object](#bind-object)
- [Contributing](#contributing)

## Installation

> It is recommended to put the script in a folder dedicated to your mod. This can help prevent version conflicts with other mods.  
> Example: `/Starbound/mods/MyMod/scripts/myMod/keybinds.lua`

The keybinds script may be included in your own mod. This way, users don't have to manually install the library.

* Place the script somewhere in your mod folder.

[Back to Top](#starbound-keybinds)

## Usage

* At the top of your script, require the `keybinds.lua` script.
  * Example: `require "/scripts/myMod/keybinds.lua"`

To create a keybind, use the below function anywhere in your script. You'll most likely want to do this in the `init` function.  

> Bind.create([syntax](#syntax), [func](#function), [[repeatable]](#repeatable), [[disabled]](#disabled))

#### Syntax
Default syntax for one option: `key=value`.

* Options are separated by a space.  
  `"specialOne down"`
* Keys and values are separated by `=`.  
  `"specialOne=true down=true up=false"`
* The value is optional. Values default to `true`.  
  `"specialOne"` = `"specialOne=true"`
* Keys are case-insensitive.  
  `"Specialone"`

[View all supported options.](#syntax-1)

#### Function

When all options match, this function will fire. The first argument to this function is the [bind object](#Bind-Object).

``` lua
function myFunction() sb.logInfo("You pressed the F key!") end
Bind.create("specialOne", myFunction)
Bind.create("specialTwo", function() sb.logInfo("You pressed the G key!") end)
Bind.create("up down", function(bind)
  sb.logInfo("You pressed up and down for the first time!")
  bind:unbind()
end)
```

#### Repeatable `optional`
This value indicates whether the keybind should activate only once (`false`), or every game tick as long as the current game input matches the arguments of the keybind (`true`). Defaults to `false`.

#### Disabled `optional `
If `true`, the created bind can not activate until `bind:rebind()` is called.

#### Return value
Reference to the bind, which can be used to manipulate the bind.
See [Bind Object](#bind-object).

```lua
local bind = Bind.create("specialOne", myFunction)
```

[Back to Top](#starbound-keybinds)

## Syntax

The descriptions are based on the default keyboard configuration of the game.

| Key | Type | Description |
| --- | ---- | ----------- |
| `up` | [boolean](#boolean) | True while holding <kbd>w</kbd>. |
| `left` | [boolean](#boolean) | True while holding <kbd>a</kbd>. |
| `down` | [boolean](#boolean) | True while holding <kbd>s</kbd>. |
| `right` | [boolean](#boolean) | True while holding <kbd>d</kbd>. |
| `primaryFire` | [boolean](#boolean) | True while holding down the left mouse button. |
| `altFire` | [boolean](#boolean) | True while holding down the right mouse button. |
| `shift` | [boolean](#boolean) | True while holding down <kbd>shift</kbd>. |
| `onGround` | [boolean](#boolean) | True while standing on the ground. |
| `running` | [boolean](#boolean) | True while actively running. |
| `walking` | [boolean](#boolean) | True while actively walking (running while holding <kbd>shift</kbd>). |
| `jumping` | [boolean](#boolean) | True while holding <kbd>space</kbd>. |
| `facingDirection` | [float](#float) | `-1` while facing left. `1` while facing right. |
| `liquidPercentage` | [float](#float) | Value between `0` and `1`, indicating what percentage of your hitbox is submerged. |
| `position` | [vec2](#vec2) | World position of your character in blocks. |
| `aimPosition` | [vec2](#vec2) | Position of your cursor on the world, in blocks.
| `aimRelative` | [vec2](#vec2) | `aimPosition` relative to `position`. |
| `specialOne` | [boolean](#boolean) | True while holding the first tech action key (`PlayerTechAction1`). |
| `specialTwo` | [boolean](#boolean) | True while holding the second tech action key (`PlayerTechAction2`). |
| `specialThree` | [boolean](#boolean) | True while holding the third tech action key (`PlayerTechAction3`). |

### Options

These keywords have a special meaning. They should be combined with other options.

| Key | Type | Description |
| --- | ---- | ----------- |
| `all` | [boolean](#boolean) | If set, the bind can only reactivate when all input options no longer match.<br>An example: `"all up down"` will only fire when `up` and `down` have both been pressed like usual. The bind can only fire again if both `up` and `down` have been released. Normally, the bind can fire again even if only one key has been released. |
| `only` | [boolean](#boolean) | With this value set, all omitted **key** options will be set to false. Options such as `onGround`, `running` or `facingDirection` are unaffected, as these options can not be pressed or released.<br>An example: `"only primaryFire up"` will be interpreted as `primaryFire=true up=true altFire=false left=false` et cetera.|
| `aimOffset` | [vec2](#vec2) | Value indicating how far `position`, `aimPosition` and `aimRelative` may be off. Defaults to `2,2`.<br>An example:  `"aimRelative=20,25 aimOffset=2,10"`. Valid: `aimRelative` between `(18,15)` and `(22,35)`. |
| `time` | [float](#float) | Value indicating how long the other input options should match before running the function.<br>With `repeatable` set, the bind function will still fire every update as long as the bind is active. |

[Back to Top](#starbound-keybinds)

## Value Types

#### Boolean
`true` or `false`. `true` may be omitted as it is the default value.
```lua
Bind.create("down=true up=false specialOne", myFunction)
```


#### Float
Any positive or negative number. Decimals are allowed, but may not work in certain input options.
```lua
Bind.create("facingDirection=1", myFunction)
```

#### Vec2
Two [floats](#float), separated with a comma.
```lua
Bind.create("position=100,200 aimOffset=10,10", myFunction)
```

[Back to Top](#starbound-keybinds)

## Bind Object
The `Bind.create` function returns a bind object, that you can manipulate with the functions described below.
```lua
-- Create a bind
local bind = Bind.create(args, f, repeatable)

-- Set new input options.
bind:change(newArgs, f, repeatable)

-- Set repeatable to true. Nil values are ignored; the old values will be kept.
bind:change(nil, nil, true)

-- Swap the functions of both binds. Input options and repeatable remain untouched.
bind:swap(otherBind)

-- Unbind. The bind can no longer activate.
bind:unbind()

-- Rebind. The bind can activate again.
bind:rebind()

-- Checks if the bind can activate.
local active = bind:isActive()
```

[Back to Top](#starbound-keybinds)

## Contributing
If you have any suggestions or feedback that might help improve this library, please create an issue on the [Issues page](https://github.com/Silverfeelin/Starbound-Keybinds/issues).
You can also create pull requests and contribute directly!

[Back to Top](#starbound-keybinds)
