local Lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Robobo2022/notify-lib/main/lib'),true))()
local Plrs = game:GetService("Players")
local lplr = Plrs.LocalPlayer
local Character = lplr.Character or lplr.CharacterAdded:Wait()
local Humanoid = lplr.Character:WaitForChild("Humanoid")
local HumanoidRootPart = lplr.Character:WaitForChild("HumanoidRootPart")
local PathFindingService = game:GetService("PathfindingService")
local TweenSerivce = game:GetService("TweenService")
local Camera = workspace.CurrentCamera

local pathfinding = {}

function WorldToEnd(Position)
    local Vector,_ = Camera:WorldToViewportPoint(Position);
    local NewVector = Vector2.new(Vector.X, Vector.Y);
    return NewVector;
end

lplr.CharacterAdded:Connect(function()
    Humanoid = lplr.Character:WaitForChild("Humanoid")
    HumanoidRootPart = lplr.Character:WaitForChild("HumanoidRootPart")
end)

function pathfinding:MoveTo(Position, Wait)
    local Success, Error = pcall(function()
        local Begin

        if Humanoid.RigType == Enum.HumanoidRigType.R15 then
            Begin = Character.UpperTorso or Character.Torso;
        elseif Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
            Begin = HumanoidRootPart;
        end
    
        local Path = PathFindingService:FindPathAsync(Begin.Position, Position)
        local Waypoints = Path:GetWaypoints()
    
        if #Waypoints == 0 then
            Lib.prompt("Error", "No path found", 5)
            return
        end
    
        for Waypoint = 1, #Waypoints do
            if Waypoints[Waypoint].Action == Enum.PathWaypointAction.Jump then
                Humanoid.Jump = true
                Humanoid:MoveTo(Waypoints[Waypoint + 3].Position)
    
                if Wait then
                    Humanoid.MoveToFinished:Wait()
                end
            else
                Humanoid:MoveTo(Waypoints[Waypoint].Position)
    
                if Wait then
                    Humanoid.MoveToFinished:Wait()
                end
            end
        end
    end)

    if not Success then
        Lib.prompt("Error", "" .. Error, 5)
        return
    else
        Lib.prompt("Success", "Moved to position", 5)
    end
end

function pathfinding:TweenTo(Position, Wait)
    local Success, Error = pcall(function()
        local Begin

        if Humanoid.RigType == Enum.HumanoidRigType.R15 then
            Begin = Character.UpperTorso or Character.Torso;
        elseif Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
            Begin = HumanoidRootPart;
        end
    
        local Path = PathFindingService:FindPathAsync(Begin.Position, Position)
        local Waypoints = Path:GetWaypoints()
    
        if #Waypoints == 0 then
            Lib.prompt("Error", "No path found", 5)
            return
        end
    
        for Waypoint = 1, #Waypoints do
            local FarWayPoint
            if Waypoints[Waypoint + 3] then
                FarWayPoint = Waypoints[Waypoint + 3].Position
            else
                FarWayPoint = Waypoints[Waypoint].Position
            end
    
            local Distance = (FarWayPoint - Begin.Position).Magnitude
            local TweenInfo = TweenInfo.new(Distance / Humanoid.WalkSpeed, Enum.EasingStyle.Linear)
            local Tween = TweenSerivce:Create(HumanoidRootPart, TweenInfo, {CFrame = CFrame.new(FarWayPoint)})
            Tween:Play()
    
            if Wait then
                Tween.Completed:Wait()
            end
        end
    end)

    if not Success then
        Lib.prompt("Error", "" .. Error, 5)
    else
        Lib.prompt("Success", "Moved to position", 5)
    end
end

function pathfinding:TeleportTo(Position)
    local Success, Error = pcall(function()
        local Begin

        if Humanoid.RigType == Enum.HumanoidRigType.R15 then
            Begin = Character.UpperTorso or Character.Torso;
        elseif Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
            Begin = HumanoidRootPart;
        end
    
        local Path = PathFindingService:FindPathAsync(Begin.Position, Position)
        local Waypoints = Path:GetWaypoints()
    
        if #Waypoints == 0 then
            Lib.prompt("Error", "No path found", 5)
            return
        end
    
        HumanoidRootPart.CFrame = CFrame.new(Waypoints[#Waypoints].Position)
    end)

    if not Success then
        Lib.prompt("Error", "" .. Error, 5)
        return
    else
        Lib.prompt("Success", "Moved to position", 5)
    end
end

function pathfinding:Path(Position)
    local Success, Error = pcall(function()
        
        local Begin

        if Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
            Begin = Character.UpperTorso or Character.Torso;
        elseif Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
            Begin = HumanoidRootPart;
        end

        local Path = PathFindingService:FindPathAsync(Begin.Position, Position)
        local Waypoints = Path:GetWaypoints()

        if #Waypoints == 0 then
            Lib.prompt("Error", "No path found", 5)
            return
        end

        local Lines = {}

        for Waypoint = 1, #Waypoints do
            local Line = Drawing.new("Line")
            Line.Visible = true
            Line.From = WorldToEnd(Waypoints[Waypoint].Position)

            local LineTo
            if Waypoints[Waypoint + 1] then
                LineTo = Waypoints[Waypoint + 1].Position
            else
                LineTo = Position
            end

            Line.To = WorldToEnd(LineTo)

            table.insert(Lines, {
                Line = Line,
                To = LineTo,
                From = Waypoints[Waypoint].Position
            })
        end

        task.spawn(function()
            for _,Line in next, Lines do
                local _, OnScreen = Camera:WorldToViewportPoint(Line.From)
                local Distance = (HumanoidRootPart.Position - Position).Magnitude

                if OnScreen then
                    Line.Line.Visible = true
                else
                    Line.Line.Visible = false
                end

                if Distance <= 5 then
                    for _, Line in next, Lines do
                        Line.Line:Destroy()
                    end
                    table.clear(Lines)
                end

                if #Lines > 0 then
                    local LastUpdate = tick();
                    if tick() - LastUpdate >= 60 then
                        for _, Line in next, Lines do
                            Line.Line:Destroy();
                        end
                        table.clear(Lines);
                    end
                end

                Line.Line.From = WorldToEnd(Line.From);
                Line.Line.To = WorldToEnd(Line.To);

            end
        end)
    end)

    if not Success then
        Lib.prompt("Error", "" .. Error, 5)
        return
    else
        Lib.prompt("Success", "Moved to position", 5)
    end

end

return pathfinding