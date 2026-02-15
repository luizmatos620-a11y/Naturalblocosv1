local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Criar ScreenGui
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenu_V1_Brookhaven_Edition"
sg.ResetOnSpawn = false

-- --- 1. INTRO LUIZ MENU V1 (Efeito 3D Moderno) ---
local introContainer = Instance.new("Frame", sg)
introContainer.Size = UDim2.new(1, 0, 1, 0)
introContainer.BackgroundTransparency = 1

local introText = Instance.new("TextLabel", introContainer)
introText.Size = UDim2.new(0, 600, 0, 120)
introText.Position = UDim2.new(0.5, -300, 0.5, -60)
introText.BackgroundTransparency = 1
introText.Text = "LUIZ MENU V1"
introText.TextColor3 = Color3.fromRGB(255, 255, 255)
introText.Font = Enum.Font.GothamBold
introText.TextSize = 1
introText.TextTransparency = 1

local shadow = introText:Clone()
shadow.Parent = introContainer
shadow.TextColor3 = Color3.fromRGB(120, 0, 255)
shadow.ZIndex = introText.ZIndex - 1

task.spawn(function()
    local info = TweenInfo.new(1.2, Enum.EasingStyle.Quint)
    TweenService:Create(introText, info, {TextSize = 70, TextTransparency = 0}):Play()
    TweenService:Create(shadow, info, {TextSize = 72, TextTransparency = 0.5, Position = UDim2.new(0.5, -297, 0.5, -57)}):Play()
    wait(2)
    TweenService:Create(introText, info, {TextTransparency = 1, TextSize = 110}):Play()
    TweenService:Create(shadow, info, {TextTransparency = 1, TextSize = 112}):Play()
    wait(1)
    introContainer:Destroy()
end)

-- --- 2. INTERFACE GRANDE (ESTILO SIDEBAR PROFISSIONAL) ---
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 650, 0, 420) 
main.Position = UDim2.new(0.5, -325, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.BackgroundTransparency = 0.05
main.BorderSizePixel = 0
main.Visible = false
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

-- Barra Lateral
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 180, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar)

local tabButtons = Instance.new("Frame", sidebar)
tabButtons.Size = UDim2.new(1, -20, 1, -60)
tabButtons.Position = UDim2.new(0, 10, 0, 50)
tabButtons.BackgroundTransparency = 1
Instance.new("UIListLayout", tabButtons).Padding = UDim.new(0, 8)

-- Conteúdo Central
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -200, 1, -30)
content.Position = UDim2.new(0, 190, 0, 15)
content.BackgroundTransparency = 1

-- Botão Fechar
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.Text = "X"
closeBtn.TextSize = 22
closeBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.GothamBold

-- --- 3. ÍCONE DE ABRIR ARRASTÁVEL (CAVEIRA) ---
local openIcon = Instance.new("ImageButton", sg)
openIcon.Size = UDim2.new(0, 65, 0, 65)
openIcon.Position = UDim2.new(0.5, -32, 0, 20)
openIcon.Visible = false
openIcon.Image = "rbxassetid://11293318182" 
openIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
openIcon.ZIndex = 10
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)

-- Função Arrastar Ícone
local draggingIcon, iconStart, iconPos
openIcon.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        draggingIcon = true iconStart = i.Position iconPos = openIcon.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if draggingIcon and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local delta = i.Position - iconStart
        openIcon.Position = UDim2.new(iconPos.X.Scale, iconPos.X.Offset + delta.X, iconPos.Y.Scale, iconPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function() draggingIcon = false end)

closeBtn.MouseButton1Click:Connect(function() main.Visible = false openIcon.Visible = true end)
openIcon.MouseButton1Click:Connect(function() main.Visible = true openIcon.Visible = false end)

-- --- 4. SISTEMA DE CRIAÇÃO DE OPÇÕES ---
local function createTab(name)
    local btn = Instance.new("TextButton", tabButtons)
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    Instance.new("UICorner", btn)

    local page = Instance.new("ScrollingFrame", content)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Visible = false
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 2
    Instance.new("UIListLayout", page).Padding = UDim.new(0, 12)

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(content:GetChildren()) do p.Visible = false end
        page.Visible = true
    end)
    return page
end

local function addOption(parent, txt, cb)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -10, 0, 50)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 15
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- --- 5. DEFINIÇÃO DAS ABAS ---
local jogoPage = createTab("Jogo")
local playerPage = createTab("Player")
local serverPage = createTab("Servidor")
local farmPage = createTab("Farm")
local trollPage = createTab("Troll")

-- OPÇÕES ABA PLAYER
addOption(playerPage, "Velocidade Flash (100)", function() lp.Character.Humanoid.WalkSpeed = 100 end)
addOption(playerPage, "Super Pulo (150)", function() lp.Character.Humanoid.JumpPower = 150 end)
addOption(playerPage, "Pulo Infinito", function()
    UserInputService.JumpRequest:Connect(function() lp.Character.Humanoid:ChangeState("Jumping") end)
end)

-- OPÇÕES ABA TROLL (ESPECIAL BROOKHAVEN)
local audioBox = Instance.new("TextBox", trollPage)
audioBox.Size = UDim2.new(1, -10, 0, 40)
audioBox.PlaceholderText = "Cole o ID do Áudio aqui..."
audioBox.Text = ""
audioBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
audioBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", audioBox)

addOption(trollPage, "Tocar Som (Local/SoundService)", function()
    local s = Instance.new("Sound", game:GetService("SoundService"))
    s.SoundId = "rbxassetid://"..audioBox.Text
    s.Volume = 10
    s:Play()
end)

addOption(trollPage, "Ficar Invisível (Todos Jogos)", function()
    local char = lp.Character
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 1 end
    end
    if char:FindFirstChild("Head") and char.Head:FindFirstChild("face") then char.Head.face:Destroy() end
end)

addOption(trollPage, "Animação Zumbi (FE)", function()
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://616159544"
    local load = lp.Character.Humanoid:LoadAnimation(anim)
    load:Play()
end)

addOption(trollPage, "Virar uma Caixa", function()
    local box = Instance.new("Part", lp.Character)
    box.Size = Vector3.new(5,5,5)
    box.BrickColor = BrickColor.new("Slime green")
    box.CanCollide = false
    local weld = Instance.new("Weld", box)
    weld.Part0 = box
    weld.Part1 = lp.Character.HumanoidRootPart
end)

-- ARRASTAR MENU PRINCIPAL
local d, ds, sp
main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then d = true ds = i.Position sp = main.Position end end)
UserInputService.InputChanged:Connect(function(i) if d then
    local delta = i.Position - ds
    main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y)
end end)
UserInputService.InputEnded:Connect(function() d = false end)

task.delay(3.5, function() main.Visible = true jogoPage.Visible = true end)
