
-- ==========================================
-- PAINEL FUTURISTA | MOBILE
-- Interface corrigida para Roblox
-- Use como LocalScript no seu próprio jogo
-- ==========================================

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Config = {
    PainelVisivel = true,
    Flutuar = false,
    CorrerRapido = false,
    VelocidadePadrao = 16,
    VelocidadeRapida = 24
}

-- Evita criar interfaces duplicadas
local antigo = PlayerGui:FindFirstChild("PainelMobile")
if antigo then
    antigo:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PainelMobile"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Função para arredondar elementos
local function Arredondar(objeto, raio)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, raio)
    corner.Parent = objeto
end

-- Botão flutuante
local BotaoAbrir = Instance.new("TextButton")
BotaoAbrir.Name = "BotaoAbrir"
BotaoAbrir.Size = UDim2.fromOffset(55, 55)
BotaoAbrir.Position = UDim2.new(0, 12, 0.5, -27)
BotaoAbrir.BackgroundColor3 = Color3.fromRGB(0, 150, 220)
BotaoAbrir.Text = "⚙"
BotaoAbrir.TextSize = 30
BotaoAbrir.TextColor3 = Color3.new(1, 1, 1)
BotaoAbrir.BorderSizePixel = 0
BotaoAbrir.Parent = ScreenGui
Arredondar(BotaoAbrir, 28)

-- Painel principal
local Painel = Instance.new("Frame")
Painel.Name = "Painel"
Painel.Size = UDim2.new(0.82, 0, 0, 360)
Painel.Position = UDim2.new(0.5, 0, 0.5, 0)
Painel.AnchorPoint = Vector2.new(0.5, 0.5)
Painel.BackgroundColor3 = Color3.fromRGB(12, 18, 40)
Painel.BorderSizePixel = 0
Painel.ClipsDescendants = true
Painel.Parent = ScreenGui

local limite = Instance.new("UISizeConstraint")
limite.MaxSize = Vector2.new(340, 430)
limite.MinSize = Vector2.new(240, 280)
limite.Parent = Painel

local borda = Instance.new("UIStroke")
borda.Color = Color3.fromRGB(0, 180, 255)
borda.Thickness = 2
borda.Parent = Painel

Arredondar(Painel, 14)

-- Título
local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, -55, 0, 48)
Titulo.Position = UDim2.fromOffset(10, 0)
Titulo.BackgroundTransparency = 1
Titulo.Text = "PAINEL MOBILE"
Titulo.TextColor3 = Color3.fromRGB(0, 220, 255)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 18
Titulo.Parent = Painel

-- Fechar
local Fechar = Instance.new("TextButton")
Fechar.Size = UDim2.fromOffset(36, 36)
Fechar.Position = UDim2.new(1, -42, 0, 6)
Fechar.BackgroundColor3 = Color3.fromRGB(190, 45, 55)
Fechar.Text = "X"
Fechar.TextColor3 = Color3.new(1, 1, 1)
Fechar.TextSize = 18
Fechar.Font = Enum.Font.GothamBold
Fechar.BorderSizePixel = 0
Fechar.Parent = Painel
Arredondar(Fechar, 8)

-- Lista rolável
local Lista = Instance.new("ScrollingFrame")
Lista.Size = UDim2.new(1, -16, 1, -60)
Lista.Position = UDim2.fromOffset(8, 52)
Lista.BackgroundTransparency = 1
Lista.BorderSizePixel = 0
Lista.ScrollBarThickness = 4
Lista.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
Lista.AutomaticCanvasSize = Enum.AutomaticSize.Y
Lista.CanvasSize = UDim2.new(0, 0, 0, 0)
Lista.Parent = Painel

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 8)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Lista

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 4)
padding.PaddingBottom = UDim.new(0, 8)
padding.Parent = Lista

-- Criador de botões corrigido
local function CriarBotao(texto, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -8, 0, 44)
    btn.BackgroundColor3 = Color3.fromRGB(28, 45, 80)
    btn.BorderSizePixel = 0
    btn.Text = texto
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.AutoButtonColor = true
    btn.Parent = Lista

    Arredondar(btn, 8)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 160, 240)
    stroke.Thickness = 1
    stroke.Parent = btn

    btn.Activated:Connect(function()
        if callback then
            callback(btn)
        end
    end)

    return btn
end

-- Botões de exemplo
CriarBotao("🏃 Alternar velocidade", function(btn)
    Config.CorrerRapido = not Config.CorrerRapido

    btn.Text = Config.CorrerRapido
        and "🏃 Velocidade: ATIVADA"
        or "🏃 Velocidade: NORMAL"

    btn.BackgroundColor3 = Config.CorrerRapido
        and Color3.fromRGB(0, 100, 60)
        or Color3.fromRGB(28, 45, 80)

    local char = Player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")

    if hum then
        hum.WalkSpeed = Config.CorrerRapido
            and Config.VelocidadeRapida
            or Config.VelocidadePadrao
    end
end)

CriarBotao("🔄 Restaurar velocidade", function()
    Config.CorrerRapido = false

    local char = Player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")

    if hum then
        hum.WalkSpeed = Config.VelocidadePadrao
    end
end)

-- Abrir e fechar
local function AlternarPainel()
    Config.PainelVisivel = not Painel.Visible
    Painel.Visible = Config.PainelVisivel
end

BotaoAbrir.Activated:Connect(AlternarPainel)

Fechar.Activated:Connect(function()
    Painel.Visible = false
    Config.PainelVisivel = false
end)

-- Mantém a velocidade configurada após renascer
Player.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid", 10)

    if hum then
        hum.WalkSpeed = Config.CorrerRapido
            and Config.VelocidadeRapida
            or Config.VelocidadePadrao
    end
end)

print("[PAINEL MOBILE] Interface carregada!")
