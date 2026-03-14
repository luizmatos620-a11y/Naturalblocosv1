--[[
MOD MENU COMPLETO PARA DELTA MOBILE
Interface touch-friendly com várias funções
--]]

-- Serviços necessários
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Jogador local
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- ==========================================
-- CRIAÇÃO DA INTERFACE GRÁFICA (GUI)
-- ==========================================

-- Criar a tela principal (ScreenGui)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModMenu"
ScreenGui.ResetOnSpawn = false  -- Não desaparece quando o jogador renasce
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Criar o frame principal do menu (fundo)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 350)  -- 250x350 pixels
MainFrame.Position = UDim2.new(0.5, -125, 0.3, 0)  -- Centralizado
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true  -- Importante: permite arrastar o menu com o dedo
MainFrame.Parent = ScreenGui

-- Borda arredondada (opcional, mas fica bonito)
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Título do menu
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TitleLabel.Text = "🔥 MOD MENU DELTA"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.BorderSizePixel = 0
TitleLabel.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleLabel

-- Frame para organizar os botões (com scroll)
local ButtonContainer = Instance.new("ScrollingFrame")
ButtonContainer.Size = UDim2.new(1, 0, 1, -50)
ButtonContainer.Position = UDim2.new(0, 0, 0, 50)
ButtonContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.BorderSizePixel = 0
ButtonContainer.CanvasSize = UDim2.new(0, 0, 0, 0)  -- Vai aumentar conforme adicionamos botões
ButtonContainer.ScrollBarThickness = 4
ButtonContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 255)
ButtonContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
ButtonContainer.Parent = MainFrame

-- ==========================================
-- FUNÇÕES DE UTILIDADE
-- ==========================================

-- Função para criar botões bonitos
local function createButton(text, color, callback)
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Size = UDim2.new(1, -20, 0, 45)
    ButtonFrame.Position = UDim2.new(0, 10, 0, 0)
    ButtonFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ButtonFrame.BorderSizePixel = 0
    ButtonFrame.Parent = ButtonContainer
    
    -- Reorganizar posições automaticamente
    ButtonFrame.LayoutOrder = #ButtonContainer:GetChildren()
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = ButtonFrame
    
    local ButtonText = Instance.new("TextLabel")
    ButtonText.Size = UDim2.new(1, 0, 1, 0)
    ButtonText.BackgroundTransparency = 1
    ButtonText.Text = text
    ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
    ButtonText.TextScaled = true
    ButtonText.Font = Enum.Font.Gotham
    ButtonText.Parent = ButtonFrame
    
    -- Botão invisível para detectar toques
    local TouchButton = Instance.new("TextButton")
    TouchButton.Size = UDim2.new(1, 0, 1, 0)
    TouchButton.BackgroundTransparency = 1
    TouchButton.Text = ""
    TouchButton.Parent = ButtonFrame
    
    -- Efeito de feedback visual ao tocar
    TouchButton.MouseButton1Down:Connect(function()
        ButtonFrame.BackgroundColor3 = color
        TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
        callback()
    end)
    
    return ButtonFrame
end

-- Função para criar checkboxes (botões de liga/desliga)
local function createToggle(text, defaultValue, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -20, 0, 45)
    ToggleFrame.Position = UDim2.new(0, 10, 0, 0)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = ButtonContainer
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleFrame
    
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(0.7, 0, 1, 0)
    TextLabel.Position = UDim2.new(0, 10, 0, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = text
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextScaled = true
    TextLabel.Font = Enum.Font.Gotham
    TextLabel.Parent = ToggleFrame
    
    local ToggleIndicator = Instance.new("Frame")
    ToggleIndicator.Size = UDim2.new(0, 50, 0, 30)
    ToggleIndicator.Position = UDim2.new(1, -60, 0.5, -15)
    ToggleIndicator.BackgroundColor3 = defaultValue and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    ToggleIndicator.BorderSizePixel = 0
    ToggleIndicator.Parent = ToggleFrame
    
    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(0, 15)
    IndicatorCorner.Parent = ToggleIndicator
    
    local TouchButton = Instance.new("TextButton")
    TouchButton.Size = UDim2.new(1, 0, 1, 0)
    TouchButton.BackgroundTransparency = 1
    TouchButton.Text = ""
    TouchButton.Parent = ToggleFrame
    
    local isEnabled = defaultValue
    
    TouchButton.MouseButton1Down:Connect(function()
        isEnabled = not isEnabled
        TweenService:Create(ToggleIndicator, TweenInfo.new(0.2), {BackgroundColor3 = isEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)}):Play()
        callback(isEnabled)
    end)
    
    return ToggleFrame
