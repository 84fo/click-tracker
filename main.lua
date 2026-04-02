-- Auto Ready + Draggable Friend Tool

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FriendTool"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 350)
frame.Position = UDim2.new(0.5, -150, 0.5, -175)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true -- 🔥 تحريك

-- عنوان
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Friend Tool"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

-- قائمة
local scrolling = Instance.new("ScrollingFrame", frame)
scrolling.Size = UDim2.new(1, -20, 0, 180)
scrolling.Position = UDim2.new(0, 10, 0, 40)
scrolling.BackgroundColor3 = Color3.fromRGB(35,35,35)

local layout = Instance.new("UIListLayout", scrolling)

-- تحديث القائمة
local function refreshList()
    for _, v in pairs(scrolling:GetChildren()) do
        if v:IsA("TextLabel") then
            v:Destroy()
        end
    end

    for _, plr in pairs(Players:GetPlayers()) do
        local name = Instance.new("TextLabel", scrolling)
        name.Size = UDim2.new(1, -10, 0, 25)
        name.Text = plr.Name
        name.TextColor3 = Color3.new(1,1,1)
        name.BackgroundTransparency = 1
    end

    task.wait()
    scrolling.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y)
end

refreshList()
Players.PlayerAdded:Connect(refreshList)
Players.PlayerRemoving:Connect(refreshList)

-- زر إرسال
local sendBtn = Instance.new("TextButton", frame)
sendBtn.Size = UDim2.new(1, -20, 0, 40)
sendBtn.Position = UDim2.new(0, 10, 0, 230)
sendBtn.Text = "Send Requests"
sendBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)
sendBtn.TextColor3 = Color3.new(1,1,1)

sendBtn.MouseButton1Click:Connect(function()
    local sent = 0
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            pcall(function()
                player:RequestFriendship(plr)
                sent += 1
                task.wait(1)
            end)
        end
    end
    sendBtn.Text = "Sent: "..sent
    task.wait(2)
    sendBtn.Text = "Send Requests"
end)

-- زر سيرفر جديد
local hopBtn = Instance.new("TextButton", frame)
hopBtn.Size = UDim2.new(1, -20, 0, 40)
hopBtn.Position = UDim2.new(0, 10, 0, 280)
hopBtn.Text = "Server Hop"
hopBtn.BackgroundColor3 = Color3.fromRGB(0,255,100)
hopBtn.TextColor3 = Color3.new(1,1,1)

hopBtn.MouseButton1Click:Connect(function()
    TeleportService:Teleport(game.PlaceId, player)
end)
