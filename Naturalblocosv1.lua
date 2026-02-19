-- LUIZ AURA VIP V7 - AUTO-RECARGA (FIX PARTIDA)
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- Função para criar a caixa preta
local function criarCaixa(p)
    if p == LP then return end

    local function aplicar()
        -- Espera o pinguim carregar na arena
        local char = p.Character or p.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart", 10)
        
        if hrp then
            -- Se já tiver um ESP antigo, deleta pra não bugar
            if hrp:FindFirstChild("AuraPreta") then hrp.AuraPreta:Destroy() end
            
            local box = Instance.new("SelectionBox")
            box.Name = "AuraPreta"
            box.Adornee = char
            box.Parent = hrp
            box.Color3 = Color3.fromRGB(0, 0, 0)
            box.LineThickness = 0.15 -- Mais grosso pra ver bem no Kwai
            box.AlwaysOnTop = true
            box.Transparency = 0
        end
    end

    -- O SEGREDO: Rodar toda vez que o player "reaparecer" na arena
    p.CharacterAdded:Connect(aplicar)
    aplicar()
end

-- Ativa o monitoramento constante
for _, v in pairs(Players:GetPlayers()) do
    criarCaixa(v)
end
Players.PlayerAdded:Connect(criarCaixa)

print("Luiz Aura VIP: ESP Monitorando Arena...")
