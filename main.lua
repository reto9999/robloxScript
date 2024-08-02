local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local ESP = {}

local currentPlayers = {}

local bindable = script.Parent.Function
local guiLoaded = false
local gui = script.Parent
local Frame = gui.Frame
Frame.Visible = false
local ESP_SWITCH = Frame.ESP_SWITCH
local ESPbutton = ESP_SWITCH.BUTTON
local slider = ESP_SWITCH.SLIDER
local espEnabled = false


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



return ESP
