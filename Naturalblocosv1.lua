-- LUIZ AURA MENU VIP V3.1 (Fling Corrigido)
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RunService = game:GetService("RunService")

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local Title = Instance.new("TextLabel", MainFrame)
local FlingBtn = Instance.new("TextButton", MainFrame)

-- Estilo VIP Luiz Aura
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "LUIZ AURA VIP"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

-- FUNÇÃO FLING REAL (Com Colisão Ativa)
local flingAtivo = false
FlingBtn.Size = UDim2.new(0.8, 0, 0, 50)
FlingBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
FlingBtn.Text = "FLING: OFF"
FlingBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FlingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", FlingBtn).CornerRadius = UDim.new(0, 8)

FlingBtn.MouseButton1Click:Connect(function()
    flingAtivo = not flingAtivo
    FlingBtn.Text = flingAtivo and "FLING: ATIVO" or "FLING: OFF"
    FlingBtn.BackgroundColor3 = flingAtivo and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(50, 50, 50)
    
    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LP.Character.HumanoidRootPart
        
        if flingAtivo then
            -- Garante que a colisão esteja ATIVA para o fling funcionar
            for _, part in pairs(LP.Character:GetChildren()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
            
            -- Cria a força de giro ultra rápida
            local bav = Instance.new("BodyAngularVelocity", hrp)
            bav.Name = "AuraFling"
            bav.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bav.P = 12500
            bav.AngularVelocity = Vector3.new(0, 99999, 0) -- Velocidade de ejeção
        else
            if hrp:FindFirstChild("AuraFling") then
                hrp.AuraFling:Destroy()
            end
        end
    end
end)
