-- LUIZ AURA VIP - FLY ESPECIAL KNOCKOUT
local ScreenGui = Instance.new("ScreenGui")
local FrameVIP = Instance.new("Frame")
local ButtonFly = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
FrameVIP.Parent = ScreenGui
FrameVIP.Size = UDim2.new(0, 180, 0, 80)
FrameVIP.Position = UDim2.new(0.5, -90, 0.1, 0)
FrameVIP.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
FrameVIP.Active = true
FrameVIP.Draggable = true

ButtonFly.Parent = FrameVIP
ButtonFly.Size = UDim2.new(0.9, 0, 0.7, 0)
ButtonFly.Position = UDim2.new(0.05, 0, 0.15, 0)
ButtonFly.Text = "FLY KNOCKOUT: OFF"
ButtonFly.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
ButtonFly.TextColor3 = Color3.fromRGB(255, 255, 255)

local isFlying = false
local flySpeed = 50

ButtonFly.MouseButton1Click:Connect(function()
    isFlying = not isFlying
    local char = game.Players.LocalPlayer.Character
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")

    if isFlying then
        ButtonFly.Text = "FLY KNOCKOUT: ON"
        ButtonFly.BackgroundColor3 = Color3.fromRGB(0, 150, 0)

        -- O segredo pro Knockout: MaxForce infinita impede empurrões
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "AuraKnockout"
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9) -- Força "infinita"
        bv.Velocity = Vector3.new(0, 0, 0)

        task.spawn(function()
            while isFlying do
                -- Voo controlado apenas pelo seu analógico
                if hum.MoveDirection.Magnitude > 0 then
                    bv.Velocity = hum.MoveDirection * flySpeed
                else
                    -- Fica travado no ar (Imunidade total a empurrões)
                    bv.Velocity = Vector3.new(0, 0, 0)
                end
                task.wait(0.05) -- Estável para o processador P35
            end
            if bv then bv:Destroy() end
        end)
    else
        ButtonFly.Text = "FLY KNOCKOUT: OFF"
        ButtonFly.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
    end
end)
