-- [[ 🧠 SANITY HUB: SABB EDITION V4 (FIXED) ]]
-- STATUS: UNDETECTED | CO-OWNER WHITELISTED
-- UI: SLEEK GLASSMORPHISM & ANIMATED
-- UPDATES: DUELS TAB, FIXED SPEED/JUMP, FIXED EXECUTION ERROR

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")

local lp = Players.LocalPlayer

-- =================================================================
-- 🔐 SECURITY & CONFIG
-- =================================================================

local CONFIG = {
    Key = "SANITY-ONTOP",
    Discord = "https://discord.gg/sanityhub",
    Whitelist = {
        12345678,     -- Replace with your User ID
        8176354072,   -- Co-Owner (C4VIT)
    }
}

local function CheckWhitelist()
    for _, id in pairs(CONFIG.Whitelist) do
        if lp.UserId == id then return true end
    end
    return false
end

-- =================================================================
-- 🎨 SANITY UI ENGINE (SLEEK GLASS)
-- =================================================================

-- Universal Executor Support (Falls back to PlayerGui if CoreGui is blocked)
local Parent = CoreGui:FindFirstChild("RobloxGui") or CoreGui
if not pcall(function() local x = Instance.new("ScreenGui", Parent) x:Destroy() end) then
    Parent = lp:WaitForChild("PlayerGui")
end

if Parent:FindFirstChild("SanityV4") then Parent.SanityV4:Destroy() end

local Gui = Instance.new("ScreenGui")
Gui.Name = "SanityV4"
Gui.Parent = Parent
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.ResetOnSpawn = false

-- PREMIUM COLORS
local C = {
    Bg = Color3.fromRGB(5, 5, 8),
    Sidebar = Color3.fromRGB(12, 12, 16),
    Accent = Color3.fromRGB(160, 100, 255),
    Glow = Color3.fromRGB(180, 130, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(140, 140, 150),
    Btn = Color3.fromRGB(18, 18, 24)
}

-- SMOOTH DRAG
local function EnableDrag(obj)
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
-- 🖥️ UI CONSTRUCTION
-- =================================================================

-- 1. STYLISH MINIMIZED ICON
local IconFrame = Instance.new("ImageButton", Gui)
IconFrame.Size = UDim2.new(0, 55, 0, 55)
IconFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
IconFrame.BackgroundColor3 = C.Bg
IconFrame.BackgroundTransparency = 0.2
IconFrame.AutoButtonColor = false
IconFrame.Visible = false 
EnableDrag(IconFrame)

Instance.new("UICorner", IconFrame).CornerRadius = UDim.new(1, 0)
local IconStroke = Instance.new("UIStroke", IconFrame)
IconStroke.Color = C.Accent; IconStroke.Thickness = 2.5

local S_Logo = Instance.new("ImageLabel", IconFrame)
S_Logo.Size = UDim2.new(0.6, 0, 0.6, 0)
S_Logo.Position = UDim2.new(0.2, 0, 0.2, 0)
S_Logo.BackgroundTransparency = 1
S_Logo.Image = "rbxassetid://13462699342" 
S_Logo.ImageColor3 = C.Accent

task.spawn(function()
    while true do
        TweenService:Create(IconStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Color = C.Glow, Thickness = 4}):Play()
        task.wait(3)
    end
end)

-- 2. MAIN HUB WINDOW (GLASSMORPHISM)
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0, 650, 0, 400)
Main.Position = UDim2.new(0.5, -325, 0.3, 0)
Main.BackgroundColor3 = C.Bg
Main.BackgroundTransparency = 0.15
Main.ClipsDescendants = true
Main.Visible = CheckWhitelist()
EnableDrag(Main)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 1.5
local StrokeGradient = Instance.new("UIGradient", MainStroke)
StrokeGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, C.Accent),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 50, 150))
}

-- 3. SIDEBAR
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0.25, 0, 1, 0)
Sidebar.BackgroundColor3 = C.Sidebar
Sidebar.BackgroundTransparency = 0.3
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Sidebar)
Title.Text = "SANITY"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 24
Title.TextColor3 = C.Accent
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Position = UDim2.new(0, 0, 0.04, 0)
Title.BackgroundTransparency = 1

