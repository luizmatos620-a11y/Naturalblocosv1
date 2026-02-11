local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Criar a ScreenGui principal
local sg = Instance.new("ScreenGui")
sg.Name = "LuizMenuGui"
sg.Parent = game.CoreGui
sg.ResetOnSpawn = false -- Para o menu não sumir quando morreres

-- QUADRO PRINCIPAL
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 260, 0, 400)
main.Position = UDim2.new(0.5, -130, 0.5, -200)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
main.BorderSizePixel = 0
main.Visible = true
main.ClipsDescendants = true

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 12)

-- BARRA DE TÍTULO
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = "LUIZ MENU"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(80, 0, 200)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

-- ÍCONE FLUTUANTE (Para abrir/fechar o menu)
local icon = Instance.new("TextButton", sg)
icon.Size = UDim2.new(0, 50, 0, 50)
icon.Position = UDim2.new(0, 10, 0.5, 0)
icon.BackgroundColor3 = Color3.fromRGB(80, 0, 200)
icon.Text = "L"
icon.TextColor3 = Color3.fromRGB(255, 255, 255)
icon.Font = Enum.Font.GothamBold
icon.TextSize = 25
local iconCorner = Instance.new("UICorner", icon)
iconCorner.CornerRadius = UDim.new(1, 0) -- Fica redondo

-- FUNÇÃO ABRIR/FECHAR AO CLICAR NO ÍCONE
icon.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
    if main.Visible then
        main:TweenSize(UDim2.new(0, 260, 0, 400), "Out", "Back", 0.4, true)
    end
end)

-- CONTAINER DE BOTÕES
local container = Instance.new("ScrollingFrame", main)
container.Size = UDim2.new(1, -20, 1, -60)
container.Position = UDim2.new(0, 10, 0, 55)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 1.5, 0)
container.ScrollBarThickness = 2

local layout = Instance.new("UIListLayout", container)
layout.Padding = UDim.new(0, 8)

local function createButton(name, callback)
    local btn = Instance.new("TextButton", container)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(callback)
end

-- --- FUNÇÕES ---
createButton("Teleportar Ilha", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 47, 18)
end)

createButton("Ativar ESP", function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and p.Character then
            local h = Instance.new("Highlight", p.Character)
            h.FillColor = Color3.fromRGB(150, 0, 255)
        end
    end
end)

createButton("Mover Blocos", function()
    local est = workspace:FindFirstChild("Structure")
    if est then
        for _, o in pairs(est:GetDescendants()) do
            if o:IsA("BasePart") then o.CFrame = o.CFrame + Vector3.new(0, 60, 0) end
        end
    end
end)

createButton("Velocidade 100", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

-- ARRASTAR MENU
local dragging, dragInput, dragStart, startPos
main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- ANIMAÇÃO INICIAL
main.Size = UDim2.new(0, 0, 0, 0)
main:TweenSize(UDim2.new(0, 260, 0, 400), "Out", "Back", 0.5, true)
