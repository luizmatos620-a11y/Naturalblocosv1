-- LUIZ MENU V1 - OVERPOWER EDITION
-- Foco: Dano Real, Kill Aura Fatal e Escudo de Impacto
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- Função para dominar a física das peças (O SEGREDO DO PODER)
local function claimOwnership(part)
    if part:IsA("BasePart") and not part.Anchored then
        part.Velocity = Vector3.new(0, 0.01, 0) -- Pequeno impulso para o servidor te dar o controle
    end
end

local function getHRP() return lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") end

-- Interface Estilo Glitch (Hacker)
local sg = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 500, 0, 550)
main.Position = UDim2.new(0.5, -250, 0.5, -275)
main.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
main.BorderColor3 = Color3.fromRGB(255, 0, 0)
main.BorderSizePixel = 5
Instance.new("UICorner", main)

local container = Instance.new("ScrollingFrame", main)
container.Size = UDim2.new(1, -20, 1, -80)
container.Position = UDim2.new(0, 10, 0, 60)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 3, 0)
Instance.new("UIListLayout", container).Padding = UDim.new(0, 10)

local function addOption(txt, cb)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, -10, 0, 50)
    b.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
    b.Text = "!! " .. txt .. " !!"
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Code
    b.TextSize = 20
    b.MouseButton1Click:Connect(cb)
end

-- --- 1. KILL AURA FATAL (FLING AUTOMÁTICO) ---
_G.KillAura = false
addOption("KILL AURA (INSTANT KILL)", function()
    _G.KillAura = not _G.KillAura
    task.spawn(function()
        while _G.KillAura do
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (getHRP().Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 40 then
                        -- O segredo: Teleporta por um milésimo de segundo e gira o alvo
                        local enemyHRP = p.Character.HumanoidRootPart
                        local oldVel = enemyHRP.Velocity
                        enemyHRP.Velocity = Vector3.new(999999, 999999, 999999) -- EXPLODE O PLAYER
                    end
                end
            end
            task.wait(0.05)
        end
    end)
end)

-- --- 2. ESCUDO DE IMPACTO REAL (MAGNETO SUPREMO) ---
_G.MegaShield = false
addOption("ESCUDO DE IMPACTO REAL", function()
    _G.MegaShield = not _G.MegaShield
    local angle = 0
    task.spawn(function()
        while _G.MegaShield do
            angle = angle + 1.5 -- Velocidade de rotação insana
            local hrp = getHRP()
            if hrp then
                local count = 0
                for _, p in pairs(workspace:GetDescendants()) do
                    if p:IsA("BasePart") and not p.Anchored and not p:IsDescendantOf(lp.Character) then
                        if count > 40 then break end
                        claimOwnership(p) -- Força o servidor a deixar-te controlar a peça
                        
                        local targetPos = hrp.Position + Vector3.new(math.cos(angle + count)*20, 5, math.sin(angle + count)*20)
                        
                        -- Física Brutal: Move a peça com velocidade infinita para o alvo
                        p.CFrame = CFrame.new(targetPos)
                        p.Velocity = (targetPos - p.Position) * 300 -- IMPACTO DE BALA
                        p.CanCollide = true -- Agora ela bate e mata
                        count = count + 1
                    end
                end
            end
            RunService.Heartbeat:Wait()
        end
    end)
end)

-- --- 3. FLY ADMIN V3 (SEM DANO E RÁPIDO) ---
local flying = false
addOption("FLY ADMIN (W = DESTINO)", function()
    flying = not flying
    local hrp = getHRP()
    if flying then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        local bg = Instance.new("BodyGyro", hrp)
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        
        task.spawn(function()
            while flying do
                local dt = RunService.RenderStepped:Wait()
                local moveDir = lp.Character.Humanoid.MoveDirection
                if moveDir.Magnitude > 0 then
                    bv.Velocity = Camera.CFrame.LookVector * 100 -- Velocidade aumentada
                else
                    bv.Velocity = Vector3.new(0, 0, 0)
                end
                bg.CFrame = Camera.CFrame
                lp.Character.Humanoid.Health = 100 -- God Mode constante
            end
            bv:Destroy() bg:Destroy()
        end)
    end
end)

-- --- 4. TORNADO DE PLAYER (FLING ALL) ---
addOption("FLING ALL (LIMPAR SERVIDOR)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            task.spawn(function()
                local t = 0
                while t < 20 do -- Persegue o player por um tempo
                    t = t + 1
                    getHRP().CFrame = p.Character.HumanoidRootPart.CFrame
                    getHRP().Velocity = Vector3.new(99999, 99999, 99999)
                    RunService.Heartbeat:Wait()
                end
            end)
        end
    end
end)

-- Botão de abrir/fechar (Ícone Hacker)
local icon = Instance.new("ImageButton", sg)
icon.Size = UDim2.new(0, 80, 0, 80)
icon.Position = UDim2.new(0, 10, 0.5, -40)
icon.Image = "rbxassetid://11293318182"
icon.BackgroundColor3 = Color3.fromRGB(100,0,0)
Instance.new("UICorner", icon).CornerRadius = UDim.new(1,0)
icon.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
