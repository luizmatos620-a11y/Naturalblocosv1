-- LUIZ MENU V1 - WORLD EATER EDITION
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local function getChar() return lp.Character or lp.CharacterAdded:Wait() end
local function getHRP() return getChar():WaitForChild("HumanoidRootPart", 5) end

-- --- INTERFACE SUPREMA (DESIGN RED GLITCH) ---
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "Luiz_WorldEater"

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 550, 0, 550)
main.Position = UDim2.new(0.5, -275, 0.5, -275)
main.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
main.BorderSizePixel = 4
main.BorderColor3 = Color3.fromRGB(255, 0, 0)
Instance.new("UICorner", main)

-- Efeito de Glitch no Título
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 50)
title.Text = "LUIZ MENU V1: WORLD EATER"
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.Font = Enum.Font.Code
title.TextSize = 25
title.BackgroundTransparency = 1

local container = Instance.new("ScrollingFrame", main)
container.Size = UDim2.new(1, -20, 1, -80)
container.Position = UDim2.new(0, 10, 0, 60)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 4, 0)
Instance.new("UIListLayout", container).Padding = UDim.new(0, 10)

local function addOption(txt, cb)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, -10, 0, 50)
    b.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    b.Text = ">> " .. txt .. " <<"
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Code
    b.TextSize = 20
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- --- O ARSENAL PESADO (PARA NÃO SER FRACO) ---

-- 1. KILL AURA RADIATIVA (Mata quem chega perto sem você fazer nada)
_G.KillAura = false
addOption("KILL AURA RADIATIVA (50 STUDS)", function()
    _G.KillAura = not _G.KillAura
    task.spawn(function()
        while _G.KillAura do
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (getHRP().Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 50 then
                        -- Tenta ativar qualquer arma que você tenha na mão automaticamente
                        local tool = lp.Character:FindFirstChildOfClass("Tool")
                        if tool then tool:Activate() end
                        -- Força física de impacto
                        p.Character.HumanoidRootPart.Velocity = Vector3.new(math.random(-100,100), 500, math.random(-100,100))
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- 2. FLY GOD ADMIN (VELOCIDADE SUPREMA)
local flying = false
local speed = 100
addOption("FLY GOD (W=FRENTE / SHIFT=FAST)", function()
    flying = not flying
    local hrp = getHRP()
    local bv = Instance.new("BodyVelocity", hrp)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    local bg = Instance.new("BodyGyro", hrp)
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    
    task.spawn(function()
        while flying do
            RunService.RenderStepped:Wait()
            local curSpeed = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and speed*2 or speed
            local dir = getChar().Humanoid.MoveDirection
            if dir.Magnitude > 0 then
                bv.Velocity = Camera.CFrame.LookVector * (dir.Z < 0 and curSpeed or -curSpeed) + Camera.CFrame.RightVector * (dir.X > 0 and curSpeed or -curSpeed)
            else
                bv.Velocity = Vector3.new(0, 0, 0)
            end
            bg.CFrame = Camera.CFrame
            getChar().Humanoid.PlatformStand = true
        end
        bv:Destroy() bg:Destroy()
        getChar().Humanoid.PlatformStand = false
    end)
end)

-- 3. ESCUDO DESTRUTOR DE SERVIDOR (PUXA TUDO E MATA)
_G.MegaShield = false
addOption("ESCUDO DESTRUTOR (MAGNETO)", function()
    _G.MegaShield = not _G.MegaShield
    local ang = 0
    task.spawn(function()
        while _G.MegaShield do
            ang = ang + 1
            local hrp = getHRP()
            if hrp then
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(lp.Character) then
                        -- Puxa as peças para um redemoinho mortal
                        local tPos = hrp.Position + Vector3.new(math.cos(ang)*25, 10, math.sin(ang)*25)
                        v.CanCollide = false
                        v.CFrame = v.CFrame:Lerp(CFrame.new(tPos), 0.2)
                        v.Velocity = (tPos - v.Position) * 150 -- VELOCIDADE DE BALA
                    end
                end
            end
            task.wait()
        end
    end)
end)

-- 4. LAG SERVER (OPÇÃO EXPERIMENTAL)
addOption("LAG SERVER (SPAM PHYSICS)", function()
    for i = 1, 100 do
        task.spawn(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and not v.Anchored then
                    v.Velocity = Vector3.new(0, 1000000, 0)
                end
            end
        end)
    end
end)

-- 5. MODO FANTASMA (ATRAVESSA TUDO)
_G.Noclip = false
addOption("NOCLIP (ATRAVESSAR TUDO)", function()
    _G.Noclip = not _G.Noclip
    RunService.Stepped:Connect(function()
        if _G.Noclip then
            for _, v in pairs(getChar():GetChildren()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- Arrastar e Ícone (Já configurados)
local openIcon = Instance.new("ImageButton", sg)
openIcon.Size = UDim2.new(0, 80, 0, 80)
openIcon.Position = UDim2.new(0, 20, 0.5, -40)
openIcon.Image = "rbxassetid://11293318182"
openIcon.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)

openIcon.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
