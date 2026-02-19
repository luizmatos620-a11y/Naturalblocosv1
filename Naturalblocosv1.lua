local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- Função para criar a caixa preta ao redor do corpo
local function criarCaixa(p)
    if p == LP then return end

    p.CharacterAdded:Connect(function(char)
        local hrp = char:WaitForChild("HumanoidRootPart", 10)
        if hrp then
            -- Cria a caixa visual
            local box = Instance.new("SelectionBox")
            box.Name = "AuraPreta"
            box.Adornee = char
            box.Parent = hrp
            box.Color3 = Color3.fromRGB(0, 0, 0) -- COR PRETA
            box.LineThickness = 0.1 -- Deixa a linha bem visível
            box.Transparency = 0
            box.SurfaceTransparency = 0.5 -- Deixa o corpo com um tom escuro
            box.AlwaysOnTop = true -- Vê através de tudo
        end
    end)
    
    -- Se o player já estiver no mapa, aplica agora
    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = p.Character.HumanoidRootPart
        local box = Instance.new("SelectionBox")
        box.Name = "AuraPreta"
        box.Adornee = p.Character
        box.Parent = hrp
        box.Color3 = Color3.fromRGB(0, 0, 0)
        box.LineThickness = 0.1
        box.AlwaysOnTop = true
    end
end

-- Executa para todos
for _, v in pairs(Players:GetPlayers()) do
    criarCaixa(v)
end
Players.PlayerAdded:Connect(criarCaixa)
