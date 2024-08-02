local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local ESP = {}
local FLY = {}
local NOCLIP = {}
local FLING = {}
local noclipEnabled = false
local isFlying = false
local flingEnabled = false
local currentPlayers = {}
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local char = plr.Character or plr.CharacterAdded:Wait()
local hum :Humanoid = char:WaitForChild("Humanoid")
local rootpart = hum.RootPart
local bindable = script.Parent.Function
local guiLoaded = false
local gui = script.Parent
local Frame = gui.Frame
Frame.Visible = false
local FLY_SWITCH = Frame.FLY_SWITCH
local FLY_BUTTON = FLY_SWITCH.BUTTON
local ESP_SWITCH = Frame.ESP_SWITCH
local NOCLIP_SWITCH = Frame.NOCLIP_SWITCH
local NOCLIP_BUTTON = NOCLIP_SWITCH.BUTTON
local ESPbutton = ESP_SWITCH.BUTTON
local slider = ESP_SWITCH.SLIDER
local espEnabled = false

Frame.Draggable = true
Frame.Active = true


local sliderDisabledPos = UDim2.new({0.057, 0},{0.084, 0})
local sliderEnabledPos = UDim2.new({0.534, 0},{0.084, 0})


task.wait(1)

StarterGui:SetCore("SendNotification",{
	Title = "hello",
	Text = "do u want to load the script?",
	Duration = 10,
	Callback = bindable,
	Button1 = "Yes",
	Button2 = "No cause im a stinky nerd"
})

function bindable.OnInvoke(response)
	if response == "Yes" then
		script.Parent.Frame.Visible = true
		guiLoaded = true
	else
		script.Parent:Destroy()
	end
end

function getRigtype()
	if hum.RigType == Enum.HumanoidRigType.R15 then
		return Enum.HumanoidRigType.R15
	end
	if hum.RigType == Enum.HumanoidRigType.R6 then
		return Enum.HumanoidRigType.R6
	end
end

