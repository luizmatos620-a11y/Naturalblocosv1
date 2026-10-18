
--==================================================
-- NEON MOBILE MENU | ROBLOX
-- Interface mobile com tema azul neon
-- LocalScript para Roblox Studio
--==================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- LIMPEZA
local previous = playerGui:FindFirstChild("NeonMobileMenu")
if previous then
    previous:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "NeonMobileMenu"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.Parent = playerGui

local C = {
    Background = Color3.fromRGB(8, 13, 29),
    Panel = Color3.fromRGB(14, 24, 48),
    Button = Color3.fromRGB(22, 40, 72),
    Neon = Color3.fromRGB(0, 190, 255),
    White = Color3.fromRGB(235, 245, 255),
    Green = Color3.fromRGB(0, 220, 155),
    Red = Color3.fromRGB(255, 75, 100)
}

local function round(obj, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = obj
end

local function outline(obj, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness or 1
    stroke.Parent = obj
end

local function makeLabel(parent, text, size, position)
    local label = Instance.new("TextLabel")
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = C.White
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextWrapped = true
    label.Parent = parent
    return label
end

-- BOTÃO FLUTUANTE
local openButton = Instance.new("TextButton")
openButton.Size = UDim2.fromOffset(54, 54)
openButton.Position = UDim2.new(0, 12, 0.5, -27)
openButton.BackgroundColor3 = C.Panel
openButton.Text = "N"
openButton.TextColor3 = C.Neon
openButton.TextSize = 25
openButton.Font = Enum.Font.GothamBold
openButton.Parent = gui
round(openButton, 27)
outline(openButton, C.Neon, 2)

-- PAINEL
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0.86, 0, 0.72, 0)
panel.Position = UDim2.new(0.5, 0, 0.5, 0)
panel.AnchorPoint = Vector2.new(0.5, 0.5)
panel.BackgroundColor3 = C.Background
panel.Parent = gui
round(panel, 16)
outline(panel, C.Neon, 2)

local constraint = Instance.new("UISizeConstraint")
constraint.MinSize = Vector2.new(260, 300)
constraint.MaxSize = Vector2.new(400, 540)
constraint.Parent = panel

-- CABEÇALHO
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 55)
header.BackgroundColor3 = C.Panel
header.BorderSizePixel = 0
header.Parent = panel
round(header, 14)

makeLabel(
    header,
    "NEON  /  MOBILE",
    UDim2.new(1, -65, 1, 0),
    UDim2.fromOffset(14, 0)
).TextColor3 = C.Neon

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(36, 36)
close.Position = UDim2.new(1, -44, 0, 9)
close.BackgroundColor3 = C.Red
close.Text = "X"
close.TextColor3 = C.White
close.TextSize = 16
close.Parent = header
round(close, 9)

-- ABAS
local tabs = Instance.new("Frame")
tabs.Size = UDim2.new(1, -16, 0, 42)
tabs.Position = UDim2.fromOffset(8, 62)
tabs.BackgroundTransparency = 1
tabs.Parent = panel

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.Padding = UDim.new(0, 5)
tabLayout.Parent = tabs

-- CONTEÚDO ROLÁVEL
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -16, 1, -116)
content.Position = UDim2.fromOffset(8, 108)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = C.Neon
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.Parent = panel

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 9)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Parent = content

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 4)
padding.PaddingBottom = UDim.new(0, 8)
padding.Parent = content

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if not child:IsA("UIListLayout")
            and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end
end

local function addButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -8, 0, 46)
    button.BackgroundColor3 = C.Button
    button.Text = text
    button.TextColor3 = C.White
    button.TextSize = 14
    button.Font = Enum.Font.GothamMedium
    button.TextWrapped = true
    button.AutoButtonColor = true
    button.Parent = content
    round(button, 10)
    outline(button, C.Neon, 1)

    button.Activated:Connect(function()
        local tween = TweenService:Create(
            button,
            TweenInfo.new(0.12),
            {BackgroundColor3 = C.Panel}
        )
        tween:Play()
        callback(button)
    end)

    return button
