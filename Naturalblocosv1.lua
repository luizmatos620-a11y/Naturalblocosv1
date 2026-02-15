local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Criar ScreenGui
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenu_V1_Final"
sg.ResetOnSpawn = false

-- --- 1. INTRO LUIZ MENU V1 (Efeito 3D) ---
local introContainer = Instance.new("Frame", sg)
introContainer.Size = UDim2.new(1, 0, 1, 0)
introContainer.BackgroundTransparency = 1

local introText = Instance.new("TextLabel", introContainer)
introText.Size = UDim2.new(0, 500, 0, 100)
introText.Position = UDim2.new(0.5, -250, 0.5, -50)
introText.BackgroundTransparency = 1
introText.Text = "LUIZ MENU V1"
introText.TextColor3 = Color3.fromRGB(255, 255, 255)
introText.Font = Enum.Font.GothamBold
introText.TextSize = 1
introText.TextTransparency = 1

local shadow = introText:Clone()
shadow.Parent = introContainer
shadow.TextColor3 = Color3.fromRGB(80, 0, 200)
shadow.ZIndex = introText.ZIndex - 1

task.spawn(function()
    local info = TweenInfo.new(1, Enum.EasingStyle.Quint)
    TweenService:Create(introText, info, {TextSize = 60, TextTransparency = 0}):Play()
    TweenService:Create(shadow, info, {TextSize = 62, TextTransparency = 0.5, Position = UDim2.new(0.5, -248, 0.5, -48)}):Play()
    wait(2)
    TweenService:Create(introText, info, {TextTransparency = 1, TextSize = 100}):Play()
    TweenService:Create(shadow, info, {TextTransparency = 1, TextSize = 102}):Play()
    wait(1)
    introContainer:Destroy()
end)

-- --- 2. INTERFACE ESTILO SIDEBAR ---
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 550, 0, 320)
main.Position = UDim2.new(0.5, -275, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
main.BorderSizePixel = 0
main.Visible = false
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)

local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 150, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar)

local tabButtons = Instance.new("Frame", sidebar)
tabButtons.Size = UDim2.new(1, -20, 1, -50)
tabButtons.Position = UDim2.new(0, 10, 0, 45)
tabButtons.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", tabButtons)
layout.Padding = UDim.new(0, 5)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -170, 1, -20)
content.Position = UDim2.new(0, 160, 0, 10)
content.BackgroundTransparency = 1

-- Botões de fechar e abrir
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
closeBtn.BackgroundTransparency = 1

local openIcon = Instance.new("ImageButton", sg)
openIcon.Size = UDim2.new(0, 50, 0, 50)
openIcon.Position = UDim2.new(0.5, -25, 0, 15)
openIcon.Visible = false
openIcon.Image = "rbxassetid://11293318182" -- ID Caveira
openIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)

closeBtn.MouseButton1Click:Connect(function() main.Visible = false openIcon.Visible = true end)
openIcon.MouseButton1Click:Connect(function() main.Visible = true openIcon.Visible = false end)

-- --- 3. SISTEMA DE ABAS ---
local function createTab(name)
    local btn = Instance.new("TextButton", tabButtons)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.Font = Enum.Font.Gotham
    Instance.new("UICorner", btn)

    local page = Instance.new("ScrollingFrame", content)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Visible = false
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 0
    Instance.new("UIListLayout", page).Padding = UDim.new(0, 8)

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(content:GetChildren()) do p.Visible = false end
        page.Visible = true
    end)
    return page
end

local function addOption(parent, txt, cb)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -10, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- Criando as Abas
local jogoPage = createTab("Jogo")
local playerPage = createTab("Player")
local serverPage = createTab("Servidor")
local farmPage = createTab("Farm")
local trollPage = createTab("Troll")

-- --- ABA PLAYER ---
addOption(playerPage, "Velocidade (100)", function() lp.Character.Humanoid.WalkSpeed = 100 end)
addOption(playerPage, "Pulo Alto (120)", function() lp.Character.Humanoid.JumpPower = 120 end)
addOption(playerPage, "Pulo Infinito", function()
    UserInputService.JumpRequest:Connect(function() lp.Character.Humanoid:ChangeState("Jumping") end)
end)

-- --- ABA JOGO ---
addOption(jogoPage, "Remover Texturas (No Lag)", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
    end
end)
addOption(jogoPage, "Full Bright (Claridade)", function()
    game.Lighting.Brightness = 2
    game.Lighting.ClockTime = 14
    game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
end)

-- --- ABA SERVIDOR ---
addOption(serverPage, "ESP Jogadores", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local h = Instance.new("Highlight", p.Character)
            h.FillColor = Color3.fromRGB(255, 0, 0)
        end
    end
end)
addOption(serverPage, "Reentrar no Servidor", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, lp)
end)

-- --- ABA FARM ---
addOption(farmPage, "Auto-Clicker (E)", function()
    _G.Click = not _G.Click
    while _G.Click do
        local tool = lp.Character:FindFirstChildOfClass("Tool")
        if tool then tool:Activate() end
        task.wait(0.1)
    end
end)
addOption(farmPage, "Anti-AFK", function()
    lp.Idled:Connect(function()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end)
end)

-- --- ABA TROLL ---
local audioBox = Instance.new("TextBox", trollPage)
audioBox.Size = UDim2.new(1, -10, 0, 35)
audioBox.PlaceholderText = "ID do Áudio..."
audioBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
audioBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", audioBox)

addOption(trollPage, "Tocar Som", function()
    local s = Instance.new("Sound", game:GetService("SoundService"))
    s.SoundId = "rbxassetid://"..audioBox.Text
    s.Volume = 10
    s:Play()
end)
addOption(trollPage, "Ficar Invisível", function()
    for _, v in pairs(lp.Character:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 1 end
    end
end)

-- Finalização
task.delay(3.5, function() main.Visible = true jogoPage.Visible = true end)

-- Arrastar Menu
local d, ds, sp
main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then d = true ds = i.Position sp = main.Position end end)
UserInputService.InputChanged:Connect(function(i) if d then
    local delta = i.Position - ds
    main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y)
end end)
UserInputService.InputEnded:Connect(function() d = false end)
