local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Criar ScreenGui
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenu_V1_Final"
sg.ResetOnSpawn = false

-- --- 1. INTRO LUIZ MENU V1 ---
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

-- --- 2. INTERFACE PRINCIPAL ---
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 650, 0, 420) 
main.Position = UDim2.new(0.5, -325, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.Visible = false
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

-- Botão de Minimizar (X)
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.TextSize = 25
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.GothamBold

-- Sidebar e Conteúdo
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

-- Ícone de Abrir (Caveira)
local openIcon = Instance.new("ImageButton", sg)
openIcon.Size = UDim2.new(0, 65, 0, 65)
openIcon.Position = UDim2.new(0, 20, 0.5, -32)
openIcon.Image = "rbxassetid://11293318182"
openIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
openIcon.Visible = false
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)

closeBtn.MouseButton1Click:Connect(function() main.Visible = false openIcon.Visible = true end)
openIcon.MouseButton1Click:Connect(function() main.Visible = true openIcon.Visible = false end)

-- --- 3. SISTEMA DE CRIAÇÃO ---
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

-- --- 4. ABAS E FUNÇÕES COMPLETAS ---
local desastrePage = createTab("Desastres")
local tpPage = createTab("Teleport Pro")
local trollPage = createTab("Troll")
local playerPage = createTab("Player")

-- ABA DESASTRES (VÓRTICE E ANTI-LAG)
_G.Vortex = false
addOption(desastrePage, "Furacão no Spawn (Vórtice)", function()
    _G.Vortex = not _G.Vortex
    local spawnPos = Vector3.new(-285, 180, 375)
    local angle = 0
    task.spawn(function()
        while _G.Vortex do
            angle = angle + 0.4
            local count = 0
            for _, p in pairs(workspace:GetDescendants()) do
                if count > 20 then break end
                if p:IsA("BasePart") and not p.Anchored and p:IsA("Part") then
                    local x = math.cos(angle) * 25
                    local z = math.sin(angle) * 25
                    p.CFrame = CFrame.new(spawnPos + Vector3.new(x, 8, z))
                    p.Velocity = Vector3.new(0, 60, 0)
                    count = count + 1
                end
            end
            task.wait(0.03)
        end
    end)
end)

addOption(desastrePage, "Ilha Segura (Teleport)", function() lp.Character.HumanoidRootPart.CFrame = CFrame.new(-285, 175, 375) end)

-- ABA TELEPORT PRO
_G.TPLoop = false
addOption(tpPage, "TP Loop All (Atropelar)", function()
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

-- ABA TROLL (FLING E AURA)
local flinging = false
addOption(trollPage, "Fling (Só eles voam)", function()
    flinging = not flinging
    local hrp = lp.Character.HumanoidRootPart
    if flinging then
        local bV = Instance.new("BodyAngularVelocity", hrp)
        bV.Name = "LuizFling"
        bV.AngularVelocity = Vector3.new(0, 999999, 0)
        bV.MaxTorque = Vector3.new(0, math.huge, 0)
        task.spawn(function()
            while flinging do
                for _, v in pairs(lp.Character:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end
                RunService.Stepped:Wait()
            end
        end)
    else if hrp:FindFirstChild("LuizFling") then hrp.LuizFling:Destroy() end end
end)

addOption(trollPage, "Kill Aura (Auto-Attack)", function()
    _G.Aura = not _G.Aura
    while _G.Aura do
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= lp and p.Character and (lp.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude < 25 then
                local tool = lp.Character:FindFirstChildOfClass("Tool")
                if tool then tool:Activate() end
            end
        end
        task.wait(0.1)
    end
end)

-- ABA PLAYER (FLY E NOCLIP)
addOption(playerPage, "Fly Estático (Céu)", function()
    local hrp = lp.Character.HumanoidRootPart
    if not hrp:FindFirstChild("LuizFly") then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "LuizFly"
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        hrp.CFrame = hrp.CFrame * CFrame.new(0, 80, 0)
    else hrp.LuizFly:Destroy() end
end)

-- --- SISTEMA DE ARRASTAR ---
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

task.wait(3.5)
main.Visible = true
desastrePage.Visible = true
