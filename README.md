# Util

```lua
local Util = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robobo2022/Util/main/Load.lua"))()
local endPosition = CFrame.new(1,1,1)
local duration = 10
Util.CTween:go(endPosition, duration)
```
```lua
local Util = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robobo2022/Util/main/Load.lua"))()
Util.PathFind.MoveCharacter(CFrame.new(1,1,1))
Util.PathFind.ShowPath(CFrame.new(1,1,1))
Util.PathFind.RemovePath()
```
