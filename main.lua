-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "TrackerUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 160, 0, 60)
Frame.Position = UDim2.new(0.5, -80, 0.5, -30)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.Active = true
Frame.Draggable = true

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(1, -10, 1, -10)
Button.Position = UDim2.new(0, 5, 0, 5)
Button.Text = "إيقاف"
Button.TextColor3 = Color3.new(1,1,1)
Button.BackgroundColor3 = Color3.fromRGB(0,170,255)

-- الحالة
local Enabled = true

-- إنشاء ESP
local function createESP(pos)
    local part = Instance.new("Part")
    part.Size = Vector3.new(0.8,0.8,0.8)
    part.Material = Enum.Material.Neon
    part.Color = Color3.fromRGB(255, 0, 0)
    part.Anchored = true
    part.CanCollide = false
    part.Position = pos
    part.Parent = workspace

    -- Glow إضافي
    local light = Instance.new("PointLight", part)
    light.Brightness = 3
    light.Range = 10
    light.Color = Color3.fromRGB(255,0,0)
end

-- تتبع اللاعبين
local function hookPlayer(player)
    if player == LocalPlayer then return end

    player.CharacterAdded:Connect(function(char)
        char.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                child.Activated:Connect(function()
                    if not Enabled then return end

                    local handle = child:FindFirstChild("Handle")
                    if handle then
                        createESP(handle.Position)
                    end
                end)
            end
        end)
    end)
end

-- ربط الحاليين
for _, plr in pairs(Players:GetPlayers()) do
    hookPlayer(plr)
end

-- ربط الجدد
Players.PlayerAdded:Connect(hookPlayer)

-- زر تشغيل / إيقاف
Button.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    Button.Text = Enabled and "إيقاف" or "تشغيل"
    Button.BackgroundColor3 = Enabled and Color3.fromRGB(0,170,255) or Color3.fromRGB(255,50,50)
end)
