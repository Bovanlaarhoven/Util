# Util

```lua
--webhook explained
local Util = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robobo2022/Util/main/Load.lua"))()
local WebhookUrl = "url"
local Message = "ok"
Util.Webhook:Send(WebhookUrl, Message)
Util.Webhook:Embed(WebhookUrl, Content, Title, description)
```
```lua
local Util = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robobo2022/Util/main/Load.lua"))()
local player = game:GetService("Players").LocalPlayer
local endPosition = CFrame.new(1,1,1)
local duration = 10
Util.CTween:go(player, endPosition, duration)
```
```lua
local Util = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robobo2022/Util/main/Load.lua"))()
local endPosition = Vector3.new(10, 0, 10)
local waypoints = pathfinding:findPath(endPosition)
local player = game.Players.LocalPlayer
local stopFollowingPath = pathfinding:followPath(player, waypoints)
```