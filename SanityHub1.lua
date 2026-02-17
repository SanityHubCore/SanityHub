-- [[ 🧠 SANITY HUB: SABB EDITION ]]
-- GAME: STEAL A BRAINROT
-- STATUS: KEY SYSTEM + WHITELIST + OP FEATURES

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local lp = Players.LocalPlayer
local Mouse = lp:GetMouse()

-- =================================================================
-- 🔐 SECURITY & CONFIG
-- =================================================================

local CONFIG = {
    Key = "ONION", -- The Key for normal users
    Discord = "https://discord.gg/HWUb2PxeSu",
    Whitelist = {
        12345678, -- REPLACE WITH YOUR USER ID
        87654321, -- C4VIT's ID (Example)
    }
}

local function CheckWhitelist()
    for _, id in pairs(CONFIG.Whitelist) do
        if lp.UserId == id then return true end
    end
    return false
end

-- =================================================================
-- 🎨 SANITY UI ENGINE (DARK MATTER)
-- =================================================================

local Parent = CoreGui:FindFirstChild("RobloxGui") or CoreGui
if Parent:FindFirstChild("SanitySABB") then Parent.SanitySABB:Destroy() end

local Gui = Instance.new("ScreenGui")
Gui.Name = "SanitySABB"
Gui.Parent = Parent
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.ResetOnSpawn = false

local C = {
    Bg = Color3.fromRGB(10, 10, 14),
    Dark = Color3.fromRGB(15, 15, 20),
    Accent = Color3.fromRGB(130, 80, 255), -- Sanity Purple
    Text = Color3.fromRGB(240, 240, 240),
    Red = Color3.fromRGB(255, 60, 60),
    Green = Color3.fromRGB(60, 255, 100)
}

local function MakeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = obj.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- =================================================================
-- 🔑 KEY SYSTEM UI
-- =================================================================

local KeyFrame = Instance.new("Frame", Gui)
KeyFrame.Size = UDim2.new(0, 400, 0, 250)
KeyFrame.Position = UDim2.new(0.5, -200, 0.4, 0)
KeyFrame.BackgroundColor3 = C.Bg
KeyFrame.Visible = not CheckWhitelist() -- Hide if whitelisted
MakeDraggable(KeyFrame)
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 10)
local KStr = Instance.new("UIStroke", KeyFrame); KStr.Color = C.Accent; KStr.Thickness = 2

local KTitle = Instance.new("TextLabel", KeyFrame)
KTitle.Text = "SECURITY GATEWAY"
KTitle.Font = Enum.Font.GothamBlack
KTitle.TextSize = 20
KTitle.TextColor3 = C.Accent
KTitle.Size = UDim2.new(1, 0, 0, 50)
KTitle.BackgroundTransparency = 1

local KInput = Instance.new("TextBox", KeyFrame)
KInput.Size = UDim2.new(0.8, 0, 0, 45)
KInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KInput.BackgroundColor3 = C.Dark
KInput.PlaceholderText = "Enter Key..."
KInput.Text = ""
KInput.TextColor3 = C.Text
KInput.Font = Enum.Font.GothamBold
KInput.TextSize = 14
Instance.new("UICorner", KInput).CornerRadius = UDim.new(0, 8)

local KBtn = Instance.new("TextButton", KeyFrame)
KBtn.Size = UDim2.new(0.38, 0, 0, 40)
KBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
KBtn.BackgroundColor3 = C.Accent
KBtn.Text = "VERIFY"
KBtn.TextColor3 = Color3.new(1,1,1)
KBtn.Font = Enum.Font.GothamBlack
Instance.new("UICorner", KBtn).CornerRadius = UDim.new(0, 8)

local KLink = Instance.new("TextButton", KeyFrame)
KLink.Size = UDim2.new(0.38, 0, 0, 40)
KLink.Position = UDim2.new(0.52, 0, 0.65, 0)
KLink.BackgroundColor3 = C.Dark
KLink.Text = "GET KEY"
KLink.TextColor3 = C.Text
KLink.Font = Enum.Font.GothamBold
Instance.new("UICorner", KLink).CornerRadius = UDim.new(0, 8)

