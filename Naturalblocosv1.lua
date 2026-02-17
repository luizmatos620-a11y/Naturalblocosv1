-- LUIZPHONE V3 PREMIUM - IPHONE 15 PRO MAX EDITION
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local pgui = lp:WaitForChild("PlayerGui")

-- Limpeza de versões antigas
if pgui:FindFirstChild("LuizPhone") then pgui.LuizPhone:Destroy() end

local LuizPhone = Instance.new("ScreenGui")
LuizPhone.Name = "LuizPhone"
LuizPhone.Parent = pgui
LuizPhone.ResetOnSpawn = false

-- --- CHASSIS DO IPHONE ---
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = LuizPhone
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 540)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 22) -- Titânio Negro
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 45)
MainCorner.Parent = MainFrame

-- Brilho da Borda (Efeito Premium)
local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 3
Stroke.Color = Color3.fromRGB(60, 60, 65)
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Stroke.Parent = MainFrame

-- --- TELA INTERNA ---
local Screen = Instance.new("ImageLabel")
Screen.Name = "Screen"
Screen.Parent = MainFrame
Screen.Position = UDim2.new(0.03, 0, 0.015, 0)
Screen.Size = UDim2.new(0.94, 0, 0.97, 0)
Screen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Screen.Image = "rbxassetid://13192011036" -- Wallpaper iOS 17
Screen.ScaleType = Enum.ScaleType.Fill
Screen.ClipsDescendants = true

local ScreenCorner = Instance.new("UICorner")
ScreenCorner.CornerRadius = UDim.new(0, 38)
ScreenCorner.Parent = Screen

-- --- ILHA DINÂMICA (DYNAMIC ISLAND) ---
local Island = Instance.new("Frame")
Island.Name = "DynamicIsland"
Island.Parent = Screen
Island.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Island.Size = UDim2.new(0, 85, 0, 22)
Island.Position = UDim2.new(0.5, -42, 0.02, 0)
Island.ZIndex = 10

local IslandCorner = Instance.new("UICorner")
IslandCorner.CornerRadius = UDim.new(1, 0)
IslandCorner.Parent = Island

-- --- TELA DE BLOQUEIO (KEY SYSTEM) ---
local LockScreen = Instance.new("Frame")
LockScreen.Name = "LockScreen"
LockScreen.Parent = Screen
LockScreen.Size = UDim2.new(1, 0, 1, 0)
LockScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LockScreen.BackgroundTransparency = 0.3
LockScreen.ZIndex = 5

-- Relógio e Data
local TimeLabel = Instance.new("TextLabel")
TimeLabel.Parent = LockScreen
TimeLabel.Text = os.date("%H:%M")
TimeLabel.Size = UDim2.new(1, 0, 0.2, 0)
TimeLabel.Position = UDim2.new(0, 0, 0.1, 0)
TimeLabel.BackgroundTransparency = 1
TimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TimeLabel.Font = Enum.Font.GothamBold
TimeLabel.TextSize = 55

-- Teclado Numérico do iPhone
local Keypad = Instance.new("Frame")
Keypad.Parent = LockScreen
Keypad.Size = UDim2.new(0.9, 0, 0.5, 0)
Keypad.Position = UDim2.new(0.05, 0, 0.45, 0)
Keypad.BackgroundTransparency = 1

local Grid = Instance.new("UIGridLayout")
Grid.Parent = Keypad
Grid.CellPadding = UDim2.new(0, 10, 0, 10)
Grid.CellSize = UDim2.new(0, 60, 0, 60)
Grid.HorizontalAlignment = Enum.HorizontalAlignment.Center

local currentKey = ""
local pass = "Luizmenu2026"

local function createKey(num)
    local btn = Instance.new("TextButton")
    btn.Parent = Keypad
    btn.Text = num
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 24
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundTransparency = 0.8
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1, 0)
    c.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        currentKey = currentKey .. num
        if currentKey == pass then
            LockScreen:TweenPosition(UDim2.new(0, 0, -1, 0), "Out", "Quart", 0.5)
            task.wait(0.6)
            LockScreen.Visible = false
        elseif #currentKey >= #pass then
            currentKey = ""
            TimeLabel.Text = "ERRO"
            task.wait(1)
            TimeLabel.Text = os.date("%H:%M")
        end
    end)
end

-- Gerar números 1-9, 0
for i = 1, 9 do createKey(tostring(i)) end
createKey("0")

-- --- TELA INICIAL (APPS) ---
local HomeScreen = Instance.new("ScrollingFrame")
HomeScreen.Name = "HomeScreen"
HomeScreen.Parent = Screen
HomeScreen.Size = UDim2.new(1, 0, 1, 0)
HomeScreen.BackgroundTransparency = 1
HomeScreen.ScrollBarTransparency = 1
HomeScreen.Visible = true

local AppGrid = Instance.new("UIGridLayout")
AppGrid.Parent = HomeScreen
AppGrid.CellPadding = UDim2.new(0, 20, 0, 25)
AppGrid.CellSize = UDim2.new(0, 50, 0, 50)
AppGrid.Position = UDim2.new(0, 0, 0.1, 0)
AppGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function AddApp(name, icon, code)
    local app = Instance.new("ImageButton")
    app.Parent = HomeScreen
    app.Image = "rbxassetid://" .. icon
    app.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 12)
    c.Parent = app
    
    local label = Instance.new("TextLabel")
    label.Parent = app
    label.Text = name
    label.Position = UDim2.new(0, 0, 1, 5)
    label.Size = UDim2.new(1, 0, 0, 15)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 10
    
    app.MouseButton1Click:Connect(code)
end

-- SEUS APPS (Configure as funções aqui)
AddApp("Natural", "13110300684", function() print("App Natural Disaster") end)
AddApp("Emotes", "13110298377", function() print("App Emotes") end)
AddApp("Fling", "13110300684", function() print("App Fling") end)

-- --- BARRA HOME (MINIMIZAR) ---
local HomeBar = Instance.new("Frame")
HomeBar.Parent = Screen
HomeBar.Size = UDim2.new(0.4, 0, 0, 5)
HomeBar.Position = UDim2.new(0.3, 0, 0.96, 0)
HomeBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
HomeBar.ZIndex = 15
Instance.new("UICorner", HomeBar).CornerRadius = UDim.new(1,0)

-- Botão Flutuante para reabrir
local Reopen = Instance.new("TextButton")
Reopen.Parent = LuizPhone
Reopen.Size = UDim2.new(0, 50, 0, 50)
Reopen.Position = UDim2.new(0, 10, 0.5, 0)
Reopen.Text = "🍎"
Reopen.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Reopen.TextColor3 = Color3.fromRGB(255, 255, 255)
Reopen.Visible = false
Instance.new("UICorner", Reopen).CornerRadius = UDim.new(1,0)

Reopen.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    Reopen.Visible = false
end)

-- Fechar ao clicar na HomeBar
local closeTrigger = Instance.new("TextButton")
closeTrigger.Parent = HomeBar
closeTrigger.Size = UDim2.new(1, 0, 1, 0)
closeTrigger.BackgroundTransparency = 1
closeTrigger.Text = ""
closeTrigger.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    Reopen.Visible = true
end)
