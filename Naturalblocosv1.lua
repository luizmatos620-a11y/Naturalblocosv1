-- LUIZPHONE V2 - IPHONE 15 PRO MAX COM TECLADO NUMÉRICO (FIXED)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Destrói qualquer GUI anterior do LuizPhone para evitar conflitos
if PlayerGui:FindFirstChild("LuizPhone") then
    PlayerGui.LuizPhone:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LuizPhone"
ScreenGui.Parent = PlayerGui

-- --- FRAME PRINCIPAL DO CELULAR ---
local PhoneFrame = Instance.new("Frame")
PhoneFrame.Name = "PhoneFrame"
PhoneFrame.Parent = ScreenGui
PhoneFrame.AnchorPoint = Vector2.new(0.5, 0.5)
PhoneFrame.Position = UDim2.new(0.5, 0, 0.5, 0) -- Centralizado
PhoneFrame.Size = UDim2.new(0, 280, 0, 580) -- Tamanho mais realista
PhoneFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Borda preta
PhoneFrame.ClipsDescendants = true -- Corta o que estiver fora da borda
PhoneFrame.Draggable = true -- Pode arrastar o celular
PhoneFrame.ZIndex = 100 -- Fica por cima de tudo

local PhoneCorner = Instance.new("UICorner")
PhoneCorner.CornerRadius = UDim.new(0, 45) -- Bordas arredondadas do iPhone
PhoneCorner.Parent = PhoneFrame

local ScreenHolder = Instance.new("Frame") -- Onde o wallpaper e apps ficam
ScreenHolder.Name = "ScreenHolder"
ScreenHolder.Parent = PhoneFrame
ScreenHolder.Position = UDim2.new(0.02, 0, 0.02, 0)
ScreenHolder.Size = UDim2.new(0.96, 0, 0.96, 0)
ScreenHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScreenHolder.ClipsDescendants = true

local ScreenHolderCorner = Instance.new("UICorner")
ScreenHolderCorner.CornerRadius = UDim.new(0, 38)
ScreenHolderCorner.Parent = ScreenHolder

local Wallpaper = Instance.new("ImageLabel")
Wallpaper.Name = "Wallpaper"
Wallpaper.Parent = ScreenHolder
Wallpaper.Size = UDim2.new(1, 0, 1, 0)
Wallpaper.Image = "rbxassetid://13192011036" -- ID de Wallpaper iOS
Wallpaper.ScaleType = Enum.ScaleType.Fill
Wallpaper.ZIndex = 1

-- --- ILHA DINÂMICA ---
local DynamicIsland = Instance.new("Frame")
DynamicIsland.Name = "DynamicIsland"
DynamicIsland.Parent = Wallpaper
DynamicIsland.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
DynamicIsland.Size = UDim2.new(0, 100, 0, 25)
DynamicIsland.Position = UDim2.new(0.5, -50, 0.02, 0)
DynamicIsland.ZIndex = 5
local IslandCorner = Instance.new("UICorner")
IslandCorner.CornerRadius = UDim.new(1, 0)
IslandCorner.Parent = DynamicIsland

-- --- TELA DE BLOQUEIO ---
local LockScreen = Instance.new("Frame")
LockScreen.Name = "LockScreen"
LockScreen.Parent = ScreenHolder
LockScreen.Size = UDim2.new(1, 0, 1, 0)
LockScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LockScreen.BackgroundTransparency = 0.5 -- Efeito de blur leve no wallpaper
LockScreen.ZIndex = 2

local ClockLabel = Instance.new("TextLabel")
ClockLabel.Name = "Clock"
ClockLabel.Parent = LockScreen
ClockLabel.Text = os.date("%H:%M")
ClockLabel.Size = UDim2.new(1, 0, 0.15, 0)
ClockLabel.Position = UDim2.new(0, 0, 0.15, 0)
ClockLabel.BackgroundTransparency = 1
ClockLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ClockLabel.Font = Enum.Font.GothamBold
ClockLabel.TextSize = 65
ClockLabel.ZIndex = 3

local DateLabel = Instance.new("TextLabel")
DateLabel.Name = "Date"
DateLabel.Parent = LockScreen
DateLabel.Text = os.date("%a, %d %b")
DateLabel.Size = UDim2.new(1, 0, 0.05, 0)
DateLabel.Position = UDim2.new(0, 0, 0.3, 0)
DateLabel.BackgroundTransparency = 1
DateLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
DateLabel.Font = Enum.Font.GothamMedium
DateLabel.TextSize = 20
DateLabel.ZIndex = 3

