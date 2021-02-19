local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/finayv2/Ui-Lib/main/azure%20ui%20lib%20modified.lua", true))()
if not getgenv().MTAPIMutex then loadstring(game:HttpGet("https://raw.githubusercontent.com/KikoTheDon/MT-Api-v2/main/__source/mt-api%20v2.lua", true))() end

getgenv().AlreadyExecuted = false

local LocalSA = getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.LocalStuff)


local LocalPlayerTab = Library:CreateTab("LocalPlayer", "LocalPlayer Tab", "Dark")


LocalPlayerTab:CreateToggle("No Stun & Cooldown", function(value) 
    shared.NoStun = value
    while wait() do
        if shared.NoStun then
			for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v:IsA("Folder") then
					if v.Name == "PUNCHM2COOLDOWN" or v.Name == "Busy" or v.Name == "Superslow" or v.Name == "Comboing" or v.Name == "PunchCooldown" or v.Name == "CTag" or v.Name == "Helpless" or v.Name == "StepBlock" or v.Name == "Staggered" or v.Name == "Superamor" or v.Name == "manashield" or v.Name == "IFrames" or v.Name == "BeserkCooldown" then
						v:Remove()
					end
				end
				if v:IsA("Tool") then
					if v:FindFirstChild("Cooldown") then
						v.Cooldown:Remove()
					elseif v:FindFirstChild("MainCooldown") then
						v.MainCooldown:Remove()
					elseif v:FindFirstChild("MisogiCooldown") then
						v.MisogiCooldown:Remove()
					elseif v:FindFirstChild("WhiteFlameCooldown") then
						v.WhiteFlameCooldown:Remove()
					elseif v:FindFirstChild("IceCooldown") then
						v.IceCooldown:Remove()
					elseif v:FindFirstChild("FlameCooldown") then
						v.FlameCooldown:Remove()
					elseif v:FindFirstChild("ThunderCooldown") then
					
						v.ThunderCooldown:Remove()
					elseif v:FindFirstChild("DFCooldown") then

						v.DFCooldown:Remove()
					end
				end
			end		
        end
    end
end)

--[[

LocalPlayerTab:CreateToggle("No Cooldown Dodge", function(value) 
    shared.NoCooldownDodge = value
end)
spawn(function()
	ogWait = hookfunction(wait, function(x)
		if shared.NoCooldownDodge and getcallingscript().Name == "LocalStuff" and not checkcaller() and x == 2 then
			return ogWait(0.1)
		else
			return ogWait(x)
		end
	end) 
end)

-]]

LocalPlayerTab:CreateToggle("Remove Kill Bricks", function(value) 
    shared.RemoEKillBricks = value
	if shared.RemoEKillBricks then
		for i,v in pairs(game:GetService("Workspace").Map:GetChildren()) do
			if v.Name == "Kill" then
				if v:FindFirstChild("TouchInterest") then
					v:FindFirstChild("TouchInterest"):Remove()
				end
			end
		end
    end
end)

LocalPlayerTab:CreateToggle("Auto Mod Panic", function(value) 
    shared.AutoModPanic = value
end)

local LastPosition;

LocalPlayerTab:CreateToggle("Artifact Hopper", function(value) 
    shared.ARF = value
    while wait() do
		if shared.ARF then
			LastPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
			for i,v in pairs(game.Workspace:GetChildren()) do
				if v:IsA("Tool") then
					if v.Name == "Lannis Amulet" or v.Name == "Fairfrozen" or v.Name == "Lost Bulwark" or v.Name == "Spider Cloak" or v.Name == "Philo Stone" or v.Name == "Betrayer's Amulet" or v.Name == "Angel Feather" or v.Name == "Lost Bulwark" or v.Name == "MemoryDisc" or v.Name == "Phoenix Feather" then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = LastPosition
					end
				end
			end
        end
    end
end)


shared.WalkSpeedValue = 16

LocalPlayerTab:CreateSlider("WalkSpeed", 16, 500, function(arg) 
	shared.WalkSpeedValue = arg
end)