-- =================================================================
-- 🖥️ MAIN HUB UI
-- =================================================================

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0, 550, 0, 350)
Main.Position = UDim2.new(0.5, -275, 0.3, 0)
Main.BackgroundColor3 = C.Bg
Main.Visible = CheckWhitelist() -- Show immediately if whitelisted
MakeDraggable(Main)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local MStr = Instance.new("UIStroke", Main); MStr.Color = C.Accent; MStr.Thickness = 1.5

-- Sidebar
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0.3, 0, 1, 0)
Sidebar.BackgroundColor3 = C.Dark
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

local Logo = Instance.new("TextLabel", Sidebar)
Logo.Text = "SANITY"
Logo.Font = Enum.Font.GothamBlack
Logo.TextSize = 24
Logo.TextColor3 = C.Accent
Logo.Size = UDim2.new(1, 0, 0, 50)
Logo.BackgroundTransparency = 1

local Ver = Instance.new("TextLabel", Sidebar)
Ver.Text = "SABB EDITION"
Ver.Font = Enum.Font.Gotham
Ver.TextSize = 10
Ver.TextColor3 = C.Text
Ver.Size = UDim2.new(1, 0, 0, 20)
Ver.Position = UDim2.new(0, 0, 0.12, 0)
Ver.BackgroundTransparency = 1

local TabBox = Instance.new("ScrollingFrame", Sidebar)
TabBox.Size = UDim2.new(1, 0, 0.8, 0)
TabBox.Position = UDim2.new(0, 0, 0.2, 0)
TabBox.BackgroundTransparency = 1
local TabList = Instance.new("UIListLayout", TabBox)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabList.Padding = UDim.new(0, 8)

local PageBox = Instance.new("Frame", Main)
PageBox.Size = UDim2.new(0.68, 0, 0.9, 0)
PageBox.Position = UDim2.new(0.31, 0, 0.05, 0)
PageBox.BackgroundTransparency = 1

-- =================================================================
-- ⚡ FUNCTIONS
-- =================================================================

local function CreateTab(name)
    local Btn = Instance.new("TextButton", TabBox)
    Btn.Size = UDim2.new(0.9, 0, 0, 40)
    Btn.BackgroundColor3 = C.Bg
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 12
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    local Page = Instance.new("ScrollingFrame", PageBox)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    local PL = Instance.new("UIListLayout", Page)
    PL.HorizontalAlignment = Enum.HorizontalAlignment.Center
    PL.Padding = UDim.new(0, 8)
    
    Btn.MouseButton1Click:Connect(function()
        for _,v in pairs(TabBox:GetChildren()) do 
            if v:IsA("TextButton") then 
                TweenService:Create(v, TweenInfo.new(0.2), {BackgroundColor3 = C.Bg, TextColor3 = Color3.fromRGB(150,150,150)}):Play()
            end 
        end
        for _,p in pairs(PageBox:GetChildren()) do p.Visible = false end
        Page.Visible = true
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = C.Accent, TextColor3 = Color3.new(1,1,1)}):Play()
    end)
    return Page
end

local function AddBtn(parent, text, cb)
    local B = Instance.new("TextButton", parent)
    B.Size = UDim2.new(0.95, 0, 0, 40)
    B.BackgroundColor3 = C.Dark
    B.Text = text
    B.TextColor3 = C.Text
    B.Font = Enum.Font.GothamSemibold
    B.TextSize = 13
    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 6)
    B.MouseButton1Click:Connect(function()
        TweenService:Create(B, TweenInfo.new(0.1), {BackgroundColor3 = C.Accent}):Play()
        task.wait(0.1)
        TweenService:Create(B, TweenInfo.new(0.2), {BackgroundColor3 = C.Dark}):Play()
        cb()
    end)
end

