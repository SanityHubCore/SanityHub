-- [[ 🧠 SANITY HUB: SABB EDITION V2 ]]
-- STATUS: UNDETECTED | DESYNC FIXED | W UI
-- OWNER: C4VIT & YOU

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")

local lp = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- =================================================================
-- 🔐 SECURITY & CONFIG
-- =================================================================

local CONFIG = {
    Key = "ONION",
    Discord = "https://discord.gg/HWUb2PxeSu",
    Whitelist = {
        12345678, -- YOUR ID
        87654321, -- C4VIT ID
    }
}

local function CheckWhitelist()
    for _, id in pairs(CONFIG.Whitelist) do
        if lp.UserId == id then return true end
    end
    return false
end

-- =================================================================
-- 🎨 SANITY UI ENGINE (DARK ETHER THEME)
-- =================================================================

-- SAFE LOAD
local Parent = CoreGui:FindFirstChild("RobloxGui") or CoreGui
if Parent:FindFirstChild("SanityV2") then Parent.SanityV2:Destroy() end

local Gui = Instance.new("ScreenGui")
Gui.Name = "SanityV2"
Gui.Parent = Parent
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.ResetOnSpawn = false

-- ASSETS
local ICONS = {
    Logo = "rbxassetid://13462699342", -- Stylish S / Abstract Logo
    Home = "rbxassetid://3926305904",
    Player = "rbxassetid://3926307971",
    Visual = "rbxassetid://3926305904",
    Settings = "rbxassetid://3926307971"
}

-- COLORS
local C = {
    Bg = Color3.fromRGB(12, 12, 16),
    Dark = Color3.fromRGB(8, 8, 10),
    Sidebar = Color3.fromRGB(18, 18, 24),
    Accent = Color3.fromRGB(140, 100, 255), -- Sanity Purple
    Glow = Color3.fromRGB(160, 120, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(160, 160, 160)
}

-- DRAG FUNCTION
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

-- 1. MINIMIZED ICON (STYLISH S)
local IconFrame = Instance.new("ImageButton", Gui)
IconFrame.Name = "MinimizedIcon"
IconFrame.Size = UDim2.new(0, 60, 0, 60)
IconFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
IconFrame.BackgroundColor3 = C.Dark
IconFrame.Image = "" -- Background for circle
IconFrame.AutoButtonColor = false
IconFrame.Visible = false -- Hidden by default (until minimized)
EnableDrag(IconFrame)

-- Circle Shape
Instance.new("UICorner", IconFrame).CornerRadius = UDim.new(1, 0)
local IconStroke = Instance.new("UIStroke", IconFrame)
IconStroke.Color = C.Accent; IconStroke.Thickness = 2

-- The "S" Logo inside
local S_Logo = Instance.new("ImageLabel", IconFrame)
S_Logo.Size = UDim2.new(0.6, 0, 0.6, 0)
S_Logo.Position = UDim2.new(0.2, 0, 0.2, 0)
S_Logo.BackgroundTransparency = 1
S_Logo.Image = ICONS.Logo
S_Logo.ImageColor3 = C.Accent

-- Icon Glow Animation
task.spawn(function()
    while true do
        TweenService:Create(IconStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Color = C.Glow, Thickness = 4}):Play()
        task.wait(3)
    end
end)

-- 2. MAIN WINDOW
local Main = Instance.new("Frame", Gui)
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 650, 0, 400)
Main.Position = UDim2.new(0.5, -325, 0.3, 0)
Main.BackgroundColor3 = C.Bg
Main.ClipsDescendants = true
Main.Visible = CheckWhitelist() -- Open if WL, else wait for key
EnableDrag(Main)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Border
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = C.Accent
MainStroke.Thickness = 1.5

-- 3. SIDEBAR
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0.25, 0, 1, 0)
Sidebar.BackgroundColor3 = C.Sidebar
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

-- Title
local Title = Instance.new("TextLabel", Sidebar)
Title.Text = "SANITY"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 24
Title.TextColor3 = C.Accent
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0.03, 0)
Title.BackgroundTransparency = 1

local SubTitle = Instance.new("TextLabel", Sidebar)
SubTitle.Text = "SABB V2"
SubTitle.Font = Enum.Font.GothamBold
SubTitle.TextSize = 10
SubTitle.TextColor3 = C.TextDim
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0.1, 0)
SubTitle.BackgroundTransparency = 1