function ESP.Toggle(state)

	if state == true then
		print("Turning on esp")
		for i, c :Player in pairs(game.Players:GetChildren()) do
			print(c.Name)
			if not currentPlayers[c] then
				local highlight
				
				local success, errorMessage = pcall(function()
					highlight = Instance.new("Highlight")
					return highlight
				end)

				if success then
					print("Created highlight successfully.")
				else
					warn('Failed to create highlight: '..errorMessage)
				end
				
				if c.Character then
					print("character found")
					if highlight then
						table.insert(currentPlayers,c)
						print("inserted player to table, table as of now: ")
						print(currentPlayers)
						highlight.Adornee = c.Character
						highlight.OutlineTransparency = 1
						highlight.FillTransparency = 1
						highlight.FillColor = Color3.new(0.333333, 1, 1)
						highlight.Parent = c.Character
						
						local billboardGui = Instance.new("BillboardGui")
						billboardGui.Size = UDim2.new(4, 0,0.5, 0)								
						billboardGui.Parent = c.Character.Head
						billboardGui.Adornee = c.Character.Head
						billboardGui.AlwaysOnTop = true
						billboardGui.StudsOffset = Vector3.new(0,1,0)
						local textlabel = Instance.new("TextLabel")
						textlabel.BackgroundTransparency = 1
						textlabel.Size = UDim2.new(1,0,1,0)
						textlabel.Text = c.Name
						textlabel.TextColor3 = Color3.new(0.333333, 1, 1)
						textlabel.Parent = billboardGui
						
						TweenService:Create(highlight,TweenInfo.new(.5),{FillTransparency = 0}):Play()
						warn(highlight:GetFullName())
						warn(highlight.Name)
					end
					
				elseif c.Team then
					if highlight then
						table.insert(currentPlayers,c)
						print("player had a team, setting esp color")
						highlight.Adornee = c.Character
						highlight.OutlineTransparency = 1
						highlight.FillColor = c.Team.TeamColor
						highlight.FillTransparency = 1
						highlight.Parent = c.Character
						
						local billboardGui = Instance.new("BillboardGui")
						billboardGui.Size = UDim2.new(4, 0,0.5, 0)								
						billboardGui.Parent = c.Character.Head
						billboardGui.Adornee = c.Character.Head
						billboardGui.AlwaysOnTop = true
						billboardGui.StudsOffset = Vector3.new(0,1,0)
						local textlabel = Instance.new("TextLabel")
						textlabel.BackgroundTransparency = 1
						textlabel.Size = UDim2.new(1,0,1,0)
						textlabel.Text = c.Name
						textlabel.TextColor3 = c.TeamColor.Color
						textlabel.Parent = billboardGui
						
						TweenService:Create(highlight,TweenInfo.new(.5),{FillTransparency = 0}):Play()
						warn(highlight:GetFullName())
						warn(highlight.Name)
					end
				end
			end
		end

		game.Players.PlayerAdded:Connect(function(c)
			if not currentPlayers[c] then
				local highlight
				local success, errorMessage = pcall(function()
					highlight = Instance.new("Highlight")
					return highlight
				end)
				
				if success then
					print("Created highlight successfully.")
				else
					warn('Failed to create highlight: '..errorMessage)
				end
				
				if c.Character then
					if highlight then
						if not c.Neutral then
								warn("player had a team")
							if highlight then			
								table.insert(currentPlayers,c)
								highlight.Adornee = c.Character
								highlight.OutlineTransparency = 1
								highlight.OutlineColor = c.Team.TeamColor
								highlight.FillTransparency = 1
								highlight.FillColor = c.TeamColor.Color
								highlight.Adornee = c.Character
								highlight.Parent = c.Character
								highlight.Name = "esp"
								highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
								
								local billboardGui = Instance.new("BillboardGui")
								billboardGui.Size = UDim2.new(4, 0,0.5, 0)								
								billboardGui.Parent = c.Character.Head
								billboardGui.Adornee = c.Character.Head
								billboardGui.AlwaysOnTop = true
								billboardGui.StudsOffset = Vector3.new(0,1,0)
								local textlabel = Instance.new("TextLabel")
								textlabel.BackgroundTransparency = 1
								textlabel.Size = UDim2.new(1,0,1,0)
								textlabel.Text = c.Name
								textlabel.TextColor3 = c.TeamColor.Color
								textlabel.Parent = billboardGui
								TweenService:Create(highlight,TweenInfo.new(.5),{FillTransparency = 0}):Play()
							end
						else
							table.insert(currentPlayers,c)
							highlight.Adornee = c.Character
							highlight.OutlineTransparency = 1
							highlight.FillTransparency = 1
							highlight.Adornee = c.Character
							highlight.OutlineColor = Color3.new(0.333333, 1, 1)
							highlight.Parent = c.Character
							highlight.Name = "esp"
							highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
							
							local billboardGui = Instance.new("BillboardGui")
							billboardGui.Size = UDim2.new(4, 0,0.5, 0)								
							billboardGui.Parent = c.Character.Head
							billboardGui.Adornee = c.Character.Head
							billboardGui.AlwaysOnTop = true
							billboardGui.StudsOffset = Vector3.new(0,1,0)
							local textlabel = Instance.new("TextLabel")
							textlabel.BackgroundTransparency = 1
							textlabel.Size = UDim2.new(1,0,1,0)
							textlabel.Text = c.Name
							textlabel.TextColor3 = Color3.new(0.333333, 1, 1)
							textlabel.Parent = billboardGui
							
							TweenService:Create(highlight,TweenInfo.new(.5),{FillTransparency = 0}):Play()
						end
					end
				end
			end
		end)
	elseif state == false then
		local num = 1
		warn("disabling")
		for _, v in pairs(game.Players:GetChildren()) do
			warn("going through players..")
			if v.Character:FindFirstChild("Highlight") then
				table.remove(currentPlayers,num)
				num = num + 1
				warn("player had esp")
				
				task.spawn(function()
					TweenService:Create(v.Character.Highlight,TweenInfo.new(.5),{FillTransparency = 1}):Play()
					TweenService:Create(v.Character.Head.BillboardGui.TextLabel,TweenInfo.new(.5),{TextTransparency = 1}):Play()
					task.wait(.5)
					v.Character.Highlight:Destroy()
					v.Character.Head.BillboardGui:Destroy()
				end)
			end
		end
	end

