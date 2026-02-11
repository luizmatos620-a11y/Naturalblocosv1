-- GUI MODERNA: LUIZ MENU
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenuGui"

-- Quadro Principal
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 260, 0, 440)
main.Position = UDim2.new(0.5, -130, 0.5, -220)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Visible = true
main.BackgroundTransparency = 1 -- Começa invisível para a animação

-- Cantos Arredondados
local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 10)

-- Barra de Título
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = "LUIZ MENU"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(70, 0, 180)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local titleCorner = Instance.new("UICorner", title)
titleCorner.CornerRadius = UDim.new(0, 10)

-- Container para os botões (com lista automática)
local container = Instance.new("ScrollingFrame", main)
container.Size = UDim2.new(1, -20, 1, -60)
container.Position = UDim2.new(0, 10, 0, 55)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 1.2, 0)
container.ScrollBarThickness = 2

local layout = Instance.new("UIListLayout", container)
layout.Padding = UDim.new(0, 8)

-- Função para criar botões modernos
local function createButton(name, callback)
    local btn = Instance.new("TextButton", container)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.AutoButtonColor = true
    
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(callback)
end

-- --- FUNÇÕES DO MENU ---

createButton("Teleportar: Ilha Segura", function()
    local lp = game.Players.LocalPlayer
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        lp.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 47, 18)
    end
end)

createButton("Ativar ESP (Jogadores)", function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and p.Character then
            local h = Instance.new("Highlight", p.Character)
            h.FillColor = Color3.fromRGB(120, 0, 255)
        end
    end
end)

createButton("Mover Blocos (Caos)", function()
    local est = workspace:FindFirstChild("Structure")
    if est then
        for _, o in pairs(est:GetDescendants()) do
            if o:IsA("BasePart") then o.CFrame = o.CFrame + Vector3.new(0, 60, 0) end
        end
    end
end)

-- Campo de Skin moderno
local skinInput = Instance.new("TextBox", container)
skinInput.Size = UDim2.new(1, 0, 0, 35)
skinInput.PlaceholderText = "Nome do Jogador..."
skinInput.Text = ""
skinInput.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
skinInput.TextColor3 = Color3.fromRGB(255, 255, 255)
local sCor = Instance.new("UICorner", skinInput)

createButton("Copiar Skin!", function()
    local t = game.Players:FindFirstChild(skinInput.Text)
    if t then
        game.Players.LocalPlayer.CharacterAppearanceId = t.UserId
        game.Players.LocalPlayer:LoadCharacter()
    end
end)

createButton("Velocidade Flash", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 120
end)

createButton("Super Pulo", function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 120
end)

createButton("Fechar Menu", function()
    main:TweenSize(UDim2.new(0,0,0,0), "Out", "Quad", 0.3, true)
    wait(0.3)
    sg:Destroy()
end)

-- --- ANIMAÇÃO DE ENTRADA ---
main.Size = UDim2.new(0, 260, 0, 0) -- Começa com altura 0
main.BackgroundTransparency = 0
TweenService:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 260, 0, 440)}):Play()

-- Arrastar Menu (Draggable)
local dragToggle, dragStart, startPos
main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = true
        dragStart = input.Position
        startPos = main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragToggle then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragToggle = false end
end)