local SubTitle = Instance.new("TextLabel", Sidebar)
SubTitle.Text = "SABB V4"
SubTitle.Font = Enum.Font.GothamBold
SubTitle.TextSize = 10
SubTitle.TextColor3 = C.TextDim
SubTitle.Size = UDim2.new(1, 0, 0, 15)
SubTitle.Position = UDim2.new(0, 0, 0.12, 0)
SubTitle.BackgroundTransparency = 1

local TabContainer = Instance.new("ScrollingFrame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 0.75, 0)
TabContainer.Position = UDim2.new(0, 0, 0.22, 0)
TabContainer.BackgroundTransparency = 1
TabContainer.ScrollBarThickness = 0
local TabList = Instance.new("UIListLayout", TabContainer)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabList.Padding = UDim.new(0, 8)

-- 4. CONTENT AREA
local PageContainer = Instance.new("Frame", Main)
PageContainer.Size = UDim2.new(0.72, 0, 0.85, 0)
PageContainer.Position = UDim2.new(0.27, 0, 0.12, 0)
PageContainer.BackgroundTransparency = 1

-- 5. TOP CONTROLS
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(0.75, 0, 0.1, 0)
TopBar.Position = UDim2.new(0.25, 0, 0, 0)
TopBar.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0.2, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Font = Enum.Font.GothamBlack
CloseBtn.TextSize = 26

local MiniBtn = Instance.new("TextButton", TopBar)
MiniBtn.Size = UDim2.new(0, 30, 0, 30)
MiniBtn.Position = UDim2.new(1, -80, 0.2, 0)
MiniBtn.BackgroundTransparency = 1
MiniBtn.Text = "−"
MiniBtn.TextColor3 = C.Text
MiniBtn.Font = Enum.Font.GothamBlack
MiniBtn.TextSize = 26

-- =================================================================
-- ⚡ UI FUNCTIONS & ANIMATIONS
-- =================================================================

local Tabs = {}

local function CreateTab(name)
    local Btn = Instance.new("TextButton", TabContainer)
    Btn.Size = UDim2.new(0.85, 0, 0, 38)
    Btn.BackgroundColor3 = C.Btn
    Btn.BackgroundTransparency = 0.5
    Btn.Text = name
    Btn.TextColor3 = C.TextDim
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 12
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    
    local Page = Instance.new("ScrollingFrame", PageContainer)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    local PL = Instance.new("UIListLayout", Page)
    PL.HorizontalAlignment = Enum.HorizontalAlignment.Center
    PL.Padding = UDim.new(0, 8)
    
    Btn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Page.Visible = false
            TweenService:Create(t.Btn, TweenInfo.new(0.3), {BackgroundColor3 = C.Btn, TextColor3 = C.TextDim, BackgroundTransparency = 0.5}):Play()
        end
        Page.Visible = true
        TweenService:Create(Btn, TweenInfo.new(0.3), {BackgroundColor3 = C.Accent, TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 0}):Play()
    end)
    
    table.insert(Tabs, {Btn = Btn, Page = Page})
    return Page
end

local function AddToggle(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(0.98, 0, 0, 45)
    Btn.BackgroundColor3 = C.Btn
    Btn.BackgroundTransparency = 0.3
    Btn.Text = "      "..text
    Btn.TextColor3 = C.Text
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 13
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", Btn).Color = Color3.fromRGB(40, 40, 50)
    
    local Toggle = Instance.new("Frame", Btn)
    Toggle.Size = UDim2.new(0, 36, 0, 18)
    Toggle.Position = UDim2.new(0.88, 0, 0.3, 0)
    Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
    
    local Circle = Instance.new("Frame", Toggle)
    Circle.Size = UDim2.new(0, 14, 0, 14)
    Circle.Position = UDim2.new(0, 2, 0.1, 0)
    Circle.BackgroundColor3 = C.TextDim
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
    
    local on = false
    Btn.MouseButton1Click:Connect(function()
        on = not on
        if on then
            TweenService:Create(Toggle, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = C.Accent}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Position = UDim2.new(1, -16, 0.1, 0), BackgroundColor3 = Color3.new(1,1,1)}):Play()
        else
            TweenService:Create(Toggle, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(30, 30, 35)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 2, 0.1, 0), BackgroundColor3 = C.TextDim}):Play()
        end
        callback(on)
    end)
