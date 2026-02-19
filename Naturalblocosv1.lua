-- LUIZ AURA VIP V4 - TELEPORT & ESP GIGANTE
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local SG = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- Design do Menu Moderno
local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 220, 0, 200)
Main.Position = UDim2.new(0.5, -110, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "LUIZ AURA VIP V4"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

-- 1. FUNÇÃO RANDOM PLAYER (LISTA REAL)
local TPBtn = Instance.new("TextButton", Main)
TPBtn.Size = UDim2.new(0.8, 0, 0, 40)
TPBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
TPBtn.Text = "TELEPORT RANDOM"
TPBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TPBtn).CornerRadius = UDim.new(0, 8)

TPBtn.MouseButton1Click:Connect(function()
    local listaPlayers = Players:GetPlayers()
    -- Tira você da lista para não teleportar em si mesmo
    for i, p in ipairs(listaPlayers) do
        if p == LP then table.remove(listaPlayers, i) break end
    end
    
    if #listaPlayers > 0 then
        local alvo = listaPlayers[math.random(1, #listaPlayers)]
        if alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
            LP.Character.HumanoidRootPart.CFrame = alvo.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
            print("Luiz Aura VIP: Indo até " .. alvo.Name)
        end
    end
end)

-- 2. FUNÇÃO ESP NAME GIGANTE
local ESPBtn = Instance.new("TextButton", Main)
ESPBtn.Size = UDim2.new(0.8, 0, 0, 40)
ESPBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
ESPBtn.Text = "ESP NAME: OFF"
ESPBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", ESPBtn).CornerRadius = UDim.new(0, 8)

local espAtivo = false
ESPBtn.MouseButton1Click:Connect(function()
    espAtivo = not espAtivo
    ESPBtn.Text = espAtivo and "ESP NAME: ATIVO" or "ESP NAME: OFF"
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local head = p.Character:FindFirstChild("Head")
            if head then
                if espAtivo then
                    local bb = Instance.new("BillboardGui", head)
                    bb.Name = "AuraESP"
                    bb.Size = UDim2.new(0, 200, 0, 50)
                    bb.AlwaysOnTop = true
                    bb.ExtentsOffset = Vector3.new(0, 3, 0)
                    
                    local tl = Instance.new("TextLabel", bb)
                    tl.Size = UDim2.new(1, 0, 1, 0)
                    tl.Text = p.Name
                    tl.TextColor3 = Color3.fromRGB(255, 255, 0)
                    tl.TextScaled = true -- Fica gigante conforme a distância
                    tl.BackgroundTransparency = 1
                    tl.Font = Enum.Font.GothamBold
                else
                    if head:FindFirstChild("AuraESP") then head.AuraESP:Destroy() end
                end
            end
        end
    end
end)