end

function FLING.Toggle(state)
	if state then
		if getRigtype() == Enum.HumanoidRigType.R15 then
			if char.UpperTorso:FindFirstChild("BodyThrust") then
				char.UpperTorso.BodyThrust:Destroy()
			end
			
			plr.Character:FindFirstChild("UpperTorso").CanCollide = false
			plr.Character:FindFirstChild("LowerTorso").CanCollide = false
			plr.Character:FindFirstChild("Head").CanCollide = false
			plr.Character:FindFirstChild("HumanoidRootPart").CanCollide = false
			
			
			local bodyThrust = Instance.new("BodyThrust")
			bodyThrust.Force = Vector3.new(300,0,0)
			bodyThrust.Location = Vector3.new(0,0,300)
			bodyThrust.Parent = char.UpperTorso
			
		elseif getRigtype() == Enum.HumanoidRigType.R6 then
			if char.Torso:FindFirstChild("BodyThrust") then
				char.Torso.BodyThrust:Destroy()
			end
			
			plr.Character:FindFirstChild("Torso").CanCollide = false
			plr.Character:FindFirstChild("Head").CanCollide = false
			plr.Character:FindFirstChild("HumanoidRootPart").CanCollide = false
			
			
			local bodyThrust = Instance.new("BodyThrust")
			bodyThrust.Force = Vector3.new(300,0,0)
			bodyThrust.Location = Vector3.new(0,0,300)
			bodyThrust.Parent = char.Torso
		end
	else
		if getRigtype() == Enum.HumanoidRigType.R15 then
			if char.UpperTorso:FindFirstChild("BodyThrust") then
				plr.Character:FindFirstChild("UpperTorso").CanCollide = true
				plr.Character:FindFirstChild("LowerTorso").CanCollide = true
				plr.Character:FindFirstChild("Head").CanCollide = true
				plr.Character:FindFirstChild("HumanoidRootPart").CanCollide = true
				char.UpperTorso.BodyThrust:Destroy()
			end
		elseif getRigtype() == Enum.HumanoidRigType.R6 then
			if char.Torso:FindFirstChild("BodyThrust") then
				plr.Character:FindFirstChild("Torso").CanCollide = true
				plr.Character:FindFirstChild("Head").CanCollide = true
				plr.Character:FindFirstChild("HumanoidRootPart").CanCollide = true
				char.Torso.BodyThrust:Destroy()
			end
		end
	end
end

function NOCLIP.Toggle(state)
	if state == true then
		warn("toggled noclip")
		for L, v in pairs(char:GetChildren()) do
			if v:IsA("BasePart") or v:IsA("MeshPart") then
				v.CanCollide = false
			end
		end
	else
		for L, v in pairs(char:GetChildren()) do
			if v:IsA("BasePart") or v:IsA("MeshPart") then
				v.CanCollide = true
			end
		end
	end
end

function FLY.Fly(state)
	if state == true then
		isFlying = true
	else
		isFlying = false
		task.wait()
		
		for _, v in pairs(char:GetChildren()) do
			if v:IsA("BasePart") or v:IsA("MeshPart") then
				v.Anchored = false
			end
		end
	end
end

Frame.FLING_SWITCH.BUTTON.MouseButton1Click:Connect(function()
	gui.Click:Play()
	
	if not flingEnabled then
		TweenService:Create(Frame.FLING_SWITCH.SLIDER,TweenInfo.new(.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Position = Frame.FLING_SWITCH.G_SLIDER_ENABLED.Position,BackgroundColor3 = Color3.new(1, 1, 1)}):Play()
		flingEnabled = true
	else
		TweenService:Create(Frame.FLING_SWITCH.SLIDER,TweenInfo.new(.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Position = Frame.FLING_SWITCH.G_SLIDER_DISABLED.Position,BackgroundColor3 = Color3.new(0.486275, 0.486275, 0.486275)}):Play()
		flingEnabled = false
	end
	FLING.Toggle(flingEnabled)
end)

