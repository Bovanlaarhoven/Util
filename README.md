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
local endPosition = CFrame.new(1,1,1)
local duration = 10
Util.CTween:go(endPosition, duration)
```