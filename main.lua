-- GUI + Teleport Script

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- متغير حفظ المكان
local savedPosition = nil

-- إنشاء GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0.5, -100, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = screenGui

-- زر حفظ المكان
local setButton = Instance.new("TextButton")
setButton.Size = UDim2.new(1, -20, 0, 40)
setButton.Position = UDim2.new(0, 10, 0, 10)
setButton.Text = "Set Location"
setButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
setButton.TextColor3 = Color3.new(1,1,1)
setButton.Parent = frame

-- زر النقل
local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(1, -20, 0, 40)
tpButton.Position = UDim2.new(0, 10, 0, 60)
tpButton.Text = "Teleport"
tpButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
tpButton.TextColor3 = Color3.new(1,1,1)
tpButton.Parent = frame

-- حفظ المكان
setButton.MouseButton1Click:Connect(function()
    if hrp then
        savedPosition = hrp.CFrame
        setButton.Text = "Saved!"
        wait(1)
        setButton.Text = "Set Location"
    end
end)

-- النقل
tpButton.MouseButton1Click:Connect(function()
    if hrp and savedPosition then
        hrp.CFrame = savedPosition
    else
        tpButton.Text = "No Location!"
        wait(1)
        tpButton.Text = "Teleport"
    end
end)