end

local function AddButton(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(0.98, 0, 0, 45)
    Btn.BackgroundColor3 = C.Btn
    Btn.BackgroundTransparency = 0.3
    Btn.Text = text
    Btn.TextColor3 = C.Text
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 13
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", Btn).Color = Color3.fromRGB(40, 40, 50)
    
    Btn.MouseButton1Click:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = C.Accent, Size = UDim2.new(0.95, 0, 0, 42)}):Play()
        task.wait(0.1)
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = C.Btn, Size = UDim2.new(0.98, 0, 0, 45)}):Play()
        callback()
    end)
end

-- =================================================================
-- 🔐 KEY SYSTEM UI
-- =================================================================
local KeyFrame = Instance.new("Frame", Gui)
KeyFrame.Size = UDim2.new(0, 450, 0, 280)
KeyFrame.Position = UDim2.new(0.5, -225, 0.4, 0)
KeyFrame.BackgroundColor3 = C.Bg
KeyFrame.BackgroundTransparency = 0.1
KeyFrame.Visible = not CheckWhitelist()
EnableDrag(KeyFrame)
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)
local KStr = Instance.new("UIStroke", KeyFrame); KStr.Color = C.Accent; KStr.Thickness = 2

local KTitle = Instance.new("TextLabel", KeyFrame)
KTitle.Text = "SANITY SECURITY"
KTitle.Font = Enum.Font.GothamBlack
KTitle.TextSize = 22
KTitle.TextColor3 = C.Accent
KTitle.Size = UDim2.new(1, 0, 0, 50)
KTitle.BackgroundTransparency = 1

local KInput = Instance.new("TextBox", KeyFrame)
KInput.Size = UDim2.new(0.8, 0, 0, 45)
KInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KInput.BackgroundColor3 = C.Btn
KInput.PlaceholderText = "Enter Access Key"
KInput.Text = ""
KInput.TextColor3 = C.Text
KInput.Font = Enum.Font.GothamBold
Instance.new("UICorner", KInput).CornerRadius = UDim.new(0, 8)

local KBtn = Instance.new("TextButton", KeyFrame)
KBtn.Size = UDim2.new(0.8, 0, 0, 45)
KBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
KBtn.BackgroundColor3 = C.Accent
KBtn.Text = "AUTHENTICATE"
KBtn.TextColor3 = Color3.new(1,1,1)
KBtn.Font = Enum.Font.GothamBlack
Instance.new("UICorner", KBtn).CornerRadius = UDim.new(0, 8)

KBtn.MouseButton1Click:Connect(function()
    if KInput.Text == CONFIG.Key then
        TweenService:Create(KeyFrame, TweenInfo.new(0.3), {Size = UDim2.new(0,0,0,0), BackgroundTransparency = 1}):Play()
        task.wait(0.3)
        KeyFrame.Visible = false
        Main.Size = UDim2.new(0, 600, 0, 350)
        Main.Visible = true
        TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 650, 0, 400)}):Play()
    else
        KInput.Text = "ACCESS DENIED"
        task.wait(1)
        KInput.Text = ""
    end
end)

-- =================================================================
-- 🧠 SABB FEATURES
-- =================================================================

local MainT = CreateTab("STEAL")
local DuelsT = CreateTab("DUELS")
local PlayerT = CreateTab("PLAYER")
local MiscT = CreateTab("MISC")

-- [[ MAIN: STEAL & LOGIC ]]
AddToggle(MainT, "Instant Steal (0 Hold)", function(s)
    getgenv().InstantSteal = s
    task.spawn(function()
        while getgenv().InstantSteal do
            task.wait(0.1)
            pcall(function()
                for _,v in pairs(Workspace:GetDescendants()) do
                    if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
                end
            end)
        end
    end)
end)

AddToggle(MainT, "Fast Steal (0.1 Hold)", function(s)
    getgenv().FastSteal = s
    task.spawn(function()
        while getgenv().FastSteal do
            task.wait(0.2)
            pcall(function()
                for _,v in pairs(Workspace:GetDescendants()) do
                    if v:IsA("ProximityPrompt") then v.HoldDuration = 0.1 end
                end
            end)
        end
    end)
end)