LocalPlayerTab:CreateSlider("Hitbox Extender", 3, 350, function(arg) 

	for i,v in next, game:GetService('Players'):GetPlayers() do
		if v.Name ~= game:GetService('Players').LocalPlayer.Name then
			pcall(function()
				if arg == 3 then 
					v.Character:FindFirstChild("HumanoidRootPart").Size = Vector3.new(2, 2, 1)
					v.Character:FindFirstChild("HumanoidRootPart").Transparency = 1
					v.Character:FindFirstChild("HumanoidRootPart").BrickColor = BrickColor.new("Medium stone grey")
					v.Character:FindFirstChild("HumanoidRootPart").Material = "Plastic"
					v.Character:FindFirstChild("HumanoidRootPart").CanCollide = true
					return
				end
				v.CharacterAdded:Connect(function(p)
					if arg == 3 then return end
					if v.Character:WaitForChild("HumanoidRootPart") then
						v.Character:FindFirstChild("HumanoidRootPart").Size = Vector3.new(arg,arg,arg)
						v.Character:FindFirstChild("HumanoidRootPart").Transparency = 0.9
						v.Character:FindFirstChild("HumanoidRootPart").BrickColor = BrickColor.new("Really blue")
						v.Character:FindFirstChild("HumanoidRootPart").Material = "Neon"
						v.Character:FindFirstChild("HumanoidRootPart").CanCollide = false
					end
				end)
				v.Character:FindFirstChild("HumanoidRootPart").Size = Vector3.new(arg,arg,arg)
				v.Character:FindFirstChild("HumanoidRootPart").Transparency = 0.9
				v.Character:FindFirstChild("HumanoidRootPart").BrickColor = BrickColor.new("Really blue")
				v.Character:FindFirstChild("HumanoidRootPart").Material = "Neon"
				v.Character:FindFirstChild("HumanoidRootPart").CanCollide = false
			end)
			
		end
	end

end)

game.Players.LocalPlayer.CharacterAdded:Connect(function(p)
	p:WaitForChild("Humanoid").Changed:Connect(function()
		if shared.WalkSpeedValue == 16 then return end
	
		p.Humanoid.WalkSpeed = shared.WalkSpeedValue
	
	end)
end)

game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Changed:Connect(function()
	if shared.WalkSpeedValue == 16 then return end

	game.Players.localPlayer.Character:WaitForChild("Humanoid").WalkSpeed = shared.WalkSpeedValue

end)


local GateSpots = {
	["SkyCastle"] = game:GetService("Workspace").MouseIgnore.GateSpots.Skycastle.CFrame;
	["Deepforest 1"] = game:GetService("Workspace").MouseIgnore.GateSpots.Deepforest.Entrance.CFrame;
	["Deepforest 2"] = game:GetService("Workspace").MouseIgnore.GateSpots.Deepforest.Tree.CFrame;
	["Tundra 1"] = game:GetService("Workspace").MouseIgnore.GateSpots.Tundra.Black.CFrame;
	["Tundra 2"] = game:GetService("Workspace").MouseIgnore.GateSpots.Tundra.Ridge.CFrame;
	["Tundra 3"] = game:GetService("Workspace").MouseIgnore.GateSpots.Tundra.Hoss.CFrame;
	["Tundra 4"] = game:GetService("Workspace").MouseIgnore.GateSpots.Tundra.Cave.CFrame;
	["Tundra 5"] = game:GetService("Workspace").MouseIgnore.GateSpots.Tundra.Sigma.CFrame;
	["Tundra 6"] = game:GetService("Workspace").MouseIgnore.GateSpots.Tundra.Enibras.CFrame;
}

local Gat = {}

for i,v in pairs(GateSpots) do
	table.insert(Gat, i)
end


LocalPlayerTab:CreateDropDown("Gate Teleports", Gat, function(Talker) 
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = GateSpots[Talker]
end)

LocalPlayerTab:CreateButton("Hide Nickname", function() 
	game.Players.LocalPlayer.Character.CharacterName.Head:Remove()
end)

LocalPlayerTab:CreateButton("Naked", function() 
	game.Players.LocalPlayer.Character.CharacterName.Head:Remove()
end)

-- ! status tab
local StatusTab = Library:CreateTab("Status", "Status Tab", "Dark")

StatusTab:CreateToggle("No Injuries", function(value) 
    shared.NoInjuries = value
    while wait() do
		if shared.NoInjuries then
			for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v.Name == "Impaled" then
					v:Remove()
				end
			end
		end
	end
end)

StatusTab:CreateToggle("No Fall Damage", function(value) 
    shared.NoFall = value
	if shared.NoFall then
		
		game.Players.LocalPlayer.Character.Humanoid.FallingDown:Connect(function(isActive)
			local Float = Instance.new('Part')
			Float.Name = math.random(1,40000)
			Float.Parent = game.Players.LocalPlayer.Character
			Float.Transparency = 1
			Float.Size = Vector3.new(6,1,6)
			Float.Anchored = true
			Float.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3.5,0)
			Float.CanCollide = true

			wait(0.4)

			Float.CanCollide = false
		end)

	end
	
end)

