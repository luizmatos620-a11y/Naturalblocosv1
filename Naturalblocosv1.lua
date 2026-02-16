local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Prevenção de Kick por AFK
lp.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenu_V1_ULTRA"
sg.ResetOnSpawn = false

-- --- INTERFACE ESTILO "HACKER" ---
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 650, 0, 450) 
main.Position = UDim2.new(0.5, -325, 0.5, -225)
main.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
main.Visible = true
main.BorderSizePixel = 2
main.BorderColor3 = Color3.fromRGB(255, 0, 0)
Instance.new("UICorner", main)

local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.TextSize = 30
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.SourceSansBold

local openIcon = Instance.new("ImageButton", sg)
openIcon.Size = UDim2.new(0, 70, 0, 70)
openIcon.Position = UDim2.new(0, 10, 0.4, 0)
openIcon.Image = "rbxassetid://11293318182" -- Ícone de Caveira
openIcon.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
openIcon.Visible = false
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)

closeBtn.MouseButton1Click:Connect(function() main.Visible = false openIcon.Visible = true end)
openIcon.MouseButton1Click:Connect(function() main.Visible = true openIcon.Visible = false end)

-- Sistema de Abas Organizado
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 150, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
Instance.new("UICorner", sidebar)

local container = Instance.new("ScrollingFrame", main)
container.Size = UDim2.new(1, -160, 1, -20)
container.Position = UDim2.new(0, 160, 0, 10)
container.BackgroundTransparency = 1
container.ScrollBarThickness = 4
local layout = Instance.new("UIListLayout", container)
layout.Padding = UDim.new(0, 10)

local function addOption(txt, cb)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, -15, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 18
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- --- FUNÇÕES DE DESTRUIÇÃO (PODER REAL) ---

-- 1. VÓRTICE SUPREMO (Liquidificador de Mapas)
_G.Vortex = false
addOption("VÓRTICE SUPREMO (SPAWN)", function()
    _G.Vortex = not _G.Vortex
    local spawnPos = Vector3.new(-285, 180, 375)
    local a = 0
    task.spawn(function()
        while _G.Vortex do
            a = a + 0.8
            local c = 0
            for _, p in pairs(workspace:GetDescendants()) do
                if p:IsA("BasePart") and not p.Anchored and not p:IsDescendantOf(lp.Character) then
                    if c > 40 then break end -- Aumentado para 40 peças (Caos Máximo)
                    p.CFrame = CFrame.new(spawnPos + Vector3.new(math.cos(a)*35, 15, math.sin(a)*35))
                    p.Velocity = Vector3.new(0, 100, 0)
                    p.RotVelocity = Vector3.new(100, 100, 100)
                    c = c + 1
                end
            end
            task.wait(0.01)
        end
    end)
end)

-- 2. BRING ALL (Puxar Todos - Físico)
addOption("BRING ALL (PUXAR TODOS)", function()
    local myPos = lp.Character.HumanoidRootPart.CFrame
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            v.Character.HumanoidRootPart.CFrame = myPos
        end
    end
end)

-- 3. FLING GOD (Explodir Players ao encostar)
local fling = false
addOption("FLING GOD (GIRO MORTAL)", function()
    fling = not fling
    local hrp = lp.Character.HumanoidRootPart
    if fling then
        local bV = Instance.new("BodyAngularVelocity", hrp)
        bV.Name = "LuizFling"
        bV.AngularVelocity = Vector3.new(0, 9999999, 0)
        bV.MaxTorque = Vector3.new(0, math.huge, 0)
        task.spawn(function()
            while fling do
                for _, v in pairs(lp.Character:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end
                RunService.Stepped:Wait()
            end
        end)
    else
        if hrp:FindFirstChild("LuizFling") then hrp.LuizFling:Destroy() end
    end
end)

-- 4. KILL AURA (Alcance de 50 studs)
_G.Aura = false
addOption("KILL AURA (AUTO-ATTACK)", function()
    _G.Aura = not _G.Aura
    task.spawn(function()
        while _G.Aura do
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (lp.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 50 then
                        local tool = lp.Character:FindFirstChildOfClass("Tool")
                        if tool then tool:Activate() end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- 5. CHAT SPAMMER (Para dominar)
_G.Spam = false
addOption("CHAT SPAM (LUIZ MENU V1)", function()
    _G.Spam = not _G.Spam
    task.spawn(function()
        while _G.Spam do
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("LUIZ MENU V1 DOMINANDO! 💀", "All")
            task.wait(3) -- Delay para não dar flood kick
        end
    end)
end)

-- 6. TP LOOP ALL (O Atropelamento)
_G.TPLoop = false
addOption("TP LOOP ALL (ANANIQUILAR)", function()
    _G.TPLoop = not _G.TPLoop
    task.spawn(function()
        while _G.TPLoop do
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    lp.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                    task.wait(0.1)
                end
            end
            task.wait()
        end
    end)
end)

-- Sistema de Arrastar (Draggable)
local function drag(f)
    local d, ds, sp
    f.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then d = true ds = i.Position sp = f.Position end end)
    UserInputService.InputChanged:Connect(function(i) if d then
        local delta = i.Position - ds
        f.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y)
    end end)
    UserInputService.InputEnded:Connect(function() d = false end)
end
drag(main) drag(openIcon)
