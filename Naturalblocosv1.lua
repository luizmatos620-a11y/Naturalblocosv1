-- LUIZ MENU V1 - SANGUE FRIO (100% PVP DE ARMAS)
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- --- CONFIGURAÇÕES DE COMBATE ---
local PvP = {
    Aimbot = false,
    SilentAim = false,
    Wallhack = false,
    NoRecoil = false,
    FOV = 150,
    Smoothing = 0.05,
    TargetPart = "Head",
    CircleVisible = true
}

-- Desenho do Círculo de Mira (FOV)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
FOVCircle.Filled = false
FOVCircle.Transparency = 1

-- Função para achar o inimigo mais próximo (Lógica de Prioridade)
local function GetClosestTarget()
    local target = nil
    local shortestDist = PvP.FOV

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local part = p.Character:FindFirstChild(PvP.TargetPart)
            if part then
                local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local mousePos = UserInputService:GetMouseLocation()
                    local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        target = p
                    end
                end
            end
        end
    end
    return target
end

-- --- INTERFACE PROFISSIONAL ---
local sg = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 500, 0, 450)
main.Position = UDim2.new(0.5, -250, 0.5, -225)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.BorderColor3 = Color3.fromRGB(255, 0, 0)
main.BorderSizePixel = 2
Instance.new("UICorner", main)

-- Botão Minimizar (X)
local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0, 35, 0, 35)
close.Position = UDim2.new(1, -40, 0, 5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
close.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", close)

-- Ícone de Caveira (Minimizado)
local icon = Instance.new("ImageButton", sg)
icon.Size = UDim2.new(0, 65, 0, 65)
icon.Position = UDim2.new(0, 15, 0.5, -32)
icon.Image = "rbxassetid://11293318182"
icon.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
icon.Visible = false
Instance.new("UICorner", icon).CornerRadius = UDim.new(1, 0)

close.MouseButton1Click:Connect(function() main.Visible = false icon.Visible = true end)
icon.MouseButton1Click:Connect(function() main.Visible = true icon.Visible = false end)

-- Abas de PvP
local container = Instance.new("ScrollingFrame", main)
container.Size = UDim2.new(1, -20, 1, -60)
container.Position = UDim2.new(0, 10, 0, 50)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 2, 0)
Instance.new("UIListLayout", container).Padding = UDim.new(0, 8)

local function addToggle(txt, fn)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, -10, 0, 45)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Code
    b.TextSize = 17
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(fn)
end

-- --- OPÇÕES 100% PVP ---

addToggle("ATIVAR AIMBOT LOCK-ON", function() 
    PvP.Aimbot = not PvP.Aimbot 
    FOVCircle.Visible = PvP.Aimbot
end)

addToggle("HITBOX EXPANDER (BALAS MÁGICAS)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Size = Vector3.new(12, 12, 12) -- Inimigo vira um alvo gigante
                hrp.Transparency = 0.7
                hrp.CanCollide = false
            end
        end
    end
end)

addToggle("NO RECOIL (MIRA PARADA)", function()
    PvP.NoRecoil = not PvP.NoRecoil
    RunService.RenderStepped:Connect(function()
        if PvP.NoRecoil then
            lp.Character.Humanoid.CameraOffset = Vector3.new(0,0,0) -- Tenta anular o coice da arma
        end
    end)
end)

addToggle("SILENT AIM (TIRO INFALÍVEL)", function()
    PvP.SilentAim = not PvP.SilentAim
    -- Lógica interna para redirecionar projéteis (depende do sistema da arma)
end)

addToggle("WALLHACK (ESP BOX)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local h = Instance.new("Highlight", p.Character)
            h.FillColor = Color3.fromRGB(255, 0, 0)
            h.OutlineColor = Color3.fromRGB(255, 255, 255)
        end
    end
end)

addToggle("AUMENTAR FOV MIRA", function()
    PvP.FOV = PvP.FOV + 50
    FOVCircle.Radius = PvP.FOV
end)

addToggle("ALVO: CABEÇA / PEITO", function()
    PvP.TargetPart = (PvP.TargetPart == "Head" and "HumanoidRootPart" or "Head")
end)

addToggle("TRIGGER BOT (AUTO-FIRE)", function()
    _G.AutoFire = not _G.AutoFire
    task.spawn(function()
        while _G.AutoFire do
            task.wait(0.05)
            if GetClosestTarget() then
                local tool = lp.Character:FindFirstChildOfClass("Tool")
                if tool then tool:Activate() end
            end
        end
    end)
end)

addToggle("ESPD NOMES E DISTÂNCIA", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("Head") then
            local bg = Instance.new("BillboardGui", p.Character.Head)
            bg.AlwaysOnTop = true; bg.Size = UDim2.new(0,100,0,30)
            local tl = Instance.new("TextLabel", bg)
            tl.Text = p.Name .. " | " .. math.floor((lp.Character.Head.Position - p.Character.Head.Position).Magnitude) .. "m"
            tl.Size = UDim2.new(1,0,1,0); tl.TextColor3 = Color3.fromRGB(255,0,0); tl.BackgroundTransparency = 1
        end
    end
end)

-- --- LOOP DE EXECUÇÃO ---
RunService.RenderStepped:Connect(function()
    FOVCircle.Position = UserInputService:GetMouseLocation()
    if PvP.Aimbot then
        local t = GetClosestTarget()
        if t then
            local targetPos = t.Character[PvP.TargetPart].Position
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPos), PvP.Smoothing or 0.1)
        end
    end
end)

-- Arraste do Menu
local dragging, dragInput, dragStart, startPos
main.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true dragStart = input.Position startPos = main.Position end end)
main.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
UserInputService.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then local delta = input.Position - dragStart main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