end

local function addSection(text)
    local label = makeLabel(
        content,
        text,
        UDim2.new(1, -8, 0, 30),
        UDim2.new()
    )
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = C.Neon
    label.TextXAlignment = Enum.TextXAlignment.Left
end

-- ESTADO
local currentTab = "HOME"
local showFPS = true
local showCoords = true
local showMap = true
local animationMessage = "Escolha um emote abaixo."

-- INDICADORES
local status = Instance.new("Frame")
status.Size = UDim2.new(1, -16, 0, 30)
status.Position = UDim2.new(0, 8, 1, -35)
status.BackgroundColor3 = C.Panel
status.Parent = panel
round(status, 8)

local statusText = makeLabel(
    status,
    "● SISTEMA ATIVO",
    UDim2.new(1, -12, 1, 0),
    UDim2.fromOffset(8, 0)
)
statusText.TextColor3 = C.Green
statusText.TextSize = 11

-- ABA HOME
local function homeTab()
    clearContent()
    addSection("⌂  PAINEL PRINCIPAL")

    addButton("📊 FPS: LIGADO", function(btn)
        showFPS = not showFPS
        btn.Text = showFPS and "📊 FPS: LIGADO" or "📊 FPS: DESLIGADO"
        btn.BackgroundColor3 = showFPS and C.Button or C.Panel
    end)

    addButton("📍 Coordenadas: LIGADAS", function(btn)
        showCoords = not showCoords
        btn.Text = showCoords
            and "📍 Coordenadas: LIGADAS"
            or "📍 Coordenadas: DESLIGADAS"
    end)

    addButton("🗺 Minimapa local: LIGADO", function(btn)
        showMap = not showMap
        btn.Text = showMap
            and "🗺 Minimapa local: LIGADO"
            or "🗺 Minimapa local: DESLIGADO"
    end)

    addSection("ℹ  INFORMAÇÕES")
    addButton("Sobre o menu", function()
        statusText.Text = "NEON MOBILE • INTERFACE LOCAL"
    end)
end

-- ABA ANIMAÇÕES
local function animationTab()
    clearContent()
    addSection("▶  EMOTES DO PERSONAGEM")

    local emotes = {
        {"👋 Acenar", "wave"},
        {"👏 Aplaudir", "cheer"},
        {"😂 Rir", "laugh"},
        {"🕺 Dançar", "dance"}
    }

    for _, item in ipairs(emotes) do
        local name = item[1]
        local emote = item[2]

        addButton(name, function()
            local character = player.Character
            local humanoid = character
                and character:FindFirstChildOfClass("Humanoid")

            if humanoid then
                local ok, result = pcall(function()
                    return humanoid:PlayEmote(emote)
                end)

                statusText.Text = ok and result ~= false
                    and ("Emote: " .. emote)
                    or "Emote indisponível neste jogo"
            else
                statusText.Text = "Personagem não encontrado"
            end
        end)
    end

    addSection("Os emotes dependem do avatar e do jogo.")
end

-- ABA MAPA
local function mapTab()
    clearContent()
    addSection("⌖  MINIMAPA LOCAL")

    local map = Instance.new("Frame")
    map.Size = UDim2.new(1, -8, 0, 180)
    map.BackgroundColor3 = Color3.fromRGB(5, 18, 32)
    map.Parent = content
    round(map, 10)
    outline(map, C.Neon, 1)

    local grid = Instance.new("UIGridLayout")
    grid.CellSize = UDim2.new(0, 28, 0, 28)
    grid.CellPadding = UDim2.new(0, 4, 0, 4)
    grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
    grid.VerticalAlignment = Enum.VerticalAlignment.Center
    grid.Parent = map

    -- Grade decorativa local
    for i = 1, 25 do
        local cell = Instance.new("Frame")
        cell.BackgroundColor3 = C.Button
        cell.BorderSizePixel = 0
        cell.Parent = map
        round(cell, 3)
    end

    local marker = Instance.new("Frame")
    marker.Name = "PlayerMarker"
    marker.Size = UDim2.fromOffset(12, 12)
    marker.AnchorPoint = Vector2.new(0.5, 0.5)
    marker.Position = UDim2.new(0.5, 0, 0.5, 0)
    marker.BackgroundColor3 = C.Neon
    marker.ZIndex = 3
    marker.Parent = map
    round(marker, 6)

    local info = makeLabel(
        content,
        "Mapa ilustrativo — sua posição aparece nas coordenadas.",
        UDim2.new(1, -8, 0, 40),
        UDim2.new()
    )
    info.TextColor3 = C.Neon
