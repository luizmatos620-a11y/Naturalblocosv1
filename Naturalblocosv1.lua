-- Script Luiz Aura para Delta (Roblox)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local RandomBtn = Instance.new("TextButton")
local FreezeBtn = Instance.new("TextButton")

-- Configuração da Interface (Leve para o P35)
ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true -- Você pode arrastar o menu

Title.Parent = MainFrame
Title.Text = "LUIZ AURA HUB"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.fromRGB(0, 191, 255)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

-- Botão 1: Random Player (Teleporte)
RandomBtn.Parent = MainFrame
RandomBtn.Text = "Random Player"
RandomBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
RandomBtn.Size = UDim2.new(0.8, 0, 0.25, 0)

RandomBtn.MouseButton1Click:Connect(function()
    local players = game.Players:GetPlayers()
    local randomPlayer = players[math.random(1, #players)]
    if randomPlayer and randomPlayer.Character then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = randomPlayer.Character.HumanoidRootPart.CFrame
        print("Teleportado para: " .. randomPlayer.Name)
    end
end)

-- Botão 2: Travar Boneco (Anti-Push/Freeze)
FreezeBtn.Parent = MainFrame
FreezeBtn.Text = "Travar/Destravar"
FreezeBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
FreezeBtn.Size = UDim2.new(0.8, 0, 0.25, 0)

local travado = false
FreezeBtn.MouseButton1Click:Connect(function()
    travado = not travado
    local char = game.Players.LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                part.Anchored = travado -- Trava a física do boneco
            end
        end
    end
    FreezeBtn.Text = travado and "DESTRAVAR" or "TRAVAR BONECO"
end)

