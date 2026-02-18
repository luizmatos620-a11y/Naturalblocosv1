-- Script Luiz Aura para Delta (Roblox) - Fly & Anti-Push
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyBtn = Instance.new("TextButton")
local AntiPushBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.Size = UDim2.new(0, 200, 0, 160)
MainFrame.Active = true
MainFrame.Draggable = true 

Title.Parent = MainFrame
Title.Text = "LUIZ AURA - SUPER"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.fromRGB(0, 255, 127) -- Verde Brilhante
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

-- FUNÇÃO 1: VÔO DO SUPER HOMEM (FLY)
local flying = false
local speed = 50
FlyBtn.Parent = MainFrame
FlyBtn.Text = "Vôo do Super Homem"
FlyBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
FlyBtn.Size = UDim2.new(0.8, 0, 0.25, 0)

FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    local player = game.Players.LocalPlayer
    local char = player.Character
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    if flying then
        FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "AuraFly"
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        
        -- Loop do Vôo
        task.spawn(function()
            while flying do
                bv.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * speed
                task.wait()
            end
            bv:Destroy()
        end)
    else
        FlyBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end
end)

-- FUNÇÃO 2: ANTI-PUSH (PESO INFINITO)
local antipush = false
AntiPushBtn.Parent = MainFrame
AntiPushBtn.Text = "Anti-Push (Travado)"
AntiPushBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
AntiPushBtn.Size = UDim2.new(0.8, 0, 0.25, 0)

AntiPushBtn.MouseButton1Click:Connect(function()
    antipush = not antipush
    local char = game.Players.LocalPlayer.Character
    if char then
        for _, v in pairs(char:GetChildren()) do
            if v:IsA("BasePart") then
                -- Define a massa como gigante para ninguém te empurrar
                v.CustomPhysicalProperties = antipush and PhysicalProperties.new(100, 0.3, 0.5) or nil
                -- Alternativa visual: Ancorar se estiver parado
                if antipush then v.Anchored = true else v.Anchored = false end
            end
        end
    end
    AntiPushBtn.Text = antipush and "MODO PESADO ON" or "ANTI-PUSH OFF"
end)
