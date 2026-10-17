-- ==========================================
-- PAINEL FUTURISTA | VERSÃO MOBILE OTIMIZADA
-- ==========================================

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ================= CONFIGURAÇÕES ============
local Config = {
    Voar = false,
    AtravessarParedes = false,
    CopiarSkin = false,
    Flutuar = false,
    CorrerRapido = false,
    SpeedPadrao = 16,
    SpeedRapido = 55,
    ESP_Ativo = true,
    Box_Ativo = true,
    AimAtivo = false,
    AimParte = "Head",
    AimSmooth = 0.18,
    PainelVisivel = true
}

local voarVelocidade = 30
local ESP = {}

-- ============== CRIAÇÃO DA INTERFACE ============
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PainelMobile"
ScreenGui.Parent = PlayerGui
-- Importante para celular
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- BOTÃO FLUTUANTE PARA ABRIR/FECHAR PAINEL
local BotaoAbrir = Instance.new("TextButton")
BotaoAbrir.Name = "BotaoAbrir"
BotaoAbrir.Size = UDim2.new(0, 60, 0, 60)
BotaoAbrir.Position = UDim2.new(0.02, 0, 0.5, -30)
BotaoAbrir.BackgroundColor3 = Color3.fromRGB(0, 150, 220)
BotaoAbrir.Text = "⚙️"
BotaoAbrir.TextSize = 28
BotaoAbrir.BorderSizePixel = 2
BotaoAbrir.BorderColor3 = Color3.fromRGB(255, 255, 255)
BotaoAbrir.CornerRadius = UDim.new(0, 30)
BotaoAbrir.Parent = ScreenGui

-- PAINEL PRINCIPAL
local Painel = Instance.new("Frame")
Painel.Name = "Painel"
Painel.Size = UDim2.new(0, 280, 0, 400)
Painel.Position = UDim2.new(0.15, 0, 0.5, -200)
Painel.BackgroundColor3 = Color3.fromRGB(12, 18, 40)
Painel.BorderSizePixel = 3
Painel.BorderColor3 = Color3.fromRGB(0, 180, 255)
Painel.CornerRadius = UDim.new(0, 16)
Painel.ClipsDescendants = true
Painel.Parent = ScreenGui

local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 0, 50)
Titulo.BackgroundTransparency = 1
Titulo.Text = "📱 PAINEL MOBILE"
Titulo.TextColor3 = Color3.fromRGB(0, 220, 255)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 20
Titulo.Parent = Painel

local Fechar = Instance.new("TextButton")
Fechar.Size = UDim2.new(0, 40, 0, 40)
Fechar.Position = UDim2.new(1, -45, 0, 5)
Fechar.BackgroundColor3 = Color3.fromRGB(210, 50, 50)
Fechar.Text = "✕"
Fechar.TextColor3 = Color3.new(1,1,1)
Fechar.TextSize = 18
Fechar.CornerRadius = UDim.new(0, 8)
Fechar.Parent = Painel

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -20, 1, -60)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 55)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.ScrollBarColor3 = Color3.fromRGB(0, 180, 255)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, 520)
ScrollingFrame.Parent = Painel

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Parent = ScrollingFrame

-- BOTÕES DE CONTROLE DE VOO (LADO DIREITO DA TELA)
local PainelVoo = Instance.new("Frame")
PainelVoo.Size = UDim2.new(0, 140, 0, 140)
PainelVoo.Position = UDim2.new(0.98, -150, 0.75, -70)
PainelVoo.BackgroundTransparency = 0.85
PainelVoo.Visible = false
PainelVoo.Parent = ScreenGui

local function CriarBotaoVoo(texto, posicao, funcao)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 55, 0, 55)
    btn.Position = posicao
    btn.BackgroundColor3 = Color3.fromRGB(0, 80, 140)
    btn.BackgroundTransparency = 0.3
    btn.Text = texto
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 22
    btn.CornerRadius = UDim.new(0, 10)
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.fromRGB(0, 200, 255)
    btn.Parent = PainelVoo
    btn.TouchEnded:Connect(function() funcao(false) end)
    btn.TouchStarted:Connect(function() funcao(true) end)
    return btn