AddToggle(MainT, "Auto Lock Base", function(s)
    getgenv().AutoLock = s
    task.spawn(function()
        while getgenv().AutoLock do
            task.wait(1)
            pcall(function()
                for _, v in pairs(Workspace:GetDescendants()) do
                    if v:IsA("ProximityPrompt") and (v.ActionText:lower():find("lock") or v.ObjectText:lower():find("door")) then
                        fireproximityprompt(v)
                    end
                end
            end)
        end
    end)
end)

AddToggle(MainT, "Auto Duel Winner", function(s)
    getgenv().AutoDuel = s
    task.spawn(function()
        while getgenv().AutoDuel do
            task.wait(0.1)
            pcall(function()
                getgenv().FastSteal = true
                if lp.Character and lp.Character:FindFirstChild("Humanoid") then
                    lp.Character.Humanoid.WalkSpeed = 150
                end
                for _,v in pairs(Workspace:GetDescendants()) do
                    if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
                end
            end)
        end
    end)
end)

AddToggle(MainT, "God-Mode Desync", function(s)
    getgenv().Desync = s
    if s then
        task.spawn(function()
            while getgenv().Desync do
                task.wait()
                pcall(function()
                    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                        lp.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 20000)
                        RunService.Heartbeat:Wait()
                        lp.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    end
                end)
            end
        end)
    end
end)

-- [[ DUELS TAB ]]
AddToggle(DuelsT, "Melee Aim (Lock-On)", function(s)
    getgenv().MeleeAim = s
    task.spawn(function()
        while getgenv().MeleeAim do
            task.wait()
            pcall(function()
                local closest = nil
                local dist = math.huge
                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local d = (v.Character.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).Magnitude
                        if d < dist and d < 30 then 
                            dist = d
                            closest = v
                        end
                    end
                end
                if closest then
                    local hrp = lp.Character.HumanoidRootPart
                    local targetPos = closest.Character.HumanoidRootPart.Position
                    hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(targetPos.X, hrp.Position.Y, targetPos.Z))
                end
            end)
        end
    end)
end)

AddToggle(DuelsT, "Hitbox Expander", function(s)
    getgenv().DuelsHitbox = s
    task.spawn(function()
        while getgenv().DuelsHitbox do
            task.wait(1)
            pcall(function()
                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        v.Character.HumanoidRootPart.Size = Vector3.new(20, 20, 20)
                        v.Character.HumanoidRootPart.Transparency = 0.7
                        v.Character.HumanoidRootPart.CanCollide = false
                    end
                end
            end)
        end
    end)
end)

AddToggle(DuelsT, "Bat Aura (Auto Swing)", function(s)
    getgenv().BatAura = s
    task.spawn(function()
        while getgenv().BatAura do
            task.wait(0.1)
            pcall(function()
                local tool = lp.Character and lp.Character:FindFirstChildOfClass("Tool")
                if tool then
                    for _, v in pairs(Players:GetPlayers()) do
                        if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (v.Character.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).Magnitude
                            if dist < 15 then
                                tool:Activate()
                            end
                        end
                    end
                end
            end)
        end
    end)
end)

AddToggle(DuelsT, "Lagger (Server Physics Lag)", function(s)
    getgenv().Lagger = s
    task.spawn(function()
        while getgenv().Lagger do
            task.wait()
            pcall(function()
                if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                    for i = 1, 10 do
                        lp.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(math.random(-9999,9999), math.random(-9999,9999), math.random(-9999,9999))
                    end
                end
            end)
        end
    end)
end)

-- [[ PLAYER ]]
AddToggle(PlayerT, "Speed Boost (Adjustable 120)", function(s)
    getgenv().Speed = s
    task.spawn(function()
        while getgenv().Speed do
            task.wait()
            if lp.Character and lp.Character:FindFirstChild("Humanoid") then 
                lp.Character.Humanoid.WalkSpeed = 120 
            end
        end
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then 
            lp.Character.Humanoid.WalkSpeed = 16 
        end
    end)
end)

-- [[ FIXED: JUMP BOOST LOGIC FINISHED HERE ]]
AddToggle(PlayerT, "Jump Boost (Fixed 120)", function(s)
    getgenv().Jump = s
    task.spawn(functi