end

-- ABA MOVIMENTO
local function movementTab()
    clearContent()
    addSection("⚙  MOVIMENTO")

    addButton("🏃 Velocidade", function()
        statusText.Text =
            "Ajuste de velocidade disponível no seu próprio jogo"
    end)

    addButton("⬆ Pulo", function()
        statusText.Text =
            "Ajuste de pulo disponível no seu próprio jogo"
    end)

    addButton("🪽 Voo", function()
        statusText.Text =
            "Configure o voo no Roblox Studio do seu jogo"
    end)

    addButton("📌 Teleporte autorizado", function()
        statusText.Text =
            "Cadastre pontos seguros no seu próprio jogo"
    end)
end

local renderers = {
    HOME = homeTab,
    ANIM = animationTab,
    MAP = mapTab,
    MOVE = movementTab
}

local function switchTab(name)
    currentTab = name
    renderers[name]()
end

local tabNames = {
    {"HOME", "⌂ Início"},
    {"ANIM", "▶ Emotes"},
    {"MAP", "⌖ Mapa"},
    {"MOVE", "⚙ Jogador"}
}

for _, data in ipairs(tabNames) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.25, -5, 1, 0)
    button.BackgroundColor3 = C.Button
    button.Text = data[2]
    button.TextColor3 = C.White
    button.TextSize = 10
    button.Font = Enum.Font.GothamBold
    button.Parent = tabs
    round(button, 8)

    button.Activated:Connect(function()
        switchTab(data[1])
    end)
end

openButton.Activated:Connect(function()
    panel.Visible = not panel.Visible
end)

close.Activated:Connect(function()
    panel.Visible = false
end)

-- FPS E COORDENADAS
local fpsLabel = makeLabel(
    gui,
    "FPS: --",
    UDim2.fromOffset(130, 25),
    UDim2.new(1, -140, 0, 12)
)
fpsLabel.TextColor3 = C.Neon
fpsLabel.TextXAlignment = Enum.TextXAlignment.Right

local coordLabel = makeLabel(
    gui,
    "X: --  Y: --  Z: --",
    UDim2.fromOffset(210, 25),
    UDim2.new(1, -220, 0, 38)
)
coordLabel.TextColor3 = C.White
coordLabel.TextXAlignment = Enum.TextXAlignment.Right
coordLabel.TextSize = 11

local frames = 0
local elapsed = 0

RunService.RenderStepped:Connect(function(dt)
    frames += 1
    elapsed += dt

    if elapsed >= 0.5 then
        local fps = math.floor(frames / elapsed)
        fpsLabel.Text = "FPS: " .. fps
        frames = 0
        elapsed = 0
    end

    fpsLabel.Visible = showFPS
    coordLabel.Visible = showCoords
    coordLabel.Visible = showCoords

    if showCoords then
        local character = player.Character
        local root = character
            and character:FindFirstChild("HumanoidRootPart")

        if root then
            local p = root.Position
            coordLabel.Text = string.format(
                "X: %.0f  Y: %.0f  Z: %.0f",
                p.X, p.Y, p.Z
            )
        end
    end
end)

switchTab("HOME")
print("[NEON MOBILE] Menu carregado")
