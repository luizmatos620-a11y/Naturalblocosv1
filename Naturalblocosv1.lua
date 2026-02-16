-- LUIZ MENU V1 - REVISADO E FINALIZADO
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Função segura para pegar o corpo
local function getHRP()
    local char = lp.Character or lp.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart", 5)
end

-- Interface
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenu_V1_Final_Revised"
sg.ResetOnSpawn = false

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 550, 0, 480)
main.Position = UDim2.new(0.5, -275, 0.5, -240)
main.BackgroundColor3 = Color3.fromRGB(5, 0, 0)
main.BorderSizePixel = 3
main.BorderColor3 = Color3.fromRGB(255, 0, 0)
Instance.new("UICorner", main)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "LUIZ MENU V1 - GOD MODE"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22

local container = Instance.new("ScrollingFrame", main)
container.Size = UDim2.new(1, -20, 1, -60)
container.Position = UDim2.new(0, 10, 0, 50)
container.BackgroundTransparency = 1
container.ScrollBarThickness = 4
Instance.new("UIListLayout", container).Padding = UDim.new(0, 8)

local function addOption(txt, cb)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, -10, 0, 45)
    b.BackgroundColor3 = Color3.fromRGB(25, 0, 0)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 18
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- --- FUNÇÕES REVISADAS ---

-- 1. ESCUDO DE ENTULHO (ORBITAL AO REDOR DE VOCÊ)
_G.Shield = false
addOption("ATIVAR ESCUDO DE ENTULHO", function()
    _G.Shield = not _G.Shield
    local angle = 0
    task.spawn(function()
        while _G.Shield do
            angle = angle + 0.4
            local hrp = getHRP()
            if hrp then
                local count = 0
                for _, p in pairs(workspace:GetDescendants()) do
                    if p:IsA("BasePart") and not p.Anchored and not p:IsDescendantOf(lp.Character) then
                        if count > 30 then break end
                        
                        local x = math.cos(angle + (count * 0.6)) * 18
                        local z = math.sin(angle + (count * 0.6)) * 18
                        local targetPos = hrp.Position + Vector3.new(x, 2, z)
                        
                        p.CFrame = CFrame.new(targetPos)
                        p.Velocity = (targetPos - p.Position) * 50
                        p.RotVelocity = Vector3.new(40, 40, 40)
                        count = count + 1
                    end
                end
            end
            task.wait(0.01)
        end
    end)
end)

-- 2. APOCALIPSE (EXPULSAR TUDO DO MAPA)
addOption("APOCALIPSE (LIMPAR MAPA)", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(lp.Character) then
            v.CFrame = CFrame.new(0, -10000, 0)
        end
    end
end)

-- 3. VOID ALL (LEVAR TODOS PRO ABISMO)
addOption("VOID ALL (KILL ALL VÁCUO)", function()
    local hrp = getHRP()
    if hrp then
        local oldPos = hrp.CFrame
        hrp.CFrame = CFrame.new(0, -450, 0)
        task.wait(0.3)
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character.HumanoidRootPart.CFrame = hrp.CFrame
            end
        end
        task.wait(0.8)
        hrp.CFrame = oldPos
    end
end)

-- 4. TP LOOP (ATROPELAR PLAYERS)
_G.TPLoop = false
addOption("TP LOOP (ANIQUILAÇÃO)", function()
    _G.TPLoop = not _G.TPLoop
    task.spawn(function()
        while _G.TPLoop do
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = getHRP()
                    if hrp then hrp.CFrame = v.Character.HumanoidRootPart.CFrame end
                    task.wait(0.12)
                end
            end
        end
    end)
end)

-- 5. GRAVIDADE ZERO (SUBIDA RÁPIDA)
_G.Grav = false
addOption("GRAVIDADE ZERO (MAPA SUBIR)", function()
    _G.Grav = not _G.Grav
    task.spawn(function()
        while _G.Grav do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(lp.Character) then
                    v.Velocity = Vector3.new(0, 100, 0)
                end
            end
            task.wait(0.3)
        end
    end)
end)

-- Botão de Fechar (X)
local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0, 35, 0, 35)
close.Position = UDim2.new(1, -40, 0, 5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.MouseButton1Click:Connect(function() sg:Destroy() end)

-- Arrastar
main.Active = true
main.Draggable = true
