-- LUIZ AURA MENU VIP V2 (Fly Estabilizado)
local ScreenGui = Instance.new("ScreenGui")
local VIPFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyVIPBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
VIPFrame.Parent = ScreenGui
VIPFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Fundo VIP Preto
VIPFrame.BorderSizePixel = 2
VIPFrame.BorderColor3 = Color3.fromRGB(255, 215, 0) -- Borda Dourada
VIPFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
VIPFrame.Size = UDim2.new(0, 200, 0, 120)
VIPFrame.Active = true
VIPFrame.Draggable = true 

Title.Parent = VIPFrame
Title.Text = "LUIZ AURA VIP"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

-- Lógica do FLY VIP (O que você pediu)
local voador = false
local velo = 70 -- Velocidade VIP
FlyVIPBtn.Parent = VIPFrame
FlyVIPBtn.Text = "FLY VIP: OFF"
FlyVIPBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
FlyVIPBtn.Size = UDim2.new(0.8, 0, 0.4, 0)
FlyVIPBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
FlyVIPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

FlyVIPBtn.MouseButton1Click:Connect(function()
    voador = not voador
    local char = game.Players.LocalPlayer.Character
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    
    if voador then
        FlyVIPBtn.Text = "FLY VIP: ATIVO"
        FlyVIPBtn.BackgroundColor3 = Color3.fromRGB(218, 165, 32) -- Cor Ouro
        
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "AuraVIP_Fly"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        
        local bg = Instance.new("BodyGyro", hrp)
        bg.Name = "AuraVIP_Gyro"
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.P = 10000 -- Mais força para não balançar
        
        task.spawn(function()
            while voador do
                -- Movimento Horizontal Puro (Anti-Bug de Solo)
                if hum.MoveDirection.Magnitude > 0 then
                    local direcao = hum.MoveDirection
                    bv.Velocity = Vector3.new(direcao.X * velo, 0, direcao.Z * velo)
                    bg.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(direcao.X, 0, direcao.Z))
                else
                    bv.Velocity = Vector3.new(0, 0, 0)
                end
                task.wait(0.03) -- Resposta mais rápida no P35
            end
            bv:Destroy()
            bg:Destroy()
            FlyVIPBtn.Text = "FLY VIP: OFF"
            FlyVIPBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end)
    end
end)
