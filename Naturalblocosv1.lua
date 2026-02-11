local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Criar ScreenGui
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenuKnockout"
sg.ResetOnSpawn = false

-- --- INTRO LUIZ MENU ---
local introText = Instance.new("TextLabel", sg)
introText.Size = UDim2.new(0, 400, 0, 100)
introText.Position = UDim2.new(0.5, -200, 0.5, -50)
introText.BackgroundTransparency = 1
introText.Text = "LUIZ MENU: KNOCKOUT!"
introText.TextColor3 = Color3.fromRGB(255, 200, 0)
introText.Font = Enum.Font.GothamBold
introText.TextSize = 1
introText.TextTransparency = 1

TweenService:Create(introText, TweenInfo.new(1), {TextSize = 40, TextTransparency = 0}):Play()
task.wait(1.5)
TweenService:Create(introText, TweenInfo.new(0.5), {TextSize = 0, TextTransparency = 1}):Play()
task.wait(0.5)

-- --- QUADRO PRINCIPAL (Adaptado para Mobile) ---
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 280, 0, 350)
main.Position = UDim2.new(0.5, -140, 0.5, -175)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Visible = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 50)
title.Text = "KNOCKOUT! HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
Instance.new("UICorner", title)

-- BOTÃO FLUTUANTE PARA MOBILE
local icon = Instance.new("TextButton", sg)
icon.Size = UDim2.new(0, 60, 0, 60)
icon.Position = UDim2.new(0, 10, 0.1, 0)
icon.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
icon.Text = "L"
icon.TextColor3 = Color3.fromRGB(255, 255, 255)
icon.Font = Enum.Font.GothamBold
icon.TextSize = 30
Instance.new("UICorner", icon).CornerRadius = UDim.new(1, 0)
icon.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)

-- SCROLL DE FUNÇÕES
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -20, 1, -70)
scroll.Position = UDim2.new(0, 10, 0, 60)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
scroll.ScrollBarThickness = 4

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 10)

local function createBtn(txt, cb)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(1, 0, 0, 45) -- Botões maiores para Mobile
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- --- FUNÇÕES DO JOGO KNOCKOUT ---

createBtn("Super Soco (Reach)", function()
    -- Aumenta o tamanho da mão para acertar de longe
    for _, v in pairs(lp.Character:GetChildren()) do
        if v:IsA("BasePart") and (v.Name:find("Arm") or v.Name:find("Hand")) then
            v.Size = Vector3.new(10, 10, 10)
            v.Transparency = 0.7
            v.CanCollide = false
        end
    end
end)

createBtn("Anti-Knockback (Imune)", function()
    -- Impede que sejas empurrado
    local hrp = lp.Character:WaitForChild("HumanoidRootPart")
    hrp.ChildAdded:Connect(function(c)
        if c:IsA("BodyVelocity") or c:IsA("BodyForce") then
            task.wait()
            c:Destroy()
        end
    end)
end)

createBtn("Velocidade Mobile", function()
    lp.Character.Humanoid.WalkSpeed = 80
end)

local flying = false
createBtn("Voar (Ativar/Desativar)", function()
    flying = not flying
    local hrp = lp.Character.HumanoidRootPart
    if flying then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "FlyMobile"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0,0,0)
        
        -- Loop de voo para mobile (segue para onde a câmara olha)
        task.spawn(function()
            while flying do
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50
                task.wait()
            end
            bv:Destroy()
        end)
    end
end)

createBtn("Pulo Infinito", function()
    UserInputService.JumpRequest:Connect(function()
        lp.Character.Humanoid:ChangeState("Jumping")
    end)
end)

-- ARRASTAR NO MOBILE
local dragging, dragStart, startPos
main.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = i.Position
        startPos = main.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local delta = i.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function() dragging = false end)