NOCLIP_BUTTON.MouseButton1Click:Connect(function()
	gui.Click:Play()
	if not noclipEnabled then
		noclipEnabled = true
		TweenService:Create(NOCLIP_SWITCH.SLIDER,TweenInfo.new(.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Position = NOCLIP_SWITCH.G_SLIDER_ENABLED.Position,BackgroundColor3 = Color3.new(1, 1, 1)}):Play()
	else
		noclipEnabled = false
		TweenService:Create(NOCLIP_SWITCH.SLIDER,TweenInfo.new(.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Position = NOCLIP_SWITCH.G_SLIDER_DISABLED.Position,BackgroundColor3 = Color3.new(0.486275, 0.486275, 0.486275)}):Play()
	end
	NOCLIP.Toggle(noclipEnabled)
end)

ESPbutton.MouseButton1Click:Connect(function()
	gui.Click:Play()
	if espEnabled == false then
		
		TweenService:Create(slider,TweenInfo.new(.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Position = ESP_SWITCH.G_SLIDER_ENABLED.Position,BackgroundColor3 = Color3.new(1, 1, 1)}):Play()
		
		ESP.Toggle(true)
		espEnabled = true
	else
		TweenService:Create(slider,TweenInfo.new(.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Position = ESP_SWITCH.G_SLIDER_DISABLED.Position,BackgroundColor3 = Color3.new(0.486275, 0.486275, 0.486275)}):Play()

		ESP.Toggle(false)
		espEnabled = false
	end
end)

FLY_BUTTON.MouseButton1Click:Connect(function()
	gui.Click:Play()
	if isFlying == false then

		TweenService:Create(FLY_SWITCH.SLIDER,TweenInfo.new(.2,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Position = FLY_SWITCH.G_SLIDER_ENABLED.Position,BackgroundColor3 = Color3.new(1, 1, 1)}):Play()

		FLY.Fly(true)
		isFlying = true
	else
		TweenService:Create(FLY_SWITCH.SLIDER,TweenInfo.new(.2,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut),{Position = FLY_SWITCH.G_SLIDER_DISABLED.Position,BackgroundColor3 = Color3.new(0.486275, 0.486275, 0.486275)}):Play()
		FLY.Fly(false)
		isFlying = false
		
		
	end
end)


RunService.RenderStepped:Connect(function()
	
	if isFlying then
		for _, v in pairs(char:GetChildren()) do
			if v:IsA("BasePart") or v:IsA("MeshPart") then
				v.Anchored = true
			end
		end
		
		char:PivotTo(CFrame.new(char:GetPivot().Position,mouse.Hit.Position))

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			char:PivotTo(CFrame.new(char:GetPivot().Position,mouse.Hit.Position) * CFrame.new(0,0,-1))
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			char:PivotTo(CFrame.new(char:GetPivot().Position,mouse.Hit.Position) * CFrame.new(0,0,1))
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			char:PivotTo(CFrame.new(char:GetPivot().Position,mouse.Hit.Position) * CFrame.new(-1,0,0))
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			char:PivotTo(CFrame.new(char:GetPivot().Position,mouse.Hit.Position) * CFrame.new(1,0,0))
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			char:PivotTo(CFrame.new(char:GetPivot().Position,mouse.Hit.Position) * CFrame.new(0,1,0))
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
			char:PivotTo(CFrame.new(char:GetPivot().Position,mouse.Hit.Position) * CFrame.new(0,-1,0))
		end
	end
	
	if noclipEnabled then
		for L, v in pairs(char:GetChildren()) do
				if v:IsA("BasePart") or v:IsA("MeshPart") then
				v.CanCollide = false
			end
		end
	end
end)

return ESP, FLY, NOCLIP, FLING
