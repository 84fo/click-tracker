-- FIXED Friend Tool (Working 100%)

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- ننتظر عشان SetCore يشتغل
repeat task.wait() until game:IsLoaded()
task.wait(2)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FriendTool"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 400)
frame.Position = UDim2.new(0.5, -160, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Friend Tool (Working)"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

-- قائمة
local scrolling = Instance.new("ScrollingFrame", frame)
scrolling.Size = UDim2.new(1, -20, 0, 230)
scrolling.Position = UDim2.new(0, 10, 0, 40)
scrolling.BackgroundColor3 = Color3.fromRGB(35,35,35)

local layout = Instance.new("UIListLayout", scrolling)

-- دالة آمنة لفتح طلب صداقة
local function sendRequest(plr)
    pcall(function()
        StarterGui:SetCore("PromptSendFriendRequest", plr)
    end)
end

-- تحديث القائمة
local function refresh()
    for _, v in pairs(scrolling:GetChildren()) do
        if v:IsA("Frame") then
            v:Destroy()
        end
    end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            local item = Instance.new("Frame", scrolling)
            item.Size = UDim2.new(1, -10, 0, 30)
            item.BackgroundTransparency = 1

            local name = Instance.new("TextLabel", item)
            name.Size = UDim2.new(0.6, 0, 1, 0)
            name.Text = plr.Name
            name.TextColor3 = Color3.new(1,1,1)
            name.BackgroundTransparency = 1

            local btn = Instance.new("TextButton", item)
            btn.Size = UDim2.new(0.4, 0, 1, 0)
            btn.Position = UDim2.new(0.6, 0, 0, 0)
            btn.Text = "Add"
            btn.BackgroundColor3 = Color3.fromRGB(0,170,255)
            btn.TextColor3 = Color3.new(1,1,1)

            btn.MouseButton1Click:Connect(function()
                sendRequest(plr)
            end)
        end
    end

    task.wait()
    scrolling.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y)
end

refresh()
Players.PlayerAdded:Connect(refresh)
Players.PlayerRemoving:Connect(refresh)

-- زر إرسال الكل
local sendAll = Instance.new("TextButton", frame)
sendAll.Size = UDim2.new(1, -20, 0, 40)
sendAll.Position = UDim2.new(0, 10, 0, 280)
sendAll.Text = "Send All"
sendAll.BackgroundColor3 = Color3.fromRGB(0,170,255)
sendAll.TextColor3 = Color3.new(1,1,1)

sendAll.MouseButton1Click:Connect(function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            sendRequest(plr)
            task.wait(0.8)
        end
    end
end)

-- تغيير سيرفر
local hop = Instance.new("TextButton", frame)
hop.Size = UDim2.new(1, -20, 0, 40)
hop.Position = UDim2.new(0, 10, 0, 330)
hop.Text = "Server Hop"
hop.BackgroundColor3 = Color3.fromRGB(0,255,100)
hop.TextColor3 = Color3.new(1,1,1)

hop.MouseButton1Click:Connect(function()
    TeleportService:Teleport(game.PlaceId, player)
end)
