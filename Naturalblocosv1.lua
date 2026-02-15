local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenu_V1_Final"
sg.ResetOnSpawn = false

-- --- 1. INTERFACE ---
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 650, 0, 420) 
main.Position = UDim2.new(0.5, -325, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
main.Visible = false
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)

-- Botão de Minimizar (X)
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.TextSize = 25
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.GothamBold

-- Ícone de Abrir (Caveira Arrastável)
local openIcon = Instance.new("ImageButton", sg)
openIcon.Size = UDim2.new(0, 65, 0, 65)
openIcon.Position = UDim2.new(0, 20, 0.5, -32)
openIcon.Image = "rbxassetid://11293318182"
openIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
openIcon.Visible = true
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)

closeBtn.MouseButton1Click:Connect(function() main.Visible = false openIcon.Visible = true end)
openIcon.MouseButton1Click:Connect(function() main.Visible = true openIcon.Visible = false end)

-- --- SISTEMA DE ABAS (Simplificado para o código não ficar gigante) ---
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 170, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", sidebar)

local container = Instance.new("Frame", main)
container.Size = UDim2.new(1, -190, 1, -20)
container.Position = UDim2.new(0, 180, 0, 10)
container.BackgroundTransparency = 1

local function addOption(name, cb)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, -10, 0, 45)
    b.Text = name
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
    Instance.new("UIListLayout", container).Padding = UDim.new(0, 10)
end

-- --- FUNÇÕES PODEROSAS E OTIMIZADAS ---

-- 1. OBJECT KILL (SEM LAG)
_G.PartKill = false
addOption("Chuva de Objetos (ANTI-LAG)", function()
    _G.PartKill = not _G.PartKill
    if _G.PartKill then
        task.spawn(function()
            while _G.PartKill do
                local parts = 0
                for _, p in pairs(workspace:GetDescendants()) do
                    if parts > 20 then break end -- Limite de 20 peças por vez para não travar o celular
                    if p:IsA("BasePart") and not p.Anchored and p:IsA("Part") then
                        for _, pl in pairs(Players:GetPlayers()) do
                            if pl ~= lp and pl.Character and pl.Character:FindFirstChild("Head") then
                                p.CFrame = pl.Character.Head.CFrame
                                p.Velocity = Vector3.new(0, 300, 0)
                                parts = parts + 1
                            end
                        end
                    end
                end
                task.wait(0.2) -- Delay maior para o processador do celular respirar
            end
        end)
    end
end)

-- 2. FLING (SEGURO - SÓ ELES VOAM)
local flinging = false
addOption("Fling (Matar no Toque)", function()
    flinging = not flinging
    local hrp = lp.Character.HumanoidRootPart
    if flinging then
        local bV = Instance.new("BodyAngularVelocity", hrp)
        bV.Name = "LuizFling"
        bV.AngularVelocity = Vector3.new(0, 999999, 0)
        bV.MaxTorque = Vector3.new(0, math.huge, 0)
        
        task.spawn(function()
            while flinging do
                for _, v in pairs(lp.Character:GetChildren()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
                task.wait()
            end
        end)
    else
        if hrp:FindFirstChild("LuizFling") then hrp.LuizFling:Destroy() end
    end
end)

-- 3. FLY ESTÁTICO (FUGIR DOS DESASTRES)
local flying = false
addOption("Fly Estático (Céu)", function()
    flying = not flying
    local hrp = lp.Character.HumanoidRootPart
    if flying then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "LuizFly"
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        hrp.CFrame = hrp.CFrame * CFrame.new(0, 70, 0) -- Sobe direto pro céu
    else
        if hrp:FindFirstChild("LuizFly") then hrp.LuizFly:Destroy() end
    end
end)

-- --- SISTEMA DE ARRASTAR ---
local function drag(frame)
    local d, ds, sp
    frame.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then d = true ds = i.Position sp = frame.Position end end)
    UserInputService.InputChanged:Connect(function(i) if d then
        local delta = i.Position - ds
        frame.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y)
    end end)
    UserInputService.InputEnded:Connect(function() d = false end)
end
drag(main)
drag(openIcon)

main.Visible = true
openIcon.Visible = false
