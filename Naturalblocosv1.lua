-- LUIZ AURA VIP V6 - ESP CORPO PRETO (BOX/CHAMS)
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local function aplicarESP(p)
    if p == LP then return end

    local function setupESP(char)
        -- Aguarda o corpo carregar (Seguro para o P35)
        local hrp = char:WaitForChild("HumanoidRootPart", 10)
        if not hrp then return end

        -- 1. EFEITO DE REALCE (HIGHLIGHT) - COR PRETA
        -- Isso faz o corpo ficar com uma borda preta visível através de tudo
        local highlight = Instance.new("Highlight")
        highlight.Name = "AuraCorpoVIP"
        highlight.Parent = char
        highlight.FillColor = Color3.fromRGB(0, 0, 0) -- Preto Total
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- Borda branca para destacar o preto
        highlight.FillTransparency = 0.5 -- Meio transparente para ver o pinguim
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- Vê através da parede

        -- 2. BOX ESP (CAIXA PRETA)
        local box = Instance.new("SelectionBox")
        box.Name = "AuraBoxVIP"
        box.Parent = hrp
        box.Adornee = char
        box.Color3 = Color3.fromRGB(0, 0, 0)
        box.LineThickness = 0.05
        box.Transparency = 0
    end

    -- Aplica quando o player nasce
    p.CharacterAdded:Connect(setupESP)
    if p.Character then setupESP(p.Character) end
end

-- Ativa para todos no servidor
for _, player in pairs(Players:GetPlayers()) do
    aplicarESP(player)
end
Players.PlayerAdded:Connect(aplicarESP)