-- Tabs Container
local TabContainer = Instance.new("ScrollingFrame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 0.75, 0)
TabContainer.Position = UDim2.new(0, 0, 0.2, 0)
TabContainer.BackgroundTransparency = 1
TabContainer.ScrollBarThickness = 0
local TabList = Instance.new("UIListLayout", TabContainer)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabList.Padding = UDim.new(0, 8)

-- 4. CONTENT AREA
local PageContainer = Instance.new("Frame", Main)
PageContainer.Size = UDim2.new(0.72, 0, 0.9, 0)
PageContainer.Position = UDim2.new(0.27, 0, 0.1, 0)
PageContainer.BackgroundTransparency = 1

-- 5. TOP BAR (Controls)
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(0.75, 0, 0.1, 0)
TopBar.Position = UDim2.new(0.25, 0, 0, 0)
TopBar.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0.2, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Font = Enum.Font.GothamBlack
CloseBtn.TextSize = 24

local MiniBtn = Instance.new("TextButton", TopBar)
MiniBtn.Size = UDim2.new(0, 30, 0, 30)
MiniBtn.Position = UDim2.new(1, -70, 0.2, 0)
MiniBtn.BackgroundTransparency = 1
MiniBtn.Text = "−"
MiniBtn.TextColor3 = C.Text
MiniBtn.Font = Enum.Font.GothamBlack
MiniBtn.TextSize = 24

-- =================================================================
-- ⚡ UI FUNCTIONS
-- =================================================================

local Tabs = {}

local function CreateTab(name)
    local Btn = Instance.new("TextButton", TabContainer)
    Btn.Size = UDim2.new(0.85, 0, 0, 40)
    Btn.BackgroundColor3 = C.Bg
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
            TweenService:Create(t.Btn, TweenInfo.new(0.2), {BackgroundColor3 = C.Bg, TextColor3 = C.TextDim}):Play()
        end
        Page.Visible = true
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = C.Accent, TextColor3 = Color3.new(1,1,1)}):Play()
    end)
    
    table.insert(Tabs, {Btn = Btn, Page = Page})
    return Page
end

local function AddToggle(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(0.98, 0, 0, 45)
    Btn.BackgroundColor3 = C.Sidebar
    Btn.Text = "      "..text
    Btn.TextColor3 = C.Text
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 13
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    
    local Toggle = Instance.new("Frame", Btn)
    Toggle.Size = UDim2.new(0, 36, 0, 18)
    Toggle.Position = UDim2.new(0.88, 0, 0.3, 0)
    Toggle.BackgroundColor3 = C.Dark
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
            TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = C.Accent}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0.1, 0), BackgroundColor3 = Color3.new(1,1,1)}):Play()
        else
            TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = C.Dark}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.1, 0), BackgroundColor3 = C.TextDim}):Play()
        end
        callback(on)
    end)
end

local function AddButton(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(0.98, 0, 0, 45)
    Btn.BackgroundColor3 = C.Sidebar
    Btn.Text = text
    Btn.TextColor3 = C.Text
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 13
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    
    Btn.MouseButton1Click:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = C.Accent}):Play()
        task.wait(0.1)
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = C.Sidebar}):Play()
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
KeyFrame.Visible = not CheckWhitelist()
EnableDrag(KeyFrame)
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 10)
local KStr = Instance.new("UIStroke", KeyFrame); KStr.Color = C.Accent; KStr.Thickness = 2

local KTitle = Instance.new("TextLabel", KeyFrame)
KTitle.Text = "SANITY HUB"
KTitle.Font = Enum.Font.GothamBlack
KTitle.TextSize = 22
KTitle.TextColor3 = C.Accent
KTitle.Size = UDim2.new(1, 0, 0, 50)
KTitle.BackgroundTransparency = 1

local KInput = Instance.new("TextBox", KeyFrame)
KInput.Size = UDim2.new(0.8, 0, 0, 45)
KInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KInput.BackgroundColor3 = C.Dark
KInput.PlaceholderText = "Enter Key"
KInput.Text = ""
KInput.TextColor3 = C.Text
KInput.Font = Enum.Font.GothamBold
Instance.new("UICorner", KInput).CornerRadius = UDim.new(0, 8)

