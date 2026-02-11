local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Criar ScreenGui
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenuModern"
sg.ResetOnSpawn = false

-- --- INTRO MODERNA ---
local introText = Instance.new("TextLabel", sg)
introText.Size = UDim2.new(0, 500, 0, 100)
introText.Position = UDim2.new(0.5, -250, 0.5, -50)
introText.BackgroundTransparency = 1
introText.Text = "LUIZ MENU"
introText.TextColor3 = Color3.fromRGB(150, 0, 255)
introText.Font = Enum.Font.GothamBold
introText.TextSize = 1
introText.TextTransparency = 1

-- Animação da Intro
TweenService:Create(introText, TweenInfo.new(1, Enum.EasingStyle.Quint), {TextSize = 80, TextTransparency = 0}):Play()
wait(1.5)
TweenService:Create(introText, TweenInfo.new(0.8, Enum.EasingStyle.Back), {Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.5, 0, 0.5, 0), TextSize = 0, TextTransparency = 1}):Play()
wait(0.8)

-- --- QUADRO PRINCIPAL ---
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 260, 0, 420)
main.Position = UDim2.new(0.5, -130, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Visible = true

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 15)

-- Barra de Título
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = "LUIZ MENU V3"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(90, 0, 220)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
Instance.new("UICorner", title)

-- Botão Flutuante (L)
local icon = Instance.new("TextButton", sg)
icon.Size = UDim2.new(0, 45, 0, 45)
icon.Position = UDim2.new(0, 20, 0.5, 0)
icon.BackgroundColor3 = Color3.fromRGB(90, 0, 220)
icon.Text = "L"
icon.TextColor3 = Color3.fromRGB(255, 255, 255)
icon.Font = Enum.Font.GothamBold
icon.TextSize = 22
Instance.new("UICorner", icon).CornerRadius = UDim.new(1, 0)

icon.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

-- Scroll de Botões
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -20, 1, -60)
scroll.Position = UDim2.new(0, 10, 0, 55)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 1.8, 0)
scroll.ScrollBarThickness = 0

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 10)

local function createButton(txt, cb)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(1, 0, 0, 38)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- --- FUNÇÕES ---

createButton("Voo (Fly) - Q para ligar", function()
    local flying = false
    local speed = 50
    local keys = {w = false, s = false, a = false, d = false}
    
    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.Q then
            flying = not flying
            local bv = lp.Character.HumanoidRootPart:FindFirstChild("FlyBV") or Instance.new("BodyVelocity", lp.Character.HumanoidRootPart)
            bv.Name = "FlyBV"
            bv.MaxForce = flying and Vector3.new(math.huge, math.huge, math.huge) or Vector3.new(0,0,0)
            while flying do
                local dir = workspace.CurrentCamera.CFrame
                local vel = Vector3.new(0,0,0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + dir.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - dir.LookVector end
                bv.Velocity = vel * speed
                task.wait()
            end
            bv:Destroy()
        end
    end)
end)

createButton("Teleportar: Ilha", function()
    lp.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 47, 18)
end)

createButton("Ativar ESP", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local h = Instance.new("Highlight", p.Character)
            h.FillColor = Color3.fromRGB(150, 0, 255)
        end
    end
end)

createButton("Mover Blocos (Caos)", function()
    local s = workspace:FindFirstChild("Structure")
    if s then
        for _, v in pairs(s:GetDescendants()) do
            if v:IsA("BasePart") then v.CFrame = v.CFrame + Vector3.new(0, 60, 0) end
        end
    end
end)

-- SKIN STEALER FIX
local skinBox = Instance.new("TextBox", scroll)
skinBox.Size = UDim2.new(1, 0, 0, 35)
skinBox.PlaceholderText = "Nome do Player..."
skinBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
skinBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", skinBox)

createButton("Copiar Skin!", function()
    local target = Players:FindFirstChild(skinBox.Text)
    if target and target.Character then
        local hum = lp.Character:FindFirstChildOfClass("Humanoid")
        local desc = Players:GetHumanoidDescriptionFromUserId(target.UserId)
        if hum and desc then
            hum:ApplyDescription(desc)
        end
    end
end)

createButton("Velocidade Flash", function()
    lp.Character.Humanoid.WalkSpeed = 100
end)

-- Arrastar (Draggable)
local d, ds, sp
main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true ds = i.Position sp = main.Position end end)
UserInputService.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement and d then
    local delta = i.Position - ds
    main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y)
end end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end)
