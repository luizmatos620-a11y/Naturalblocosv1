local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

-- Criar ScreenGui
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenu_V1_Pro_Edition"
sg.ResetOnSpawn = false

-- --- 1. INTRO LUIZ MENU V1 (Efeito 3D) ---
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

-- --- 2. INTERFACE PRINCIPAL ---
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 650, 0, 420) 
main.Position = UDim2.new(0.5, -325, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.BorderSizePixel = 0
main.Visible = false
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 180, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Instance.new("UICorner", sidebar)

local tabButtons = Instance.new("Frame", sidebar)
tabButtons.Size = UDim2.new(1, -20, 1, -60)
tabButtons.Position = UDim2.new(0, 10, 0, 50)
tabButtons.BackgroundTransparency = 1
Instance.new("UIListLayout", tabButtons).Padding = UDim.new(0, 8)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -200, 1, -30)
content.Position = UDim2.new(0, 190, 0, 15)
content.BackgroundTransparency = 1

local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.GothamBold

local openIcon = Instance.new("ImageButton", sg)
openIcon.Size = UDim2.new(0, 65, 0, 65)
openIcon.Position = UDim2.new(0.5, -32, 0, 20)
openIcon.Visible = false
openIcon.Image = "rbxassetid://11293318182" 
openIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)

-- Arrastar Ícone
local draggingIcon, iconStart, iconPos
openIcon.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingIcon = true iconStart = i.Position iconPos = openIcon.Position end end)
UserInputService.InputChanged:Connect(function(i) if draggingIcon then
    local delta = i.Position - iconStart
    openIcon.Position = UDim2.new(iconPos.X.Scale, iconPos.X.Offset + delta.X, iconPos.Y.Scale, iconPos.Y.Offset + delta.Y)
end end)
UserInputService.InputEnded:Connect(function() draggingIcon = false end)

closeBtn.MouseButton1Click:Connect(function() main.Visible = false openIcon.Visible = true end)
openIcon.MouseButton1Click:Connect(function() main.Visible = true openIcon.Visible = false end)

-- --- 3. SISTEMA DE ABAS ---
local function createTab(name)
    local btn = Instance.new("TextButton", tabButtons)
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    Instance.new("UICorner", btn)

    local page = Instance.new("ScrollingFrame", content)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Visible = false
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 0
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
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- --- 4. CONFIGURAÇÃO DAS ABAS ---
local desastrePage = createTab("Desastres")
local playerPage = createTab("Player")
local serverPage = createTab("Servidor")
local trollPage = createTab("Troll")

-- ABA DESASTRES
addOption(desastrePage, "Ilha Segura (Teleport)", function()
    lp.Character.HumanoidRootPart.CFrame = CFrame.new(-285, 175, 375)
end)
addOption(desastrePage, "Remover Dano de Queda", function()
    lp.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
end)

-- ABA PLAYER (FLY, NOCLIP, TELEPORT)
local targetBox = Instance.new("TextBox", playerPage)
targetBox.Size = UDim2.new(1, -10, 0, 40)
targetBox.PlaceholderText = "Nome do Jogador..."
targetBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
targetBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", targetBox)

addOption(playerPage, "Teleportar ao Player", function()
    local target = targetBox.Text
    for _, v in pairs(Players:GetPlayers()) do
        if v.Name:lower():sub(1, #target) == target:lower() then
            lp.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
        end
    end
end)

local noclip = false
addOption(playerPage, "Noclip (Ativar/Desativar)", function()
    noclip = not noclip
    RunService.Stepped:Connect(function()
        if noclip then
            for _, v in pairs(lp.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

local flying = false
addOption(playerPage, "Fly Estático (Céu)", function()
    flying = not flying
    local hrp = lp.Character.HumanoidRootPart
    if flying then
        local bg = Instance.new("BodyGyro", hrp)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.CFrame = hrp.CFrame
        local bv = Instance.new("BodyVelocity", hrp)
        bv.velocity = Vector3.new(0, 0.1, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        hrp.CFrame = hrp.CFrame * CFrame.new(0, 50, 0) -- Sobe para o céu
    else
        for _, v in pairs(hrp:GetChildren()) do
            if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then v:Destroy() end
        end
    end
end)

-- ABA SERVIDOR
addOption(serverPage, "Contar Jogadores", function()
    local count = #Players:GetPlayers()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Servidor",
        Text = "Existem " .. count .. " jogadores online.",
        Duration = 5
    })
end)

-- ABA TROLL
addOption(trollPage, "Fling (Matar no Toque)", function()
    local bV = Instance.new("BodyAngularVelocity", lp.Character.HumanoidRootPart)
    bV.AngularVelocity = Vector3.new(0, 99999, 0)
    bV.MaxTorque = Vector3.new(0, math.huge, 0)
    bV.P = math.huge
end)

-- Arrastar Menu
local d, ds, sp
main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then d = true ds = i.Position sp = main.Position end end)
UserInputService.InputChanged:Connect(function(i) if d then
    local delta = i.Position - ds
    main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y)
end end)
UserInputService.InputEnded:Connect(function() d = false end)

task.delay(3.5, function() main.Visible = true desastrePage.Visible = true end)
