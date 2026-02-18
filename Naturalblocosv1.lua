-- LUIZ AURA VIP - RADAR DE SETAS (LEVE PARA P35)
local ScreenGui = Instance.new("ScreenGui")
local RadarFrame = Instance.new("Frame")
local ToggleRadar = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
RadarFrame.Parent = ScreenGui
RadarFrame.Size = UDim2.new(0, 150, 0, 40)
RadarFrame.Position = UDim2.new(0.5, -75, 0.02, 0)
RadarFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
RadarFrame.Active = true
RadarFrame.Draggable = true

ToggleRadar.Parent = RadarFrame
ToggleRadar.Size = UDim2.new(1, 0, 1, 0)
ToggleRadar.Text = "RADAR: OFF"
ToggleRadar.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleRadar.BackgroundColor3 = Color3.fromRGB(100, 0, 0)

local radarAtivo = false
local setas = {}

-- Função para criar a setinha
local function criarSeta(player)
    local seta = Instance.new("TextLabel")
    seta.Parent = ScreenGui
    seta.Text = "▲" -- Seta indicadora
    seta.TextColor3 = Color3.fromRGB(0, 255, 0)
    seta.BackgroundTransparency = 1
    seta.Size = UDim2.new(0, 20, 0, 20)
    seta.Visible = false
    return seta
end

ToggleRadar.MouseButton1Click:Connect(function()
    radarAtivo = not radarAtivo
    ToggleRadar.Text = radarAtivo and "RADAR: ATIVO" or "RADAR: OFF"
    ToggleRadar.BackgroundColor3 = radarAtivo and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(100, 0, 0)

    if radarAtivo then
        task.spawn(function()
            while radarAtivo do
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        if not setas[p] then setas[p] = criarSeta(p) end
                        
                        local hrp = p.Character.HumanoidRootPart
                        local pos, visivel = game.Workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
                        
                        if visivel then
                            setas[p].Visible = true
                            setas[p].Position = UDim2.new(0, pos.X, 0, pos.Y - 40)
                            -- Faz a seta apontar para onde o player olha
                            setas[p].Rotation = hrp.Orientation.Y
                        else
                            setas[p].Visible = false
                        end
                    end
                end
                task.wait(0.05) -- Estabilidade para o P35
            end
            -- Limpa as setas ao desligar
            for _, s in pairs(setas) do s:Destroy() end
            setas = {}
        end)
    end
end)