StatusTab:CreateToggle("No Fire", function(value) 
    shared.NoFire = value
    while wait() do
		if shared.NoFire then
			for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v:IsA("Folder") then
					if v.Name == "Flames" or v.Name == "WhiteFlames" or v.Name == "BlackFlames" or v.Name == "BlackFlamesStack" then
						v:Remove()
					end
				end
			end	
        end
    end
end)

StatusTab:CreateToggle("No Curse Stacks", function(value) 
    shared.NoCS = value
    while wait() do
        if shared.NoCS then
			for i,v in pairs(game.Players.LocalPlayer.Character.Stats.CStacks:GetChildren()) do
				v:Remove()
			end
        end
    end
end)


StatusTab:CreateToggle("No Walkspeed Penality", function(value) 
    shared.NwalksPEP = value
    while wait() do
        if shared.NwalksPEP then
			for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v.Name == "NoSpeedUpdate" then
					v:Remove()
				end
			end
        end
    end
end)

StatusTab:CreateToggle("No Ragdoll", function(value) 
    shared.NoRagdoll = value
    while wait() do
        if shared.NoRagdoll then
			for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v:IsA("Folder") then
					if v.Name == "Ragdolled" then
						v:Remove()
					end
				end
			end
        end
    end
end)


StatusTab:CreateToggle("No Poison", function(value) 
    shared.NOPOSITON = value
    while wait() do
        if shared.NOPOSITON then
			for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v:IsA("Folder") then
					if v.Name == "Poison" then
						v:Remove()
					end
				end
			end
        end
    end
end)



StatusTab:CreateToggle("No Cooldown Artifacts", function(value) 
    shared.NoCooldownArtifacts = value
    while wait() do
		if shared.NoCooldownArtifacts then
			for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v.Name == "ANGELFEATHERCD" or v.Name == "LannisCD" then
					v:Remove()
				end
			end
		end
	end
end)

StatusTab:CreateToggle("No Cooldown Dodge", function(value) 
    shared.CDDODGE = value
    while wait() do
		if shared.CDDODGE then
			print("coming soon")
		end
	end
end)

StatusTab:CreateToggle("No Cooldown Jump", function(value) 
    shared.NoDouble = value
    while wait() do
		if shared.NoDouble then
			LocalSA.DoubleJumpingAvailable = true 
		end
	end
end)


local ManaTab = Library:CreateTab("Mana", "Mana Tab")

local ManaValue = 0

ManaTab:CreateToggle("Mana Adjust", function(value) 
    shared.InfMana = value
    while wait() do
        if shared.InfMana then
			game:GetService("Players").LocalPlayer.Character.ManaCharge.Value = false

			if game:GetService("Players").LocalPlayer.Character.Stats.Mana.Value >= ManaValue then

				game:GetService("Players").LocalPlayer.Character.ManaChargeEnd:FireServer()

			else

				game:GetService("Players").LocalPlayer.Character.ManaChargeStart:FireServer()
			end
        end
    end
end)