end

local subindo, descendo, frente, tras, esq, dir = false, false, false, false, false, false
CriarBotaoVoo("⬆", UDim2.new(0, 42, 0, 0), function(v) frente = v end)
CriarBotaoVoo("⬇", UDim2.new(0, 42, 0, 85), function(v) tras = v end)
CriarBotaoVoo("⬅", UDim2.new(0, 0, 0, 42), function(v) esq = v end)
CriarBotaoVoo("➡", UDim2.new(0, 85, 0, 42), function(v) dir = v end)
CriarBotaoVoo("🔼", UDim2.new(0, 42, 0, 42), function(v) subindo = v end)
CriarBotaoVoo("🔽", UDim2.new(0, 0, 0, 0), function(v) descendo = v end)

-- BOTÃO DE AIM (LADO INFERIOR DIREITO)
local BotaoAim = Instance.new("TextButton")
BotaoAim.Size = UDim2.new(0, 70, 0, 70)
BotaoAim.Position = UDim2.new(0.98, -80, 0.98, -80)
BotaoAim.BackgroundColor3 = Color3.fromRGB(180, 0, 60)
BotaoAim.BackgroundTransparency = 0.3
BotaoAim.Text = "🎯"
BotaoAim.TextSize = 30
BotaoAim.CornerRadius = UDim.new(0, 35)
BotaoAim.Visible = false
BotaoAim.Parent = ScreenGui

-- FUNÇÃO PARA CRIAR BOTÃO DO PAINEL
local function CriarBotao(texto, funcao)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(28, 45, 80)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(0, 160, 240)
    btn.Text = texto
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.CornerRadius = UDim.new(0, 8)
    btn.AutoButtonColor = false
    btn.Parent = ScrollingFrame
    
    btn.MouseButton1Click:Connect(funcao)
    btn.TouchTap:Connect(funcao)
    
    return btn
end

-- ================= FUNÇÕES DOS BOTÕES =============
CriarBotao("✈️ Voar: DESLIGADO", function(btn)
    Config.Voar = not Config.Voar
    btn.Text = Config.Voar and "✈️ Voar: LIGADO ✅" or "✈️ Voar: DESLIGADO"
    btn.BackgroundColor3 = Config.Voar and Color3.fromRGB(0, 100, 60) or Color3.fromRGB(28, 45, 80)
    PainelVoo.Visible = Config.Voar
    BotaoAim.Visible = Config.Voar or Config.AimAtivo
    if Player.Character then
        local hum = Player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = Config.Voar end
    end
end)

CriarBotao("🧱 Atravessar Paredes", function(btn)
    Config.AtravessarParedes = not Config.AtravessarParedes
    btn.Text = Config.AtravessarParedes and "🧱 Atravessar: LIGADO ✅" or "🧱 Atravessar Paredes"
    btn.BackgroundColor3 = Config.AtravessarParedes and Color3.fromRGB(0, 100, 60) or Color3.fromRGB(28, 45, 80)
end)

CriarBotao("🎨 Copiar Skin", function(btn)
    Config.CopiarSkin = not Config.CopiarSkin
    btn.Text = Config.CopiarSkin and "🎨 Toque em alguém! ✅" or "🎨 Copiar Skin"
    btn.BackgroundColor3 = Config.CopiarSkin and Color3.fromRGB(0, 100, 60) or Color3.fromRGB(28, 45, 80)
end)

CriarBotao("🪂 Flutuar", function(btn)
    Config.Flutuar = not Config.Flutuar
    btn.Text = Config.Flutuar and "🪂 Flutuar: LIGADO ✅" or "🪂 Flutuar"
    btn.BackgroundColor3 = Config.Flutuar and Color3.fromRGB(0, 100, 60) or Color3.fromRGB(28, 45, 80)
end)

