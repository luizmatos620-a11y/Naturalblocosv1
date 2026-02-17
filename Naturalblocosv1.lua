-- LUIZPHONE V3.1 SAFE-MODE (CORREÇÃO TELA PRETA)
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local pgui = lp:WaitForChild("PlayerGui")

if pgui:FindFirstChild("LuizPhone") then pgui.LuizPhone:Destroy() end

local LuizPhone = Instance.new("ScreenGui")
LuizPhone.Name = "LuizPhone"
LuizPhone.Parent = pgui
LuizPhone.ResetOnSpawn = false

-- --- CHASSIS PRINCIPAL ---
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = LuizPhone
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 520)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Cor sólida em vez de imagem
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

-- Força o arredondamento (se ficar quadrado, o Delta está limitando a GUI)
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 40)
MainCorner.Parent = MainFrame

-- Borda visível
local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 4
Stroke.Color = Color3.fromRGB(50, 50, 50)
Stroke.Parent = MainFrame

-- --- CONTEÚDO DA TELA ---
local Screen = Instance.new("Frame")
Screen.Name = "Screen"
Screen.Parent = MainFrame
Screen.Position = UDim2.new(0.04, 0, 0.02, 0)
Screen.Size = UDim2.new(0.92, 0, 0.96, 0)
Screen.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Fundo escuro sólido
Screen.ClipsDescendants = true

local ScreenCorner = Instance.new("UICorner")
ScreenCorner.CornerRadius = UDim.new(0, 35)
ScreenCorner.Parent = Screen

-- --- ILHA DINÂMICA ---
local Island = Instance.new("Frame")
Island.Parent = Screen
Island.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Island.Size = UDim2.new(0, 90, 0, 25)
Island.Position = UDim2.new(0.5, -45, 0.03, 0)
Instance.new("UICorner", Island).CornerRadius = UDim.new(1, 0)

-- --- TECLADO DE SENHA (CORREÇÃO DE CLIQUE) ---
local LockScreen = Instance.new("Frame")
LockScreen.Parent = Screen
LockScreen.Size = UDim2.new(1, 0, 1, 0)
LockScreen.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LockScreen.ZIndex = 10

local Msg = Instance.new("TextLabel")
Msg.Parent = LockScreen
Msg.Text = "DIGITE A SENHA"
Msg.Size = UDim2.new(1, 0, 0.2, 0)
Msg.Position = UDim2.new(0, 0, 0.1, 0)
Msg.TextColor3 = Color3.fromRGB(255, 255, 255)
Msg.BackgroundTransparency = 1
Msg.Font = Enum.Font.GothamBold
Msg.TextSize = 20

local Keypad = Instance.new("Frame")
Keypad.Parent = LockScreen
Keypad.Size = UDim2.new(0.8, 0, 0.5, 0)
Keypad.Position = UDim2.new(0.1, 0, 0.4, 0)
Keypad.BackgroundTransparency = 1

local Grid = Instance.new("UIGridLayout")
Grid.Parent = Keypad
Grid.CellSize = UDim2.new(0, 50, 0, 50)
Grid.CellPadding = UDim2.new(0, 15, 0, 15)
Grid.HorizontalAlignment = Enum.HorizontalAlignment.Center

local current = ""
local pass = "Luizmenu2026"

local function createKey(n)
    local btn = Instance.new("TextButton")
    btn.Parent = Keypad
    btn.Text = n
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    
    btn.MouseButton1Click:Connect(function()
        current = current .. n
        Msg.Text = string.rep("*", #current)
        if current == pass then
            LockScreen:TweenPosition(UDim2.new(0, 0, -1, 0), "Out", "Quart", 0.5)
        elseif #current >= #pass then
            current = ""
            Msg.Text = "ERRO - TENTE DE NOVO"
            task.wait(1)
            Msg.Text = "DIGITE A SENHA"
        end
    end)
end

for i = 1, 9 do createKey(tostring(i)) end
createKey("0")

-- APP DE TESTE
local App = Instance.new("TextButton")
App.Parent = Screen
App.Text = "FLING"
App.Size = UDim2.new(0, 60, 0, 60)
App.Position = UDim2.new(0.1, 0, 0.15, 0)
App.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Instance.new("UICorner", App)