local KBtn = Instance.new("TextButton", KeyFrame)
KBtn.Size = UDim2.new(0.8, 0, 0, 45)
KBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
KBtn.BackgroundColor3 = C.Accent
KBtn.Text = "ACCESS"
KBtn.TextColor3 = Color3.new(1,1,1)
KBtn.Font = Enum.Font.GothamBlack
Instance.new("UICorner", KBtn).CornerRadius = UDim.new(0, 8)

KBtn.MouseButton1Click:Connect(function()
    if KInput.Text == CONFIG.Key then
        KeyFrame.Visible = false
        Main.Visible = true
    else
        KInput.Text = "INVALID"
        task.wait(1)
        KInput.Text = ""
    end
end)

-- =================================================================
-- 🧠 FEATURES (SABB EDITION)
-- =================================================================

local MainT = CreateTab("STEAL")
local PlayerT = CreateTab("PLAYER")
local MiscT = CreateTab("MISC")
local SetT = CreateTab("SETTINGS")

-- [[ MAIN: STEAL & DESYNC ]]

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

-- DESYNC V2 (The Fix)
AddToggle(MainT, "God-Mode Desync (Fix)", function(s)
    getgenv().Desync = s
    if s then
        task.spawn(function()
            while getgenv().Desync do
                task.wait()
                pcall(function()
                    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                        -- Set huge velocity on one axis to break hitbox server-side
                        -- This creates a 'ghost' effect where you aren't where you look
                        lp.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 20000)
                        RunService.Heartbeat:Wait()
                        -- Reset slightly to prevent falling through map (Physics quirk)
                        lp.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    end
                end)
            end
        end)
    end
end)

AddToggle(MainT, "Fast Steal (0.1 Hold)", function(s)
    getgenv().FastSteal = s
    task.spawn(function()
        while getgenv().FastSteal do
            task.wait(0.2)
            for _,v in pairs(Workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then v.HoldDuration = 0.1 end
            end
        end
    end)
end)

-- [[ PLAYER ]]

AddToggle(PlayerT, "Speed Boost", function(s)
    getgenv().Speed = s
    task.spawn(function()
        while getgenv().Speed do
            task.wait()
            if lp.Character then lp.Character.Humanoid.WalkSpeed = 60 end
        end
        if lp.Character then lp.Character.Humanoid.WalkSpeed = 16 end
    end)
end)

AddToggle(PlayerT, "Jump Boost", function(s)
    getgenv().Jump = s
    task.spawn(function()
        while getgenv().Jump do
            task.wait()
            if lp.Character then lp.Character.Humanoid.JumpPower = 120 end
        end
        if lp.Character then lp.Character.Humanoid.JumpPower = 50 end
    end)
end)

AddButton(PlayerT, "Invis (Client Reset)", function()
    if lp.Character and lp.Character:FindFirstChild("LowerTorso") then
        lp.Character.LowerTorso:Destroy()
    end
end)

-- [[ MISC: COMMON ]]

AddToggle(MiscT, "Anti-AFK", function(s)
    getgenv().AntiAFK = s
    if s then
        lp.Idled:Connect(function()
            if getgenv().AntiAFK then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end
        end)
    end
end)

AddButton(MiscT, "Extreme FPS Boost", function()
    -- Aggressive cleanup
    for _,v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Part") or v:IsA("UnionOperation") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.CastShadow = false
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
end)

-- [[ SETTINGS: UI ]]

AddButton(SetT, "Unload Script", function()
    Gui:Destroy()
    getgenv().Desync = false
    getgenv().Speed = false
    getgenv().Jump = false
end)

-- LOGIC FOR MINIMIZE/CLOSE
CloseBtn.MouseButton1Click:Connect(function()
    Gui:Destroy() -- Fully close
end)

MiniBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    IconFrame.Visible = true -- Show S Logo
end)

IconFrame.MouseButton1Click:Connect(function()
    IconFrame.Visible = false
    Main.Visible = true -- Restore Main
end)

-- Init
Tabs[1].Page.Visible = true
Tabs[1].Btn.BackgroundColor3 = C.Accent
Tabs[1].Btn.TextColor3 = Color3.new(1,1,1)

print("🧠 SANITY HUB: SABB EDITION V2 LOADED")