local function AddToggle(parent, text, cb)
    local B = Instance.new("TextButton", parent)
    B.Size = UDim2.new(0.95, 0, 0, 40)
    B.BackgroundColor3 = C.Dark
    B.Text = "   "..text
    B.TextColor3 = C.Text
    B.Font = Enum.Font.GothamSemibold
    B.TextSize = 13
    B.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 6)
    
    local S = Instance.new("Frame", B)
    S.Size = UDim2.new(0, 10, 0, 10)
    S.Position = UDim2.new(0.9, 0, 0.4, 0)
    S.BackgroundColor3 = C.Red
    Instance.new("UICorner", S).CornerRadius = UDim.new(1, 0)
    
    local on = false
    B.MouseButton1Click:Connect(function()
        on = not on
        if on then
            TweenService:Create(S, TweenInfo.new(0.2), {BackgroundColor3 = C.Green}):Play()
        else
            TweenService:Create(S, TweenInfo.new(0.2), {BackgroundColor3 = C.Red}):Play()
        end
        cb(on)
    end)
end

-- =================================================================
-- 🧠 GAME FEATURES
-- =================================================================

local MainT = CreateTab("MAIN")
local PlayerT = CreateTab("PLAYER")
local VisT = CreateTab("VISUALS")

-- [[ MAIN TAB: STEAL FEATURES ]]

AddToggle(MainT, "Instant Steal (0 Hold)", function(s)
    getgenv().InstantSteal = s
    task.spawn(function()
        while getgenv().InstantSteal do
            task.wait(0.5)
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then
                    v.HoldDuration = 0
                end
            end
        end
    end)
end)

AddToggle(MainT, "Fast Steal (0.1 Hold)", function(s)
    getgenv().FastSteal = s
    task.spawn(function()
        while getgenv().FastSteal do
            task.wait(0.5)
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then
                    v.HoldDuration = 0.1
                end
            end
        end
    end)
end)

AddToggle(MainT, "Desync (Hitbox Breaker)", function(s)
    getgenv().Desync = s
    task.spawn(function()
        while getgenv().Desync do
            task.wait()
            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                -- Standard Velocity Desync
                local old = lp.Character.HumanoidRootPart.Velocity
                lp.Character.HumanoidRootPart.Velocity = Vector3.new(0, -200, 0)
                RunService.RenderStepped:Wait()
                lp.Character.HumanoidRootPart.Velocity = old
            end
        end
    end)
end)

-- [[ PLAYER TAB: MOVEMENT ]]

AddToggle(PlayerT, "Speed Boost (WalkSpeed)", function(s)
    getgenv().Speed = s
    task.spawn(function()
        while getgenv().Speed do
            task.wait()
            if lp.Character then lp.Character.Humanoid.WalkSpeed = 50 end
        end
        if lp.Character then lp.Character.Humanoid.WalkSpeed = 16 end
    end)
end)

AddToggle(PlayerT, "Jump Boost", function(s)
    getgenv().Jump = s
    task.spawn(function()
        while getgenv().Jump do
            task.wait()
            if lp.Character then lp.Character.Humanoid.JumpPower = 100 end
        end
        if lp.Character then lp.Character.Humanoid.JumpPower = 50 end
    end)
end)

AddBtn(PlayerT, "Invis (Client Reset)", function()
    -- Simple Invis trick
    if lp.Character and lp.Character:FindFirstChild("LowerTorso") then
        lp.Character.LowerTorso:Destroy() -- Breaks visual rig usually
    end
end)

-- [[ LOGIC: KEY SYSTEM ]]

KBtn.MouseButton1Click:Connect(function()
    if KInput.Text == CONFIG.Key then
        KeyFrame.Visible = false
        Main.Visible = true
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "SANITY HUB",
            Text = "Access Granted.",
            Duration = 5
        })
    else
        KInput.Text = "INVALID KEY"
        task.wait(1)
        KInput.Text = ""
    end
end)

KLink.MouseButton1Click:Connect(function()
    setclipboard(CONFIG.Discord)
    KLink.Text = "COPIED!"
    task.wait(1)
    KLink.Text = "GET KEY"
end)

print("🧠 SANITY HUB: SABB EDITION LOADED")