local PasscodeDisplay = Instance.new("TextBox")
PasscodeDisplay.Name = "PasscodeDisplay"
PasscodeDisplay.Parent = LockScreen
PasscodeDisplay.Size = UDim2.new(0.8, 0, 0.06, 0)
PasscodeDisplay.Position = UDim2.new(0.1, 0, 0.4, 0)
PasscodeDisplay.Text = ""
PasscodeDisplay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PasscodeDisplay.BackgroundTransparency = 0.8
PasscodeDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
PasscodeDisplay.TextSize = 24
PasscodeDisplay.Font = Enum.Font.SourceSansBold
PasscodeDisplay.TextXAlignment = Enum.TextXAlignment.Center
PasscodeDisplay.ClearTextOnFocus = false
PasscodeDisplay.ZIndex = 3
PasscodeDisplay.Visible = false -- Fica invisível até ser clicado

-- --- TECLADO NUMÉRICO ---
local KeyboardFrame = Instance.new("Frame")
KeyboardFrame.Name = "Keyboard"
KeyboardFrame.Parent = LockScreen
KeyboardFrame.Size = UDim2.new(0.9, 0, 0.45, 0)
KeyboardFrame.Position = UDim2.new(0.05, 0, 0.5, 0)
KeyboardFrame.BackgroundTransparency = 1
KeyboardFrame.ZIndex = 3

local KeyboardLayout = Instance.new("UIGridLayout")
KeyboardLayout.Parent = KeyboardFrame
KeyboardLayout.CellPadding = UDim2.new(0, 10, 0, 10)
KeyboardLayout.CellSize = UDim2.new(0.3, 0, 0.25, 0)
KeyboardLayout.FillDirection = Enum.FillDirection.Horizontal
KeyboardLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
KeyboardLayout.VerticalAlignment = Enum.VerticalAlignment.Center

local currentPasscode = ""
local correctPasscode = "Luizmenu2026"

local function createKeyButton(text, isDelete)
    local Button = Instance.new("TextButton")
    Button.Parent = KeyboardFrame
    Button.Size = UDim2.new(0.3, 0, 0.25, 0)
    Button.Text = text
    Button.Font = Enum.Font.GothamMedium
    Button.TextSize = 30
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.BackgroundTransparency = 0.6
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Cor dos botões do teclado
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(1, 0) -- Botões redondos
    ButtonCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        if isDelete then
            currentPasscode = currentPasscode:sub(1, #currentPasscode - 1)
        else
            currentPasscode = currentPasscode .. text
        end
        PasscodeDisplay.Text = string.rep("*", #currentPasscode) -- Mostra asteriscos
        
        if #currentPasscode == #correctPasscode then
            if currentPasscode == correctPasscode then
                LockScreen:TweenPosition(UDim2.new(0, 0, -1, 0), "Out", "Quad", 0.5, true)
                task.wait(0.5)
                LockScreen.Visible = false
                game:GetService("StarterGui"):SetCore("SendNotification", {Title = "LuizPhone", Text = "Bem-vindo, Luiz!", Duration = 3})
            else
                PasscodeDisplay.Text = "INCORRETO"
                currentPasscode = ""
                task.wait(1)
                PasscodeDisplay.Text = ""
            end
        end
    end)
end

-- Cria os botões do teclado
for i = 1, 9 do createKeyButton(tostring(i), false) end
createKeyButton("", false) -- Espaço vazio
createKeyButton("0", false)
createKeyButton("⌫", true) -- Botão de apagar (BackSpace)

-- --- HOME SCREEN (APLICATIVOS) ---
local HomeScreen = Instance.new("ScrollingFrame")
HomeScreen.Name = "HomeScreen"
HomeScreen.Parent = ScreenHolder
HomeScreen.Size = UDim2.new(1, 0, 1, 0)
HomeScreen.BackgroundTransparency = 1
HomeScreen.ZIndex = 1 -- Fica abaixo do LockScreen
HomeScreen.Visible = false -- Começa invisível

local AppLayout = Instance.new("UIGridLayout")
AppLayout.Parent = HomeScreen
AppLayout.CellPadding = UDim2.new(0, 15, 0, 20)
AppLayout.CellSize = UDim2.new(0, 50, 0, 50)
AppLayout.StartCorner = Enum.StartCorner.TopLeft
AppLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
AppLayout.Position = UDim2.new(0, 0, 0.1, 0)

-- Função para criar um ícone de App
local function CreateApp(name, iconID, callback)
    local AppButton = Instance.new("ImageButton")
    AppButton.Name = name
    AppButton.Parent = HomeScreen
    AppButton.Image = "rbxassetid://" .. iconID
    AppButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    AppButton.BackgroundTransparency = 0.2 -- Efeito de vidro no ícone
    
    local AppCorner = Instance.new("UICorner")
    AppCorner.CornerRadius = UDim.new(0, 12)
    AppCorner.Parent = AppButton
    
    local AppLabel = Instance.new("TextLabel")
    AppLabel.Parent = AppButton
    AppLabel.Text = name
    AppLabel.Size = UDim2.new(1, 0, 0.3, 0)
    AppLabel.Position = UDim2.new(0, 0, 1, 2)
    AppLabel.BackgroundTransparency = 1
    AppLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    AppLabel.TextSize = 10
    AppLabel.Font = Enum.Font.Gotham
    
    AppButton.MouseButton1Click:Connect(callback)
    return AppButton
end

-- --- SEUS APLICATIVOS (COM ÍCONES NOVOS) ---
-- (Os IDs de ícones abaixo são exemplos, você pode encontrar outros no Roblox Studio!)

CreateApp("Destroços", "13110300684", function() -- Ícone de casa destruindo
    print("Iniciando App Natural Disaster...")
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "LuizPhone", Text = "App Destroços Aberto!"})
end)

