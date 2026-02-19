-- LUIZ AURA VIP V5 - ANTI-INVISIBILIDADE & ESP POTENTE
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local SG = Instance.new("ScreenGui", game:GetService("CoreGui"))

local function criarESP(p)
    if p == LP then return end
    
    -- Função que roda sempre que o personagem nasce ou muda
    p.CharacterAdded:Connect(function(char)
        local hrp = char:WaitForChild("HumanoidRootPart", 10)
        if hrp then
            -- Remove ESP antigo se existir
            if hrp:FindFirstChild("AuraUltraESP") then hrp.AuraUltraESP:Destroy() end
            
            -- Cria o BillboardGui (Fica visível através de paredes e invisibilidade)
            local bb = Instance.new("BillboardGui", hrp)
            bb.Name = "AuraUltraESP"
            bb.Size = UDim2.new(0, 100, 0, 50)
            bb.AlwaysOnTop = true -- O SEGREDO: Ignora qualquer bloqueio visual
            bb.ExtentsOffset = Vector3.new(0, 3, 0)
            
            -- Nome do Jogador (Grande e Amarelo)
            local nameLabel = Instance.new("TextLabel", bb)
            nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
            nameLabel.Text = "[ " .. p.Name .. " ]"
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
            nameLabel.TextStrokeTransparency = 0
            nameLabel.BackgroundTransparency = 1
            nameLabel.TextScaled = true
            nameLabel.Font = Enum.Font.GothamBold
            
            -- Indicador de Distância
            local distLabel = Instance.new("TextLabel", bb)
            distLabel.Size = UDim2.new(1, 0, 0.5, 0)
            distLabel.Position = UDim2.new(0, 0, 0.5, 0)
            distLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
            distLabel.BackgroundTransparency = 1
            distLabel.TextScaled = true
            
            -- Loop para atualizar distância (Leve para o P35)
            task.spawn(function()
                while bb.Parent do
                    local distancia = (hrp.Position - LP.Character.HumanoidRootPart.Position).Magnitude
                    distLabel.Text = math.floor(distancia) .. "m"
                    task.wait(0.5)
                end
            end)
        end
    end)
end

-- Ativa para quem já está no servidor e novos que entrarem
for _, player in pairs(Players:GetPlayers()) do
    criarESP(player)
end
Players.PlayerAdded:Connect(criarESP)
