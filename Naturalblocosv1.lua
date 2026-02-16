local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenu_V1_Vortex_Real"
sg.ResetOnSpawn = false

-- --- INTERFACE ---
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 650, 0, 420) 
main.Position = UDim2.new(0.5, -325, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.Visible = false
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.TextSize = 25
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.GothamBold

local openIcon = Instance.new("ImageButton", sg)
openIcon.Size = UDim2.new(0, 65, 0, 65)
openIcon.Position = UDim2.new(0, 20, 0.5, -32)
openIcon.Image = "rbxassetid://11293318182"
openIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
openIcon.Visible = true
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)

closeBtn.MouseButton1Click:Connect(function() main.Visible = false openIcon.Visible = true end)
openIcon.MouseButton1Click:Connect(function() main.Visible = true openIcon.Visible = false end)

-- Sistema de Abas
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 170, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Instance.new("UICorner", sidebar)

local container = Instance.new("Frame", main)
container.Size = UDim2.new(1, -190, 1, -20)
container.Position = UDim2.new(0, 180, 0, 10)
container.BackgroundTransparency = 1
Instance.new("UIListLayout", container).Padding = UDim.new(0, 10)

local function addOption(txt, cb)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, -10, 0, 45)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- --- FUNÇÃO DO FURACÃO REAL (DANOS FÍSICOS) ---
_G.Vortex = false
addOption("FURACÃO LETAL (SPAWN)", function()
    _G.Vortex = not _G.Vortex
    local spawnPos = Vector3.new(-285, 180, 375) -- Centro do Spawn do Natural Disaster
    local angle = 0
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "LUIZ MENU V1",
        Text = _G.Vortex and "FURACÃO ATIVADO!" or "FURACÃO PARADO!",
        Duration = 3
    })
    
    task.spawn(function()
        while _G.Vortex do
            angle = angle + 0.5
            local count = 0
            for _, p in pairs(workspace:GetDescendants()) do
                -- Só pega o que NÃO está preso e que NÃO é do seu personagem
                if p:IsA("BasePart") and not p.Anchored and not p:IsDescendantOf(lp.Character) then
                    if count > 30 then break end -- Limite para o celular aguentar
                    
                    local x = math.cos(angle) * 30
                    local z = math.sin(angle) * 30
                    local targetPos = spawnPos + Vector3.new(x, 10, z)
                    
                    -- Aplica Força Física Real em vez de só mudar CFrame
                    p.CFrame = CFrame.new(targetPos) 
                    p.Velocity = (targetPos - p.Position) * 30 -- Puxa com força
                    p.RotVelocity = Vector3.new(20, 20, 20) -- Faz a peça girar matando no toque
                    
                    count = count + 1
                end
            end
            task.wait(0.02)
        end
    end)
end)

-- --- OUTRAS OPÇÕES COMPLETAS ---
addOption("Fling (Matar no Toque)", function()
    local hrp = lp.Character.HumanoidRootPart
    local bV = Instance.new("BodyAngularVelocity", hrp)
    bV.AngularVelocity = Vector3.new(0, 999999, 0)
    bV.MaxTorque = Vector3.new(0, math.huge, 0)
    task.spawn(function()
        while bV.Parent do
            for _, v in pairs(lp.Character:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end
            task.wait()
        end
    end)
end)

addOption("TP Loop All (Piscar Players)", function()
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

-- Arrastar
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

main.Visible = true
