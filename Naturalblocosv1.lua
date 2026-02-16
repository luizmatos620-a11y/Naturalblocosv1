-- LUIZ MENU V1 - OMNIPOTENCE X (PVP UPDATE)
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- --- CONFIGURAÇÕES DE PVP (VARIÁVEIS) ---
local AimbotSettings = {
    Enabled = false,
    FOV = 150,
    Color = Color3.fromRGB(255, 0, 0),
    Thickness = 2,
    Visible = true,
    TargetPart = "Head", -- Pode mudar para HumanoidRootPart
    Smoothing = 0.1 -- Suavidade do trave (0.1 a 1)
}

-- Desenhar o Círculo do FOV
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = AimbotSettings.Color
FOVCircle.Thickness = AimbotSettings.Thickness
FOVCircle.Filled = false
FOVCircle.Radius = AimbotSettings.FOV
FOVCircle.Visible = AimbotSettings.Visible
FOVCircle.Transparency = 1

-- Função para achar o inimigo mais próximo dentro do FOV
local function GetClosestPlayer()
    local target = nil
    local dist = AimbotSettings.FOV
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild(AimbotSettings.TargetPart) then
            local pos, onScreen = Camera:WorldToViewportPoint(p.Character[AimbotSettings.TargetPart].Position)
            if onScreen then
                local mouseDist = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                if mouseDist < dist then
                    dist = mouseDist
                    target = p
                end
            end
        end
    end
    return target
end

-- --- INTERFACE COM ABAS (ADICIONANDO PVP) ---
local sg = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 650, 0, 500)
main.Position = UDim2.new(0.5, -325, 0.5, -250)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Instance.new("UICorner", main)

local tabHolder = Instance.new("Frame", main)
tabHolder.Size = UDim2.new(1, 0, 0, 50)
tabHolder.BackgroundTransparency = 1

local container = Instance.new("Frame", main)
container.Size = UDim2.new(1, -20, 1, -70)
container.Position = UDim2.new(0, 10, 0, 60)
container.BackgroundTransparency = 1

local layouts = {}
local function createTab(name, pos)
    local b = Instance.new("TextButton", tabHolder)
    b.Size = UDim2.new(0.2, 0, 1, 0)
    b.Position = UDim2.new(pos * 0.2, 0, 0, 0)
    b.Text = name
    b.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Code
    b.TextSize = 16
    
    local scroll = Instance.new("ScrollingFrame", container)
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.Visible = (pos == 0)
    scroll.CanvasSize = UDim2.new(0, 0, 4, 0)
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 5)
    
    b.MouseButton1Click:Connect(function()
        for _, v in pairs(layouts) do v.Visible = false end
        scroll.Visible = true
    end)
    table.insert(layouts, scroll)
    return scroll
end

local tabPvP = createTab("PVP ELITE", 0)
local tabDestruicao = createTab("COMBATE", 1)
local tabFisica = createTab("FÍSICA", 2)
local tabMundo = createTab("MUNDO", 3)

local function addOpt(tab, txt, cb)
    local b = Instance.new("TextButton", tab)
    b.Size = UDim2.new(1, -10, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Code
    b.TextSize = 16
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- --- ABA PVP: OPÇÕES AVANÇADAS ---
addOpt(tabPvP, "ATIVAR AIMBOT (LOCK-ON)", function()
    AimbotSettings.Enabled = not AimbotSettings.Enabled
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "LUIZ PVP", Text = AimbotSettings.Enabled and "AIMBOT ON" or "AIMBOT OFF"})
end)

addOpt(tabPvP, "AUMENTAR FOV (+50)", function()
    AimbotSettings.FOV = AimbotSettings.FOV + 50
    FOVCircle.Radius = AimbotSettings.FOV
end)

addOpt(tabPvP, "DIMINUIR FOV (-50)", function()
    AimbotSettings.FOV = AimbotSettings.FOV - 50
    FOVCircle.Radius = AimbotSettings.FOV
end)

addOpt(tabPvP, "TARGET: HEAD / TORSO", function()
    if AimbotSettings.TargetPart == "Head" then
        AimbotSettings.TargetPart = "HumanoidRootPart"
    else
        AimbotSettings.TargetPart = "Head"
    end
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "LUIZ PVP", Text = "ALVO: " .. AimbotSettings.TargetPart})
end)

addOpt(tabPvP, "HITBOX EXPANDER (20 STUDS)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            p.Character.HumanoidRootPart.Size = Vector3.new(20, 20, 20)
            p.Character.HumanoidRootPart.Transparency = 0.7
            p.Character.HumanoidRootPart.CanCollide = false
        end
    end
end)

addOpt(tabPvP, "RECOIL CONTROL (SEM TREMOR)", function()
    -- Tenta anular tremores de câmera comuns em scripts de armas
    RunService.RenderStepped:Connect(function()
        if AimbotSettings.Enabled then
            lp.Character.Humanoid.CameraOffset = Vector3.new(0,0,0)
        end
    end)
end)

addOpt(tabPvP, "TRIGGER BOT (AUTO-SHOOT)", function()
    _G.Trigger = not _G.Trigger
    task.spawn(function()
        while _G.Trigger do
            local target = GetClosestPlayer()
            if target and lp.Character:FindFirstChildOfClass("Tool") then
                lp.Character:FindFirstChildOfClass("Tool"):Activate()
            end
            task.wait(0.1)
        end
    end)
end)

-- Loop do Aimbot e FOV
RunService.RenderStepped:Connect(function()
    FOVCircle.Position = UserInputService:GetMouseLocation()
    if AimbotSettings.Enabled then
        local target = GetClosestPlayer()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character[AimbotSettings.TargetPart].Position)
        end
    end
end)

-- (As outras abas de Combate, Física e Mundo permanecem com as opções anteriores)
-- ... [Adicione as opções de Destruição, Física e Mundo aqui conforme o script anterior]
