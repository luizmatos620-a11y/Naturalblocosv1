local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Criar ScreenGui
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenu_V1_GOD_MODE"
sg.ResetOnSpawn = false

-- --- 1. INTRO ---
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

task.spawn(function()
    local info = TweenInfo.new(1.2, Enum.EasingStyle.Quint)
    TweenService:Create(introText, info, {TextSize = 70, TextTransparency = 0}):Play()
    wait(2)
    TweenService:Create(introText, info, {TextTransparency = 1, TextSize = 110}):Play()
    wait(1)
    introContainer:Destroy()
end)

-- --- 2. INTERFACE ---
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 650, 0, 420) 
main.Position = UDim2.new(0.5, -325, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.Visible = false
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 170, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Instance.new("UICorner", sidebar)

local tabButtons = Instance.new("Frame", sidebar)
tabButtons.Size = UDim2.new(1, -20, 1, -60)
tabButtons.Position = UDim2.new(0, 10, 0, 50)
tabButtons.BackgroundTransparency = 1
Instance.new("UIListLayout", tabButtons).Padding = UDim.new(0, 8)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -190, 1, -20)
content.Position = UDim2.new(0, 180, 0, 10)
content.BackgroundTransparency = 1

local openIcon = Instance.new("ImageButton", sg)
openIcon.Size = UDim2.new(0, 65, 0, 65)
openIcon.Position = UDim2.new(0.5, -32, 0, 15)
openIcon.Image = "rbxassetid://11293318182"
openIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
openIcon.Visible = false
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)

-- --- 3. SISTEMA DE ABAS ---
local function createTab(name)
    local btn = Instance.new("TextButton", tabButtons)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn)

    local page = Instance.new("ScrollingFrame", content)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Visible = false
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 0
    Instance.new("UIListLayout", page).Padding = UDim.new(0, 10)

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(content:GetChildren()) do p.Visible = false end
        page.Visible = true
    end)
    return page
end

local function addOption(parent, txt, cb)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -10, 0, 45)
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
local bringPage = createTab("Bring")
local trollPage = createTab("Troll")
local serverPage = createTab("Servidor")

-- ABA DESASTRES (FUNÇÃO PEDIDA)
_G.PartKill = false
addOption(desastrePage, "Chuva de Objetos (KILL ALL)", function()
    _G.PartKill = not _G.PartKill
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "LUIZ MENU V1", Text = "Part Kill: " .. tostring(_G.PartKill)})
    
    while _G.PartKill do
        for _, p in pairs(workspace:GetDescendants()) do
            if p:IsA("BasePart") and not p.Anchored and not p:IsDescendantOf(lp.Character) then
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= lp and player.Character and player.Character:FindFirstChild("Head") then
                        p.CFrame = player.Character.Head.CFrame
                        p.Velocity = Vector3.new(0, 100, 0) -- Força o impacto
                    end
                end
            end
        end
        task.wait(0.1)
    end
end)

addOption(desastrePage, "Ilha Segura (Teleport)", function()
    lp.Character.HumanoidRootPart.CFrame = CFrame.new(-285, 175, 375)
end)

-- ABA PLAYER
local noclip = false
addOption(playerPage, "Noclip (Atravessar)", function()
    noclip = not noclip
    RunService.Stepped:Connect(function()
        if noclip and lp.Character then
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
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "LuizFly"
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        hrp.CFrame = hrp.CFrame * CFrame.new(0, 60, 0)
    else
        if hrp:FindFirstChild("LuizFly") then hrp.LuizFly:Destroy() end
    end
end)

-- ABA TROLL
addOption(trollPage, "Fling (Matar no Encosto)", function()
    local bV = Instance.new("BodyAngularVelocity", lp.Character.HumanoidRootPart)
    bV.AngularVelocity = Vector3.new(0, 999999, 0)
    bV.MaxTorque = Vector3.new(0, math.huge, 0)
    bV.P = math.huge
end)

addOption(trollPage, "Kill Aura (Auto-Attack)", function()
    _G.Aura = not _G.Aura
    while _G.Aura do
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                if (lp.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude < 25 then
                    local tool = lp.Character:FindFirstChildOfClass("Tool")
                    if tool then tool:Activate() end
                end
            end
        end
        task.wait(0.1)
    end
end)

-- ABA BRING
local bringInput = Instance.new("TextBox", bringPage)
bringInput.Size = UDim2.new(1, -10, 0, 40)
bringInput.PlaceholderText = "Nome do Player..."
bringInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
bringInput.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", bringInput)

addOption(bringPage, "Puxar Player (Bring)", function()
    local target = bringInput.Text:lower()
    for _, v in pairs(Players:GetPlayers()) do
        if v.Name:lower():sub(1, #target) == target then
            v.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame
        end
    end
end)

-- ABA SERVIDOR
addOption(serverPage, "Contar Jogadores", function()
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Servidor", Text = "Jogadores: " .. #Players:GetPlayers()})
end)

-- --- SISTEMA DE ARRASTAR E ABRIR ---
local dragging, dragStart, startPos
main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true dragStart = i.Position startPos = main.Position end end)
UserInputService.InputChanged:Connect(function(i) if dragging then
    local delta = i.Position - dragStart
    main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end end)
UserInputService.InputEnded:Connect(function() dragging = false end)

openIcon.MouseButton1Click:Connect(function() main.Visible = true openIcon.Visible = false end)
Instance.new("TextButton", main).MouseButton1Click:Connect(function() main.Visible = false openIcon.Visible = true end) -- Botão fechar improvisado

task.wait(3.5)
main.Visible = true
desastrePage.Visible = true
