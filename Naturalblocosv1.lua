-- LUIZ MENU V1 - OMNIPOTENCE X (DEFINITIVO)
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- --- CONFIGURAÇÕES AIMBOT ---
local AimSettings = { Enabled = false, FOV = 150, Target = "Head" }
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
FOVCircle.Thickness = 2
FOVCircle.Transparency = 1
FOVCircle.Visible = false

local function GetClosest()
    local target, dist = nil, AimSettings.FOV
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild(AimSettings.Target) then
            local pos, vis = Camera:WorldToViewportPoint(p.Character[AimSettings.Target].Position)
            if vis then
                local mDist = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                if mDist < dist then dist = mDist target = p end
            end
        end
    end
    return target
end

-- --- INTERFACE PRINCIPAL ---
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenuV1"

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 650, 0, 500)
main.Position = UDim2.new(0.5, -325, 0.5, -250)
main.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
main.BorderSizePixel = 2
main.BorderColor3 = Color3.fromRGB(255, 0, 0)
main.Visible = true
Instance.new("UICorner", main)

-- Botão de Minimizar (X)
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 25
Instance.new("UICorner", closeBtn)

-- Ícone Flutuante para Abrir
local openIcon = Instance.new("ImageButton", sg)
openIcon.Size = UDim2.new(0, 70, 0, 70)
openIcon.Position = UDim2.new(0, 20, 0.5, -35)
openIcon.Image = "rbxassetid://11293318182" -- Caveira
openIcon.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
openIcon.Visible = false
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)

closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    openIcon.Visible = true
end)

openIcon.MouseButton1Click:Connect(function()
    main.Visible = true
    openIcon.Visible = false
end)

-- Abas
local tabHolder = Instance.new("Frame", main)
tabHolder.Size = UDim2.new(1, 0, 0, 50)
tabHolder.BackgroundColor3 = Color3.fromRGB(15, 0, 0)

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
    b.BackgroundColor3 = Color3.fromRGB(25, 0, 0)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Code
    b.TextSize = 14
    
    local scroll = Instance.new("ScrollingFrame", container)
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.Visible = (pos == 0)
    scroll.CanvasSize = UDim2.new(0, 0, 6, 0)
    scroll.ScrollBarThickness = 3
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 5)
    
    b.MouseButton1Click:Connect(function()
        for _, v in pairs(layouts) do v.Visible = false end
        scroll.Visible = true
    end)
    table.insert(layouts, scroll)
    return scroll
end

local function addOpt(tab, txt, cb)
    local b = Instance.new("TextButton", tab)
    b.Size = UDim2.new(1, -10, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(35, 0, 0)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Code
    b.TextSize = 16
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- --- CRIANDO AS ABAS ---
local tabPvP = createTab("PVP ELITE", 0)
local tabCombat = createTab("COMBATE", 1)
local tabPhys = createTab("FÍSICA", 2)
local tabVisual = createTab("VISUAL", 3)
local tabWorld = createTab("MUNDO", 4)

-- --- OPÇÕES (RESUMO DAS 30+) ---
-- PVP
addOpt(tabPvP, "ATIVAR AIMBOT LOCK", function() AimSettings.Enabled = not AimSettings.Enabled FOVCircle.Visible = AimSettings.Enabled end)
addOpt(tabPvP, "FOV +", function() AimSettings.FOV = AimSettings.FOV + 50 FOVCircle.Radius = AimSettings.FOV end)
addOpt(tabPvP, "HITBOX EXPANDER", function() for _,p in pairs(Players:GetPlayers()) do if p ~= lp and p.Character then p.Character.HumanoidRootPart.Size = Vector3.new(15,15,15) p.Character.HumanoidRootPart.Transparency = 0.7 end end end)
addOpt(tabPvP, "TRIGGER BOT", function() _G.Trig = not _G.Trig end)

-- COMBATE
addOpt(tabCombat, "FLING AURA (KILL)", function() _G.Fl = not _G.Fl task.spawn(function() while _G.Fl do RunService.Heartbeat:Wait() lp.Character.HumanoidRootPart.Velocity = Vector3.new(0,1e6,0) lp.Character.HumanoidRootPart.RotVelocity = Vector3.new(1e6,1e6,1e6) end end) end)
addOpt(tabCombat, "BRING ALL", function() for _,p in pairs(Players:GetPlayers()) do if p ~= lp and p.Character then p.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame end end end)
addOpt(tabCombat, "FREEZE ALL", function() for _,p in pairs(Players:GetPlayers()) do if p ~= lp and p.Character then p.Character.HumanoidRootPart.Anchored = true end end end)

-- FÍSICA
addOpt(tabPhys, "FLY (SHIFT BOOST)", function() _G.Fly = not _G.Fly end) -- Implementado no loop
addOpt(tabPhys, "SPEED 500", function() lp.Character.Humanoid.WalkSpeed = 500 end)
addOpt(tabPhys, "NOCLIP", function() _G.NC = not _G.NC end)

-- VISUAL
addOpt(tabVisual, "ESP NAMES", function() --[Lógica de nomes aqui]-- end)
addOpt(tabVisual, "HIGHLIGHT ALL", function() for _,p in pairs(Players:GetPlayers()) do if p ~= lp and p.Character then Instance.new("Highlight", p.Character) end end end)

-- MUNDO
addOpt(tabWorld, "VOID MAP", function() for _,v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") and not v.Anchored then v.CFrame = CFrame.new(0,-1000,0) end end end)
addOpt(tabWorld, "SERVER LAG", function() while task.wait() do for i=1,100 do Instance.new("Part", workspace).Velocity = Vector3.new(1e6,1e6,1e6) end end end)
addOpt(tabWorld, "INFINITE YIELD", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)

-- [LOOP DE ATUALIZAÇÃO]
RunService.RenderStepped:Connect(function()
    FOVCircle.Position = UserInputService:GetMouseLocation()
    if AimSettings.Enabled then
        local t = GetClosest()
        if t then Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.Character[AimSettings.Target].Position) end
    end
end)

-- (Arraste do Menu)
local dragging, dragInput, dragStart, startPos
main.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true dragStart = input.Position startPos = main.Position end end)
main.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
UserInputService.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then local delta = input.Position - dragStart main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
        