CreateApp("Animações", "13110300684", function() -- Ícone de boneco dançando
     print("Abrindo Emotes...")
end)

CreateApp("Fling", "13110300684", function() -- Ícone de explosão/foguete
    _G.GhostFling = not _G.GhostFling
    local status = _G.GhostFling and "Ligado" or "Desligado"
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "LuizPhone", Text = "Fling Fantasma: " .. status})
end)

CreateApp("Tycon", "13110300684", function() -- Ícone de dinheiro
    print("Abrindo Tycon God...")
end)

-- --- BOTÃO HOME (PARA FECHAR/ABRIR O CELULAR) ---
local HomeBar = Instance.new("Frame")
HomeBar.Name = "HomeBar"
HomeBar.Parent = ScreenHolder
HomeBar.Size = UDim2.new(0.4, 0, 0, 5)
HomeBar.Position = UDim2.new(0.3, 0, 0.95, 0)
HomeBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
HomeBar.BackgroundTransparency = 0.5 -- Estilo iOS
local HomeBarCorner = Instance.new("UICorner")
HomeBarCorner.CornerRadius = UDim.new(1, 0)
HomeBarCorner.Parent = HomeBar

local CellVisibility = true -- Variável para controlar se o celular está visível ou não

-- Botão para esconder/mostrar o celular
local HideButton = Instance.new("TextButton")
HideButton.Parent = ScreenGui
HideButton.Size = UDim2.new(0, 50, 0, 50)
HideButton.Position = UDim2.new(1, -60, 0, 10) -- Canto superior direito da tela
HideButton.Text = "📱" -- Ícone de celular
HideButton.Font = Enum.Font.SourceSansBold
HideButton.TextSize = 30
HideButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
HideButton.BackgroundTransparency = 0.5
local HideButtonCorner = Instance.new("UICorner")
HideButtonCorner.CornerRadius = UDim.new(1,0)
HideButtonCorner.Parent = HideButton

HideButton.MouseButton1Click:Connect(function()
    CellVisibility = not CellVisibility
    PhoneFrame:TweenSizeAndPosition(
        CellVisibility and UDim2.new(0, 280, 0, 580) or UDim2.new(0, 0, 0, 0), -- Se visível, tamanho normal; se não, tamanho 0
        CellVisibility and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(1, 0, 0, 0), -- Posição de origem para esconder
        "Out", "Quad", 0.5, true -- Animação
    )
    HideButton.Text = CellVisibility and "📱" or "📲" -- Muda o ícone
end)

-- Inicia mostrando a tela de bloqueio
LockScreen.Visible = true
HomeScreen.Visible = false -- Esconde a Home Screen no início
PasscodeDisplay.Visible = true -- Garante que o display da senha esteja visível

-- Atualiza a hora e data a cada minuto
task.spawn(function()
    while true do
        ClockLabel.Text = os.date("%H:%M")
        DateLabel.Text = os.date("%a, %d %b")
        task.wait(60)
    end
end)
