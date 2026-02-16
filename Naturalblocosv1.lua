-- LUIZ MENU V1 - DEITY EDITION (SUPREMACIA ABSOLUTA)
-- Criado para dominação total do servidor.
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local function getChar() return lp.Character or lp.CharacterAdded:Wait() end
local function getHRP() return getChar():WaitForChild("HumanoidRootPart", 5) end

-- --- INTERFACE DE DEUS (ESTÉTICA NEON/BLACK) ---
local sg = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 520, 0, 600)
main.Position = UDim2.new(0.5, -260, 0.5, -300)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 2
main.BorderColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", main)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 60)
title.Text = "LUIZ MENU V1: DEITY EDITION"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.Code
title.TextSize = 28
title.BackgroundTransparency = 1

local container = Instance.new("ScrollingFrame", main)
container.Size = UDim2.new(1, -20, 1, -80)
container.Position = UDim2.new(0, 10, 0, 70)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 4, 0)
container.ScrollBarThickness = 2
Instance.new("UIListLayout", container).Padding = UDim.new(0, 12)

local function addOption(txt, cb)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, -10, 0, 55)
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    b.Text = ">> " .. txt .. " <<"
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Code
    b.TextSize = 20
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(cb)
end

-- --- PODERES DIVINOS (POTÊNCIA MÁXIMA) ---

-- 1. SINGULARIDADE (BURACO NEGRO)
_G.BlackHole = false
addOption("SINGULARIDADE (PUXAR TUDO)", function()
    _G.BlackHole = not _G.BlackHole
    task.spawn(function()
        while _G.BlackHole do
            local hrp = getHRP()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(lp.Character) then
                    v.Velocity = (hrp.Position - v.Position).Unit * 250 -- Puxa com força brutal
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- 2. MARIONETE (TRAZER E CONGELAR TODOS)
addOption("MARIONETE (FREEZE ALL)", function()
    local myPos = getHRP().CFrame
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local targetHrp = p.Character.HumanoidRootPart
            targetHrp.CFrame = myPos * CFrame.new(0, 0, -10) -- Coloca na sua frente
            targetHrp.Anchored = true -- Congela no ar para você "brincar"
            task.delay(5, function() targetHrp.Anchored = false end) -- Descongela após 5s
        end
    end
end)

-- 3. OBLITERADOR DE FÍSICA (TOQUE DA MORTE)
_G.TouchKill = false
addOption("TOQUE DA MORTE (FLING V4)", function()
    _G.TouchKill = not _G.TouchKill
    RunService.Heartbeat:Connect(function()
        if _G.TouchKill then
            local hrp = getHRP()
            -- Faz você girar em 4 eixos ao mesmo tempo (Invencível)
            hrp.Velocity = Vector3.new(0, 10000, 0)
            hrp.RotVelocity = Vector3.new(10000, 10000, 10000)
            -- Noclip para não bugar
            for _, v in pairs(lp.Character:GetChildren()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- 4. VISÃO DIVINA (ESP FULL)
addOption("VISÃO DIVINA (VER TODOS)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and not p.Character:FindFirstChild("DeityHighlight") then
            local hl = Instance.new("Highlight", p.Character)
            hl.Name = "DeityHighlight"
            hl.FillColor = Color3.fromRGB(255, 0, 0)
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        end
    end
end)

-- 5. FLY ADMIN SUPREMO (COM SPEED BOOST)
local flying = false
addOption("FLY ADMIN (SHIFT = VELOCIDADE LUZ)", function()
    flying = not flying
    local hrp = getHRP()
    local bv = Instance.new("BodyVelocity", hrp)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    local bg = Instance.new("BodyGyro", hrp)
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    
    task.spawn(function()
        while flying do
            RunService.RenderStepped:Wait()
            local speed = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and 300 or 100
            local move = lp.Character.Humanoid.MoveDirection
            bv.Velocity = (move.Magnitude > 0) and (Camera.CFrame.LookVector * speed) or Vector3.new(0, 0.1, 0)
            bg.CFrame = Camera.CFrame
        end
        bv:Destroy() bg:Destroy()
    end)
end)

-- --- ÍCONE FLUTUANTE ---
local icon = Instance.new("ImageButton", sg)
icon.Size = UDim2.new(0, 80, 0, 80)
icon.Position = UDim2.new(0, 20, 0.5, -40)
icon.Image = "rbxassetid://6034289557" -- Ícone de Olho Iluminati
icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
icon.BackgroundTransparency = 0.8
Instance.new("UICorner", icon).CornerRadius = UDim.new(1, 0)
icon.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
