-- [[ 🧠 SANITY HUB: SABB EDITION (RAYFIELD FINAL) ]]
-- DEVELOPERS: Jinpachi & C4VIT
-- STATUS: UNDETECTED | ANTI-KICK BYPASS | AUTO-RESET LOCK

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local lp = Players.LocalPlayer

-- =================================================================
-- 🛡️ ANTI-CHEAT & ANTI-KICK BYPASS
-- =================================================================
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" or method == "kick" then
        return nil -- Blocks the game from kicking you
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- =================================================================
-- 🔐 WHITELIST & SECURITY CHECK
-- =================================================================

local Whitelist = {
    12345678,     -- Replace with Jinpachi's ID
    8176354072,   -- C4VIT's ID
}

local isWhitelisted = false
for _, id in pairs(Whitelist) do
    if lp.UserId == id then isWhitelisted = true break end
end

-- =================================================================
-- 🎨 RAYFIELD UI INITIALIZATION
-- =================================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🧠 Sanity Hub | SABB",
   LoadingTitle = "Initializing Sanity...",
   LoadingSubtitle = "by Jinpachi & C4VIT",
   ConfigurationSaving = {
      Enabled = false,
   },
   Discord = {
      Enabled = true,
      Invite = "sanityhub", 
      RememberJoins = false 
   },
   KeySystem = not isWhitelisted,
   KeySettings = {
      Title = "Sanity Hub | Security",
      Subtitle = "Key System",
      Note = "Get the key from our Discord server.",
      FileName = "SanityKey",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {"SANITY-ONTOP"} 
   }
})

-- =================================================================
-- 📑 TABS
-- =================================================================

