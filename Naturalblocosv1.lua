local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Criar ScreenGui
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenuKnockoutV4"
sg.ResetOnSpawn = false

-- --- INTRO LUIZ MENU ---
local introText = Instance.new("TextLabel", sg)
introText.Size = UDim2.new(0, 400, 0, 100)
introText.Position = UDim2.new(0.5, -200, 0.5, -50)
introText.BackgroundTransparency = 1
introText.Text = "LUIZ MENU: KNOCKOUT!"
introText.TextColor3 = Color3.fromRGB(255, 0, 0)
introText.Font = Enum.Font.GothamBold
introText.TextSize = 1
introText.TextTransparency = 1

TweenService:Create(introText, TweenInfo.new(1), {TextSize = 40, TextTransparency = 0}):Play()
task.wait(1.5)
TweenService:Create(introText, TweenInfo.new(0.5), {TextSize = 0, TextTransparency = 1}):Play()
task.wait(0.5)

-- --- QUADRO PRINCIPAL ---
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 280, 0, 400)
main.Position = UDim2.new(0.5, -140, 0.5, -200)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.BorderSizePixel = 0
main.Visible = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 50)
title.Text = "KNOCKOUT! HUB V4"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
Instance.new("UICorner", title)

-- BOTÃO FLUTUANTE (ABRIR/FECHAR)
local icon = Instance.new("TextButton", sg)
icon.Size = UDim2.new(0, 60, 0, 60)
icon.Position = UDim2.new(0, 10, 0.2, 0)
icon.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
icon.Text = "L"
icon.TextColor3 = Color3.fromRGB(255, 255, 255)
icon.Font = Enum.Font.GothamBold
icon.TextSize = 30
Instance.new("UICorner", icon).CornerRadius = UDim.new(1, 0)
icon.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)

-- SCROLL
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -20, 1, -70)
scroll.Position = UDim2.new(0, 10, 0, 60)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 2.5, 0)
scroll.ScrollBarThickness = 0

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 10)

local function createBtn(txt, cb)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(1, 0, 0, 45)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- --- FUNÇÕES ---

local killAura = false
createBtn("Kill Aura (Auto-Kill)", function()
    killAura = not killAura
    print("Kill Aura: "..tostring(killAura))
    task.spawn(function()
        while killAura do
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (lp.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 20 then
                        local tool = lp.Character:FindFirstChildOfClass("Tool") or lp.Backpack:FindFirstChildOfClass("Tool")
                        if tool then
                            tool.Parent = lp.Character
                            tool:Activate()
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end)

createBtn("Super Soco (Alcance)", function()
    for _, v in pairs(lp.Character:GetChildren()) do
        if v:IsA("BasePart") and (v.Name:find("Arm") or v.Name:find("Hand")) then
            v.Size = Vector3.new(10, 10, 10)
            v.Transparency = 0.8
        end
    end
end)

createBtn("Anti-Knockback", function()
    lp.Character.HumanoidRootPart.ChildAdded:Connect(function(c)
        if c:IsA("BodyVelocity") or c:IsA("BodyForce") then task.wait() c:Destroy() end
    end)
end)

local flying = false
createBtn("Fly (Voo Mobile)", function()
    flying = not flying
    local hrp = lp.Character.HumanoidRootPart
    if flying then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "FlyMobile"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        task.spawn(function()
            while flying do
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 60
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

createBtn("Velocidade Flash", function()
    lp.Character.Humanoid.WalkSpeed = 100
end)

-- ARRASTAR (DRAGGABLE)
local d, ds, sp
main.InputBegan:Connect(function(i) if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) then d = true ds = i.Position sp = main.Position end end)
UserInputService.InputChanged:Connect(function(i) if d and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
    local delta = i.Position - ds
    main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y)
end end)
UserInputService.InputEnded:Connect(function() d = false end)