CriarBotao("🏃 Correr Rápido", function(btn)
    Config.CorrerRapido = not Config.CorrerRapido
    btn.Text = Config.CorrerRapido and "🏃 Rápido: LIGADO ✅" or "🏃 Correr Rápido"
    btn.BackgroundColor3 = Config.CorrerRapido and Color3.fromRGB(0, 100, 60) or Color3.fromRGB(28, 45, 80)
    if Player.Character then
        local hum = Player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = Config.CorrerRapido and Config.SpeedRapido or Config.SpeedPadrao end
    end
end)

CriarBotao("📍 ESP + Box: LIGADO", function(btn)
    Config.ESP_Ativo = not Config.ESP_Ativo
    Config.Box_Ativo = Config.ESP_Ativo
    btn.Text = Config.ESP_Ativo and "📍 ESP + Box: LIGADO ✅" or "📍 ESP + Box: DESLIGADO"
    btn.BackgroundColor3 = Config.ESP_Ativo and Color3.fromRGB(0, 100, 60) or Color3.fromRGB(28, 45, 80)
end)

CriarBotao("🎯 Aimbot: Cabeça", function(btn)
    Config.AimAtivo = not Config.AimAtivo
    Config.AimParte = "Head"
    btn.Text = Config.AimAtivo and "🎯 Aimbot (Cabeça): ON ✅" or "🎯 Aimbot: Cabeça"
    btn.BackgroundColor3 = Config.AimAtivo and Color3.fromRGB(130, 0, 50) or Color3.fromRGB(28, 45, 80)
    BotaoAim.Visible = true
end)

CriarBotao("🎯 Aimbot: Corpo", function(btn)
    Config.AimAtivo = not Config.AimAtivo
    Config.AimParte = "Torso"
    btn.Text = Config.AimAtivo and "🎯 Aimbot (Corpo): ON ✅" or "🎯 Aimbot: Corpo"
    btn.BackgroundColor3 = Config.AimAtivo and Color3.fromRGB(130, 0, 50) or Color3.fromRGB(28, 45, 80)
    BotaoAim.Visible = true
end)

CriarBotao("🎯 Aimbot: Pés", function(btn)
    Config.AimAtivo = not Config.AimAtivo
    Config.AimParte = "LeftFoot"
    btn.Text = Config.AimAtivo and "🎯 Aimbot (Pés): ON ✅" or "🎯 Aimbot: Pés"
    btn.BackgroundColor3 = Config.AimAtivo and Color3.fromRGB(130, 0, 50) or Color3.fromRGB(28, 45, 80)
    BotaoAim.Visible = true
end)

-- ================= ABRIR/FECHAR PAINEL =============
local function TogglePainel()
    Config.PainelVisivel = not Config.PainelVisivel
    Painel.Visible = Config.PainelVisivel
end

BotaoAbrir.TouchTap:Connect(TogglePainel)
BotaoAbrir.MouseButton1Click:Connect(TogglePainel)
Fechar.TouchTap:Connect(function() Painel.Visible = false end)
Fechar.MouseButton1Click:Connect(function() Painel.Visible = false end)

-- ================= SISTEMA DE VOO =============
RunService.RenderStepped:Connect(function()
    local char = Player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end

    -- Atravessar paredes
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = not Config.AtravessarParedes
        end
    end

    -- Flutuar
    if Config.Flutuar then
        hum.GravityScale = 0.08
    else
        hum.GravityScale = 1
    end

    -- Voar
    if Config.Voar then
        hum.GravityScale = 0
        local camCF = workspace.CurrentCamera.CFrame
        local mov = Vector3.new()
        if frente then mov += camCF.LookVector end
        if tras then mov -= camCF.LookVector end
        if esq then mov -= camCF.RightVector end
        if dir then mov += camCF.RightVector end
        if subindo then mov += Vector3.new(0,1,0) end
        if descendo then mov -= Vector3.new(0,1,0) end
        root.Velocity = mov * voarVelocidade
    end
end)