ManaTab:CreateToggle("No Cooldown Snap", function(value) 
    shared.NOCDSNAP = value
    while wait() do
		if shared.NOCDSNAP then
			for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v.Name == "SnapCooldown" then
					v:Remove()
				end
			end
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
    game.Players.LocalPlayer.Character.Stats.ClimbMult.Value = arg
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




local newmusic = Instance.new("Sound")
newmusic.Parent = game.Workspace
newmusic.SoundId = "rbxassetid://1579337956"
newmusic.Name = "RUN MODS"

local Success, ErrorStatement = pcall(function()
	local Admins = {
		["shadow8877sonic"] = "49712669";
		["Iockpickk"] = "249882496";
		["thegamerfromtheskys"] = "49337985";
		["Drapid"] = "58678007";
		["T32M"] = "72561679";
		["theoowen"] = "16809832";
		["Vluved"] = "86265797";
		["Fri_ckyy"] = "120405687";
		["Horatl0"] = "33092329";
		["Crazecoop"] = "56137950";
		["Seadoke18"] = "46442436";
		["BestNameInGame"] = "68198392";
		["stahby"] = "322304665";
		["Firmliest"] = "143568777";
		["goIdiee"] = "58373448";
		["SentinelLosing"] = "1725860698";
	
	}

	function GetArtifact()
		for i,v in pairs(game.Workspace:GetChildren()) do
			if v:IsA("Tool") then
				if v.Name == "Lannis Amulet" or v.Name == "Fairfrozen" or v.Name == "Lost Bulwark" or v.Name == "Spider Cloak" or v.Name == "Philo Stone" or v.Name == "Betrayer's Amulet" or v.Name == "Angel Feather" or v.Name == "Lost Bulwark" or v.Name == "Spider Cloak" or v.Name == "MemoryDisc" or v.Name == "Phoenix Feather" then
					return v	
				end
			end
		end
	end

	function Callback(Text)
		if Text == "Panic" then
			game.Players.LocalPlayer:Kick("\n\nSafely Kicked you from the game.\n")
		elseif Text == "Teleport To" then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = GetArtifact().Handle.CFrame
			print(self.Text)
		end
	end
	
	local NotificationBindable = Instance.new("BindableFunction")
	NotificationBindable.OnInvoke = Callback
	
	function AutoModKick()
		if shared.AutoModPanic then
			game.Players.LocalPlayer:Kick("\n\nSafely Kicked you from the game.\n")
		end
	end
	
	
	for i,v in pairs(game.Players:GetPlayers()) do
		for I,V in pairs(Admins) do
			if v.Name == I or v:IsFriendsWith(V) then
				print("ADMIN DETECTED")
				game.StarterGui:SetCore("SendNotification", {
					Title = "Admin Notify";
					Text = v.Name .. " Is in the game And Is A Mod/Admin";
					Duration = 6;
					Button1 = "Panic";
	
					Callback = NotificationBindable;
				})
	
				spawn(function()
					newmusic:Play()
					wait(6.5)
					newmusic:Stop()
				end)
				AutoModKick()
			end
		end
	end
	
	game.Players.PlayerAdded:Connect(function(v)
		for I,V in pairs(Admins) do
			if v.Name == I or v:IsFriendsWith(V) then
				print("ADMIN DETECTED")
				game.StarterGui:SetCore("SendNotification", {
					Title = "Admin Notify";
					Text = v.Name .. " Has Joined And Is A Mod/Admin";
					Duration = 6;
					Button1 = "Panic";
	
					Callback = NotificationBindable;
				})
				spawn(function()
					newmusic:Play()
					wait(6.5)
					newmusic:Stop()
				end)
				AutoModKick()
			end
		end
	end)
	
	game.Players.PlayerRemoving:Connect(function(v)
		for I,V in pairs(Admins) do
			if v.Name == I then
				print("ADMIN DETECTED")
				game.StarterGui:SetCore("SendNotification", {
					Title = "Admin Notify";
					Text = v.Name .. " Has Left And Is A Mod/Admin";
					Duration = 6;
					Button1 = "Panic";
	
					Callback = NotificationBindable;
				})
				spawn(function()
					newmusic:Play()
					wait(6.5)
					newmusic:Stop()
				end)
			end
		end
	end)

	
end)


if ErrorStatement then
	game.Players.LocalPlayer:Kick("\n\nVERY IMPORTANT ERROR HAS OCCURED PLEASE DM cyzer#3829.\n")
	error(ErrorStatement)
end



game.Workspace.ChildAdded:Connect(function(v)
	if v:IsA("Tool") then
		if v.Name == "Lannis Amulet" or v.Name == "Fairfrozen" or v.Name == "Lost Bulwark" or v.Name == "Spider Cloak" or v.Name == "Philo Stone" or v.Name == "Betrayer's Amulet" or v.Name == "Angel Feather" or v.Name == "Lost Bulwark" or v.Name == "Spider Cloak" or v.Name == "MemoryDisc" or v.Name == "Phoenix Feather" then
			game.StarterGui:SetCore("SendNotification", {
				Title = "Artifact Notify";
				Text = v.Name .. " Has Spawned";
				Duration = 6;
				Button1 = "Teleport To";
	
				Callback = NotificationBindable;
			})		
		end
	end
end)

for i,v in pairs(game.Workspace:GetChildren()) do
	if v:IsA("Tool") then
		if v.Name == "Lannis Amulet" or v.Name == "Fairfrozen" or v.Name == "Lost Bulwark" or v.Name == "Spider Cloak" or v.Name == "Philo Stone" or v.Name == "Betrayer's Amulet" or v.Name == "Angel Feather" or v.Name == "Lost Bulwark" or v.Name == "Spider Cloak" or v.Name == "MemoryDisc" or v.Name == "Phoenix Feather" then
			game.StarterGui:SetCore("SendNotification", {
				Title = "Artifact Notify";
				Text = v.Name .. " Has Spawned";
				Duration = 6;
				Button1 = "Teleport To";
	
				Callback = NotificationBindable;
			})		
		end
	end
end

fireclickdetector(game:GetService("Workspace").Map.DyePackets.Part.ClickDetector)

getgenv().AlreadyExecuted = true
