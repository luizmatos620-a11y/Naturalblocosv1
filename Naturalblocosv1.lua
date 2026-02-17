-- LUIZPHONE V1 - O IPHONE DO EXPLOIT
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Screen = Instance.new("ImageLabel") -- Papel de parede

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "LuizPhone"

-- --- ESTRUTURA DO CELULAR ---
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.75, 0, 0.2, 0) -- Posição lateral
MainFrame.Size = UDim2.new(0, 250, 0, 500)
MainFrame.Active = true
MainFrame.Draggable = true -- Você pode arrastar o celular pela tela

UICorner.CornerRadius = UDim.new(0, 40)
UICorner.Parent = MainFrame

-- Wallpaper (Estilo iOS 17)
Screen.Name = "Screen"
Screen.Parent = MainFrame
Screen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Screen.Position = UDim2.new(0.03, 0, 0.02, 0)
Screen.Size = UDim2.new(0.94, 0, 0.96, 0)
Screen.Image = "rbxassetid://13192011036" -- ID de um wallpaper de iPhone
Screen.ScaleType = Enum.ScaleType.Crop

local ScreenCorner = Instance.new("UICorner")
ScreenCorner.CornerRadius = UDim.new(0, 35)
ScreenCorner.Parent = Screen

-- --- TELA DE BLOQUEIO (KEY SYSTEM) ---
local LockScreen = Instance.new("Frame")
LockScreen.Name = "LockScreen"
LockScreen.Parent = Screen
LockScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LockScreen.BackgroundTransparency = 0.4
LockScreen.Size = UDim2.new(1, 0, 1, 0)
LockScreen.ZIndex = 5

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Parent = LockScreen
TimeLabel.Text = os.date("%H:%M")
TimeLabel.Size = UDim2.new(1, 0, 0.2, 0)
TimeLabel.Position = UDim2.new(0, 0, 0.1, 0)
TimeLabel.BackgroundTransparency = 1
TimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TimeLabel.Font = Enum.Font.SourceSansLight
TimeLabel.TextSize = 60

local PassCodeBox = Instance.new("TextBox")
PassCodeBox.Parent = LockScreen
PassCodeBox.Size = UDim2.new(0.8, 0, 0.08, 0)
PassCodeBox.Position = UDim2.new(0.1, 0, 0.5, 0)
PassCodeBox.PlaceholderText = "Digite a Senha"
PassCodeBox.Text = ""
PassCodeBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PassCodeBox.BackgroundTransparency = 0.8
PassCodeBox.TextColor3 = Color3.fromRGB(255, 255, 255)

local UnlockBtn = Instance.new("TextButton")
UnlockBtn.Parent = LockScreen
UnlockBtn.Size = UDim2.new(0.5, 0, 0.08, 0)
UnlockBtn.Position = UDim2.new(0.25, 0, 0.6, 0)
UnlockBtn.Text = "Desbloquear"
UnlockBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)

UnlockBtn.MouseButton1Click:Connect(function()
    if PassCodeBox.Text == "Luizmenu2026" then
        LockScreen:TweenPosition(UDim2.new(0, 0, -1, 0), "Out", "Quart", 0.5)
        wait(0.5)
        LockScreen.Visible = false
    else
        PassCodeBox.Text = ""
        PassCodeBox.PlaceholderText = "SENHA INCORRETA!"
        wait(1)
        PassCodeBox.PlaceholderText = "Digite a Senha"
    end
end)

-- --- TELA INICIAL (APPS) ---
local HomeScreen = Instance.new("ScrollingFrame")
HomeScreen.Parent = Screen
HomeScreen.Size = UDim2.new(1, 0, 0.9, 0)
HomeScreen.Position = UDim2.new(0, 0, 0.05, 0)
HomeScreen.BackgroundTransparency = 1
HomeScreen.ScrollBarTransparency = 1

local Layout = Instance.new("UIGridLayout")
Layout.Parent = HomeScreen
Layout.CellPadding = UDim2.new(0, 15, 0, 20)
Layout.CellSize = UDim2.new(0, 50, 0, 50)
Layout.StartCorner = Enum.StartCorner.TopLeft
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Função para Criar um "App"
local function CreateApp(name, iconID, callback)
    local App = Instance.new("ImageButton")
    App.Name = name
    App.Parent = HomeScreen
    App.Image = "rbxassetid://" .. iconID
    App.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    
    local AppCorner = Instance.new("UICorner")
    AppCorner.CornerRadius = UDim.new(0, 12)
    AppCorner.Parent = App
    
    local AppLabel = Instance.new("TextLabel")
    AppLabel.Parent = App
    AppLabel.Text = name
    AppLabel.Size = UDim2.new(1, 0, 0.3, 0)
    AppLabel.Position = UDim2.new(0, 0, 1, 2)
    AppLabel.BackgroundTransparency = 1
    AppLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    AppLabel.TextSize = 10
    
    App.MouseButton1Click:Connect(callback)
end

-- --- MEUS APPS (FUNÇÕES) ---

-- App de Desastres Naturais
CreateApp("Natural", "13110298377", function()
    -- Aqui você cola o código do seu menu de desastres
    print("Iniciando App Natural Disaster...")
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "LuizPhone", Text = "App Natural Disaster Aberto!"})
end)

-- App de Emotes
CreateApp("Emotes", "13110298377", function()
     print("Abrindo Emotes...")
end)

-- App de Fling (Aba Bypass)
CreateApp("Fling", "13110298377", function()
    _G.GhostFling = not _G.GhostFling
    local status = _G.GhostFling and "Ligado" or "Desligado"
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "iPhone Fling", Text = "Fling Fantasma: " .. status})
end)

-- Ilha Dinâmica (Dynamic Island)
local Island = Instance.new("Frame")
Island.Name = "DynamicIsland"
Island.Parent = Screen
Island.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Island.Size = UDim2.new(0, 80, 0, 20)
Island.Position = UDim2.new(0.5, -40, 0.03, 0)
local IslandCorner = Instance.new("UICorner")
IslandCorner.CornerRadius = UDim.new(1, 0)
IslandCorner.Parent = Island