-- ================= COPIAR SKIN (TOQUE) =============
UserInputService.TouchTap:Connect(function(pos)
    if Config.CopiarSkin then
        local ray = workspace.CurrentCamera:ScreenPointToRay(pos.X, pos.Y)
        local alvo, ponto = workspace:Raycast(ray.Origin, ray.Direction * 200)
        if alvo then
            local jogadorAlvo = game.Players:GetPlayerFromCharacter(alvo.Parent)
            if jogadorAlvo and jogadorAlvo ~= Player and jogadorAlvo.Character then
                for _, part in pairs(Player.Character:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        local alvoPart = jogadorAlvo.Character:FindFirstChild(part.Name)
                        if alvoPart then
                            part.BrickColor = alvoPart.BrickColor
                            part.Material = alvoPart.Material
                            part.Transparency = alvoPart.Transparency
                        end
                    end
                end
                Config.CopiarSkin = false
            end
        end
    end
end)

-- ================= AIMBOT (BOTÃO TOQUE) =============
local function ExecutarAim()
    if not Config.AimAtivo then return end
    local char = Player.Character
    if not char then return end
    
    local alvoMaisProximo, distProx = nil, math.huge
    local cam = workspace.CurrentCamera
    
    for _, jogador in pairs(game.Players:GetPlayers()) do
        if jogador ~= Player and jogador.Character and jogador.Character:FindFirstChild(Config.AimParte) then
            local parte = jogador.Character[Config.AimParte]
            local scrPos, vis = cam:WorldToViewportPoint(parte.Position)
            if vis then
                local dist = (Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2) - Vector2.new(scrPos.X, scrPos.Y)).Magnitude
                if dist < distProx and dist < 300 then
                    distProx = dist
                    alvoMaisProximo = parte
                end
            end
        end
    end
    
    if alvoMaisProximo then
        local novoCF = CFrame.new(cam.CFrame.Position, alvoMaisProximo.Position)
        TweenService:Create(cam, TweenInfo.new(Config.AimSmooth), {CFrame = novoCF}):Play()
    end
end

BotaoAim.TouchStarted:Connect(ExecutarAim)
BotaoAim.MouseButton1Down:Connect(ExecutarAim)

-- ================= ESP E BOX =============
RunService.RenderStepped:Connect(function()
    for _, jogador in pairs(game.Players:GetPlayers()) do
        if jogador ~= Player and jogador.Character and jogador.Character:FindFirstChild("HumanoidRootPart") then
            local root = jogador.Character.HumanoidRootPart
            
            if not ESP[jogador] then
                ESP[jogador] = {
                    Box = Drawing.new("Square"),
                    Nome = Drawing.new("Text")
                }
                ESP[jogador].Box.Thickness = 2
                ESP[jogador].Box.Filled = false
                ESP[jogador].Box.Color = Color3.new(1, 0.2, 0.2)
                ESP[jogador].Nome.Center = true
                ESP[jogador].Nome.Color = Color3.new(1,1,1)
                ESP[jogador].Nome.Font = 2
                ESP[jogador].Nome.Size = 12
            end
            
            local cam = workspace.CurrentCamera
            local pos, vis = cam:WorldToViewportPoint(root.Position)
            
            if vis and Config.Box_Ativo then
                local tam = Vector2.new(1100 / pos.Z, 2200 / pos.Z)
                ESP[jogador].Box.Position = Vector2.new(pos.X - tam.X/2, pos.Y - tam.Y/2)
                ESP[jogador].Box.Size = tam
                ESP[jogador].Box.Visible = true
                ESP[jogador].Nome.Text = jogador.Name .. " | " .. math.floor(jogador.Character.Humanoid.Health) .. "HP"
                ESP[jogador].Nome.Position = Vector2.new(pos.X, pos.Y - tam.Y/2 - 18)
                ESP[jogador].Nome.Visible = Config.ESP_Ativo
            else
                ESP[jogador].Box.Visible = false
                ESP[jogador].Nome.Visible = false
            end
        elseif ESP[jogador] then
            ESP[jogador].Box.Visible = false
            ESP[jogador].Nome.Visible = false
        end
    end
end)

print("[📱 PAINEL MOBILE] Carregado! Toque na engrenagem ⚙️ para abrir")
