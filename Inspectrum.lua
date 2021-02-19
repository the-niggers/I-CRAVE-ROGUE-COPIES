local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/finayv2/Ui-Lib/main/azure%20ui%20lib%20modified.lua", true))()

local LocalPlayerTab = Library:CreateTab("LocalPlayer", "LocalPlayer Tab", "Dark")

LocalPlayerTab:CreateToggle("No Stun & Cooldown", function(value) 
    shared.NoStun = value
    while wait() do
        if shared.NoStun then
            for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v.Name == "stunned" then
                    v:Destroy()
                end
            end
        end
    end
end)

LocalPlayerTab:CreateToggle("Temp Lock", function(value) 
    shared.TempLock = value
    while wait() do
        if shared.TempLock then
            game:GetService("ReplicatedStorage").Requests.UpdateArea:FireServer("The Ravine")
        end
    end
end)



LocalPlayerTab:CreateToggle("Remove Kill Bricks", function(value) 
    shared.RemoEKillBricks = value
	if shared.RemoEKillBricks then
        print('sex')
    end
end)

local FallDamageScript = game.Players.LocalPlayer.Character.FallDamage

LocalPlayerTab:CreateToggle("No Fall Damage", function(value) 
    shared.NoFall = value

	if shared.NoFall then
        FallDamageScript.Parent = nil
    else
        FallDamageScript.Parent = game.Players.LocalPlayer.Character
	end
	
end)

LocalPlayerTab:CreateToggle("No Fire", function(value) 
    shared.NoFire = value
    while wait() do
		if shared.NoFire then

            game:GetService("ReplicatedStorage").Events.StopFire:FireServer()

        end
    end
end)

local ManaTab = Library:CreateTab("Mana", "Mana Tab")

local ManaValue = 0

ManaTab:CreateToggle("Mana Adjust", function(value) 
    shared.InfMana = value
    while wait() do
        if shared.InfMana then
            game.Players.LocalPlayer.Character.Values.Actions.Mana.Value = ManaValue
        else
            game.Players.LocalPlayer.Character.Values.Actions.Mana.Value = 0
        end
    end
end)



local Spells = {
	["Ignis"] = 80;
	["Gelidus"] = 80;
	["Tenebris"] = 100;
	["Gate"] = 83;
	["Fimbulvetr"] = 85;
	["Radium"] = 85;
	["Percutiens"] = 65;
}

ManaTab:CreateToggle("Spell Adjust", function(value) 
    shared.SpellAbjust = value
    while wait() do
		if shared.SpellAbjust then
			for i,v in pairs(Spells) do
				for I,V in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if V:IsA("Tool") then
						if V.Name == i then
							
							game:GetService("Players").LocalPlayer.Character.ManaCharge.Value = false

							if game:GetService("Players").LocalPlayer.Character.Stats.Mana.Value >= Spells[V.Name] then

								game:GetService("Players").LocalPlayer.Character.ManaChargeEnd:FireServer()

							else

								game:GetService("Players").LocalPlayer.Character.ManaChargeStart:FireServer()
							end
						end
					end
				end
			end
        end
    end
end)


ManaTab:CreateSlider("Mana Amount", 0, 100, function(arg) 
    ManaValue = arg
end)

ManaTab:CreateSlider("Mana Climb Speed", 1, 350, function(arg) 
    game:GetService("Players").LocalPlayer.ClimbLvl.Value = arg
    game.Players.LocalPlayer.Character.charvar.ClimbLvl.Value = arg
end)


local FarmTab = Library:CreateTab("Farm", "Farm Tab", "Dark")

FarmTab:CreateToggle("Auto Pickup", function(value) 
    shared.Autopickup = value
    while wait() do
        if shared.Autopickup then
            for i,v in pairs(game:GetService("Workspace").Items:GetChildren()) do
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).magnitude <= 10 then
                    fireclickdetector(v.ClickDetector, 4)
                end
            end
        end
    end
end)

FarmTab:CreateToggle("AutoFarm Hopper", function(value) 
    shared.AutoFarm = value

    if shared.AutoFarm then
        local x = {}
        for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
            if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
                x[#x + 1] = v.id
            end
        end
        
        for i,v in pairs(game:GetService("Workspace").Items:GetChildren()) do
            if #game:GetService("Workspace").Items:GetChildren() <= 4 then
                if #x > 0 then
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
                end
            end
            
            for i = 1, 2 do
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            end
            wait(0.4)
            fireclickdetector(v.ClickDetector, 4)
        end
    end
end)

local VisualTab = Library:CreateTab("Visuals", "Visuals Tab")


VisualTab:CreateToggle("No Fog", function(value) 
    shared.NoFog = value
    while wait() do
		if shared.NoFog then
			game:GetService("Lighting").FogEnd = 1000000
		else
			game:GetService("Lighting").FogEnd = 500
        end
    end
end)

VisualTab:CreateToggle("Full Bright", function(value) 
    shared.FullBright = value
    if shared.FullBright then
        game:GetService("Lighting").Changed:Connect(function()
            if not shared.FullBright then return end
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").ClockTime = 14
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        end)
    else
        game:GetService("Lighting").Brightness = 1
        game:GetService("Lighting").GlobalShadows = true
        game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(161, 161, 161)
    end
end)

VisualTab:CreateToggle("Max Zoom", function(value) 
    shared.MaxZoom = value
	if shared.MaxZoom then
		game.Players.LocalPlayer.CameraMaxZoomDistance = math.huge
	else
        game.Players.LocalPlayer.CameraMaxZoomDistance = 50
    end
end)

for i,v in pairs(game:GetService("JointsService"):GetChildren()) do
    v:Remove()
end
