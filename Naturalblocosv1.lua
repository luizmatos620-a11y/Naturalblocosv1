-- LUIZ AURA MENU VIP V3 - DESIGN MODERNO
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local UICorner = Instance.new("UICorner", MainFrame)
local Title = Instance.new("TextLabel", MainFrame)
local FlingBtn = Instance.new("TextButton", MainFrame)
local GhostBtn = Instance.new("TextButton", MainFrame)

-- DESIGN MODERNO (Neon Aura)
MainFrame.Size = UDim2.new(0, 220, 0, 180)
MainFrame.Position = UDim2.new(0.5, -110, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 15)

Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "LUIZ AURA VIP"
Title.TextColor3 = Color3.fromRGB(0, 255, 127) -- Verde Neon
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- FUNÇÃO FLING (Girar para Jogar Longe)
local flingAtivo = false
FlingBtn.Size = UDim2.new(0.8, 0, 0, 40)
FlingBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
FlingBtn.Text = "FLING: OFF"
FlingBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
FlingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", FlingBtn).CornerRadius = UDim.new(0, 8)

FlingBtn.MouseButton1Click:Connect(function()
    flingAtivo = not flingAtivo
    FlingBtn.Text = flingAtivo and "FLING: ATIVO" or "FLING: OFF"
    FlingBtn.BackgroundColor3 = flingAtivo and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
    
    task.spawn(function()
        local bodyAng = Instance.new("BodyAngularVelocity")
        bodyAng.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyAng.P = 10000
        
        while flingAtivo do
            if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                bodyAng.Parent = LP.Character.HumanoidRootPart
                bodyAng.AngularVelocity = Vector3.new(0, 99999, 0) -- Giro Ultra Rápido
            end
            task.wait(0.1)
        end
        bodyAng:Destroy()
    end)
end)

-- FUNÇÃO GHOST (Atravessar + Complemento Fling)
local ghostAtivo = false
GhostBtn.Size = UDim2.new(0.8, 0, 0, 40)
GhostBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
GhostBtn.Text = "GHOST: OFF"
GhostBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
GhostBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", GhostBtn).CornerRadius = UDim.new(0, 8)

GhostBtn.MouseButton1Click:Connect(function()
    ghostAtivo = not ghostAtivo
    GhostBtn.Text = ghostAtivo and "GHOST: ATIVO" or "GHOST: OFF"
    GhostBtn.BackgroundColor3 = ghostAtivo and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(45, 45, 45)
end)

RunService.Stepped:Connect(function()
    if ghostAtivo and LP.Character then
        for _, part in pairs(LP.Character:GetChildren()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)
