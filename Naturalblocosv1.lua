local sg = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 250, 0, 420) -- Aumentei o tamanho para caber tudo
main.Position = UDim2.new(0.5, -125, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "NATURAL HUB V2 - PRO"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(60, 0, 150)

local function createButton(name, pos, callback)
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(callback)
end

-- 1. TELEPORTE PARA A ILHA (Lugar seguro)
createButton("Teleportar para Ilha", 50, function()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 47, 18) -- Coordenadas da ilha principal
    end
end)

-- 2. ESP
createButton("Ativar ESP", 95, function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and p.Character then
            local h = Instance.new("Highlight", p.Character)
            h.FillColor = Color3.fromRGB(0, 255, 100)
        end
    end
end)

-- 3. MOVER BLOCOS
createButton("Mover Blocos (Visual)", 140, function()
    local est = workspace:FindFirstChild("Structure")
    if est then
        for _, o in pairs(est:GetDescendants()) do
            if o:IsA("BasePart") then o.CFrame = o.CFrame + Vector3.new(0, 50, 0) end
        end
    end
end)

-- --- SEÇÃO SKIN STEALER ---
local nameInput = Instance.new("TextBox", main)
nameInput.Size = UDim2.new(0.9, 0, 0, 35)
nameInput.Position = UDim2.new(0.05, 0, 0, 185)
nameInput.PlaceholderText = "Nome do Jogador..."
nameInput.Text = ""
nameInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
nameInput.TextColor3 = Color3.fromRGB(255, 255, 255)

createButton("Copiar Skin", 225, function()
    local targetName = nameInput.Text
    local targetPlayer = game.Players:FindFirstChild(targetName)
    local localPlayer = game.Players.LocalPlayer

    if targetPlayer and targetPlayer.Character and localPlayer.Character then
        local appearanceId = targetPlayer.UserId
        localPlayer.CharacterAppearanceId = appearanceId
        localPlayer:LoadCharacter() -- Recarrega você com a skin nova
        print("Skin copiada de: " .. targetName)
    else
        print("Jogador não encontrado!")
    end
end)

-- 4. VELOCIDADE
createButton("Velocidade Máxima", 280, function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

-- 5. VOAR (Noclip Simples)
createButton("Noclip (Atravessar)", 325, function()
    game:GetService("RunService").Stepped:Connect(function()
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end)
end)

createButton("FECHAR", 375, function() sg:Destroy() end)