local StealTab = Window:CreateTab("Steal", 4483362458) 
local DuelsTab = Window:CreateTab("Duels", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- =================================================================
-- 🧠 FEATURES: STEAL TAB
-- =================================================================

StealTab:CreateToggle({
   Name = "Instant Steal (0 Hold)",
   CurrentValue = false,
   Flag = "InstantSteal",
   Callback = function(Value)
        getgenv().InstantSteal = Value
        task.spawn(function()
            while getgenv().InstantSteal do task.wait(0.1)
                pcall(function()
                    for _,v in pairs(Workspace:GetDescendants()) do
                        if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
                    end
                end)
            end
        end)
   end,
})

StealTab:CreateToggle({
   Name = "Fast Steal (0.1 Hold)",
   CurrentValue = false,
   Flag = "FastSteal",
   Callback = function(Value)
        getgenv().FastSteal = Value
        task.spawn(function()
            while getgenv().FastSteal do task.wait(0.2)
                pcall(function()
                    for _,v in pairs(Workspace:GetDescendants()) do
                        if v:IsA("ProximityPrompt") then v.HoldDuration = 0.1 end
                    end
                end)
            end
        end)
   end,
})

StealTab:CreateToggle({
   Name = "Auto Lock Base (5s Reset)",
   CurrentValue = false,
   Flag = "AutoLock",
   Callback = function(Value)
        getgenv().AutoLock = Value
        task.spawn(function()
            while getgenv().AutoLock do task.wait(0.5)
                pcall(function()
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v:IsA("ProximityPrompt") and (v.ActionText:lower():find("lock") or v.ObjectText:lower():find("door")) then
                            if v.Parent then
                                for _, txt in pairs(v.Parent:GetDescendants()) do
                                    if txt:IsA("TextLabel") or txt:IsA("TextButton") then
                                        local t = txt.Text:lower()
                                        if t:find("5") and (t:find(":") or t:find("s") or t:find("unlock")) then
                                            if lp.Character then lp.Character:BreakJoints() end
                                        end
                                    end
                                end
                            end
                            fireproximityprompt(v)
                        end
                    end
                end)
            end
        end)
   end,
})

StealTab:CreateToggle({
   Name = "Auto Duel Winner",
   CurrentValue = false,
   Flag = "AutoDuel",
   Callback = function(Value)
        getgenv().AutoDuel = Value
        task.spawn(function()
            while getgenv().AutoDuel do task.wait(0.1)
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
   end,
})

StealTab:CreateToggle({
   Name = "God-Mode Desync",
   CurrentValue = false,
   Flag = "Desync",
   Callback = function(Value)
        getgenv().Desync = Value
        if Value then
            task.spawn(function()
                while getgenv().Desync do task.wait()
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
   end,
})

-- =================================================================
-- ⚔️ FEATURES: DUELS TAB
-- =================================================================

DuelsTab:CreateToggle({
   Name = "Melee Aim (Lock-On)",
   CurrentValue = false,
   Flag = "MeleeAim",
   Callback = function(Value)
        getgenv().MeleeAim = Value
        task.spawn(function()
            while getgenv().MeleeAim do task.wait()
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
   end,
})

DuelsTab:CreateToggle({
   Name = "Hitbox Expander",
   CurrentValue = false,
   Flag = "DuelsHitbox",
   Callback = function(Value)
        getgenv().DuelsHitbox = Value
        task.spawn(function()
            while getgenv().DuelsHitbox do task.wait(1)
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
   end,
})

DuelsTab:CreateToggle({
   Name = "Bat Aura (Auto Swing)",
   CurrentValue = false,
   Flag = "BatAura",
   Callback = function(Value)
        getgenv().BatAura = Value
        task.spawn(function()
            while getgenv().BatAura do task.wait(0.1)
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
   end,
})

DuelsTab:CreateToggle({
   Name = "Lagger (Server Physics Lag)",
   CurrentValue = false,
   Flag = "Lagger",
   Callback = function(Value)
        getgenv().Lagger = Value
        task.spawn(function()
            while getgenv().Lagger do task.wait()
                pcall(function()
                    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                        for i = 1, 10 do
                            lp.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(math.random(-9999,9999), math.random(-9999,9999), math.random(-9999,9999))
                        end
                    end
                end)
            end
        end)
   end,
})

-- =================================================================
-- 🏃 FEATURES: PLAYER TAB
-- =================================================================

PlayerTab:CreateToggle({
   Name = "Speed Boost",
   CurrentValue = false,
   Flag = "SpeedBoost",
   Callback = function(Value)
        getgenv().Speed = Value
        task.spawn(function()
            while getgenv().Speed do task.wait()
                if lp.Character and lp.Character:FindFirstChild("Humanoid") then 
                    lp.Character.Humanoid.WalkSpeed = 120 
                end
            end
            if lp.Character and lp.Character:FindFirstChild("Humanoid") then 
                lp.Character.Humanoid.WalkSpeed = 16 
            end
        end)
   end,
})

PlayerTab:CreateToggle({
   Name = "Jump Boost",
   CurrentValue = false,
   Flag = "JumpBoost",
   Callback = function(Value)
        getgenv().Jump = Value
        task.spawn(function()
            while getgenv().Jump do task.wait()
                if lp.Character and lp.Character:FindFirstChild("Humanoid") then 
                    lp.Character.Humanoid.UseJumpPower = true
                    lp.Character.Humanoid.JumpPower = 120 
                end
            end
            if lp.Character and lp.Character:FindFirstChild("Humanoid") then 
                lp.Character.Humanoid.JumpPower = 50 
            end
        end)
   end,
})

PlayerTab:CreateButton({
   Name = "Invisibility (Client Reset)",
   Callback = function()
        if lp.Character and lp.Character:FindFirstChild("LowerTorso") then
            lp.Character.LowerTorso:Destroy()
        end
   end,
})

-- =================================================================
-- ⚙️ FEATURES: MISC TAB
-- =================================================================

MiscTab:CreateToggle({
   Name = "Anti-AFK",
   CurrentValue = false,
   Flag = "AntiAFK",
   Callback = function(Value)
        getgenv().AntiAFK = Value
        if Value then
            lp.Idled:Connect(function()
                if getgenv().AntiAFK then
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end
            end)
        end
   end,
})

MiscTab:CreateButton({
   Name = "Extreme FPS Boost",
   Callback = function()
        for _,v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Part") or v:IsA("UnionOperation") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
                v.CastShadow = false
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v:Destroy()
            end
        end
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").FogEnd = 9e9
   end,
})

MiscTab:CreateButton({
   Name = "Destroy Sanity Hub",
   Callback = function()
        Rayfield:Destroy()
        getgenv().InstantSteal = false
        getgenv().FastSteal = false
        getgenv().AutoLock = false
        getgenv().AutoDuel = false
        getgenv().Desync = false
        getgenv().MeleeAim = false
        getgenv().DuelsHitbox = false
        getgenv().BatAura = false
        getgenv().Lagger = false
        getgenv().Speed = false
        getgenv().Jump = false
   end,
})

Rayfield:LoadConfiguration()