end

-- ==========================================
-- FUNÇÕES DO MENU (as trapaças)
-- ==========================================

-- Variáveis de controle
local flyEnabled = false
local speedEnabled = false
local espEnabled = false
local flyConnection = nil
local speedConnection = nil
local espConnection = nil

-- Função de voo (adaptada para mobile)
local function toggleFly(state)
    flyEnabled = state
    if flyConnection then flyConnection:Disconnect() end
    
    if flyEnabled then
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoid = character:FindFirstChild("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        
        if humanoid and rootPart then
            humanoid.PlatformStand = true
            humanoid.WalkSpeed = 0
            
            flyConnection = RunService.Heartbeat:Connect(function()
                if not flyEnabled or not character or not character.Parent then
                    flyEnabled = false
                    return
                end
                
                -- Controle de voo mobile: baseado na câmera
                local camera = workspace.CurrentCamera
                local moveVector = Vector3.new(0, 0, 0)
                
                -- Simples: apenas sobe/desce com botões virtuais
                -- (em um menu real, você adicionaria botões de direção)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveVector = moveVector + camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveVector = moveVector - camera.CFrame.LookVector
                end
                
                rootPart.CFrame = rootPart.CFrame + moveVector * 0.5
            end)
        end
    else
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
                humanoid.WalkSpeed = 16
            end
        end
    end
end

-- Função de super velocidade
local function toggleSpeed(state)
    speedEnabled = state
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = state and 100 or 16
    end
end

-- Função ESP simples (destacar jogadores)
local function toggleESP(state)
    espEnabled = state
    
    if espConnection then espConnection:Disconnect() end
    
    if espEnabled then
        espConnection = RunService.Heartbeat:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local character = player.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            -- Criar um highlight se não existir
                            if not rootPart:FindFirstChild("ESP_Highlight") then
                                local highlight = Instance.new("Highlight")
                                highlight.Name = "ESP_Highlight"
                                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                                highlight.FillTransparency = 0.5
                                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                                highlight.Parent = rootPart
                            end
                        end
                    end
                end
            end
        end)
    else
        -- Remover todos os destaques
        for _, player in pairs(Players:GetPlayers()) do
            local character = player.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local highlight = rootPart:FindFirstChild("ESP_Highlight")
                    if highlight then
                        highlight:Destroy()
                    end
                end
            end
        end
    end
end

-- ==========================================
-- CONSTRUINDO O MENU (adicionando botões)
-- ==========================================

-- Título da seção
local function addSection(title)
    local SectionLabel = Instance.new("TextLabel")
    SectionLabel.Size = UDim2.new(1, -20, 0, 30)
    SectionLabel.Position = UDim2.new(0, 10, 0, 0)
    SectionLabel.BackgroundTransparency = 1
    SectionLabel.Text = title
    SectionLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    SectionLabel.TextScaled = true
    SectionLabel.Font = Enum.Font.GothamBold
    SectionLabel.Parent = ButtonContainer
end

-- Adicionar seções e botões
addSection("🚀 MOVIMENTO")
createToggle("Voo", false, toggleFly)
createToggle("Super Velocidade", false, toggleSpeed)

addSection("👁️ VISÃO")
createToggle("ESP (Wallhack)", false, toggleESP)

addSection("⚡ AÇÕES")
createButton("Teleporte para o Spawn", Color3.fromRGB(255, 200, 0), function()
    local spawnLocation = workspace:FindFirstChild("SpawnLocation")
    if spawnLocation and LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.CFrame = spawnLocation.CFrame
        end
    end
end)

createButton("Resetar Personagem", Color3.fromRGB(255, 100, 100), function()
    LocalPlayer.Character:BreakJoints()
end)

-- Botão para fechar o menu (opcional)
createButton("❌ Fechar Menu", Color3.fromRGB(255, 50, 50), function()
    ScreenGui:Destroy()
end)

-- Ajustar o layout automático
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Parent = ButtonContainer

-- ==========================================
-- FINALIZAÇÃO
-- ==========================================

print("✅ Mod Menu carregado com sucesso! Arraste o menu para mover.")
