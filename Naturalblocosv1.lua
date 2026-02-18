-- Script Luiz Aura - Fly Horizontal (Analógico)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Active = true
MainFrame.Draggable = true 

Title.Parent = MainFrame
Title.Text = "LUIZ AURA - HORIZONTAL"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.fromRGB(0, 255, 255) -- Ciano Aura
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local flying = false
local speed = 60 

FlyBtn.Parent = MainFrame
FlyBtn.Text = "Ativar Voo Plano"
FlyBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
FlyBtn.Size = UDim2.new(0.8, 0, 0.4, 0)

FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    
    if flying then
        FlyBtn.Text = "VOO PLANO (ON)"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 50, 100)
        
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "AuraHorizontal"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        
        local bg = Instance.new("BodyGyro", hrp)
        bg.Name = "AuraGyro"
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        
        task.spawn(function()
            while flying do
                -- A mágica está aqui: Vector3.new(X, 0, Z) trava a altura no zero
                if hum.MoveDirection.Magnitude > 0 then
                    local moveDir = hum.MoveDirection
                    bv.Velocity = Vector3.new(moveDir.X * speed, 0, moveDir.Z * speed)
                else
                    bv.Velocity = Vector3.new(0, 0, 0)
                end
                
                -- Mantém o boneco olhando pra frente, sem inclinar pra baixo
                if hum.MoveDirection.Magnitude > 0 then
                    bg.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(moveDir.X, 0, moveDir.Z))
                end
                task.wait()
            end
            bv:Destroy()
            bg:Destroy()
            FlyBtn.Text = "Ativar Voo Plano"
        end)
    end
end)
