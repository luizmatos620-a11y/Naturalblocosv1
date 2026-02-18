-- LUIZ AURA VIP - EYE TRACKER (DIREÇÃO DA CÂMERA)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local alvos = {}

local function criarSetaCamera(player)
    local seta = Instance.new("TextLabel")
    seta.Parent = ScreenGui
    seta.Text = "V" -- Seta que aponta para baixo/frente
    seta.TextColor3 = Color3.fromRGB(255, 255, 0) -- Amarelo VIP
    seta.TextStrokeTransparency = 0
    seta.BackgroundTransparency = 1
    seta.Size = UDim2.new(0, 30, 0, 30)
    seta.Font = Enum.Font.SourceSansBold
    seta.TextSize = 25
    return seta
end

task.spawn(function()
    while true do
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                if not alvos[p] then alvos[p] = criarSetaCamera(p) end
                
                local cabeça = p.Character.Head
                local pos, visivel = game.Workspace.CurrentCamera:WorldToViewportPoint(cabeça.Position)
                
                if visivel then
                    alvos[p].Visible = true
                    alvos[p].Position = UDim2.new(0, pos.X - 15, 0, pos.Y - 70)
                    
                    -- A MÁGICA: A seta gira conforme a inclinação da CABEÇA (Olhar)
                    -- Isso mostra para onde a câmera do player está apontada
                    local direcao = cabeça.CFrame.LookVector
                    local angulo = math.atan2(direcao.X, direcao.Z)
                    alvos[p].Rotation = math.deg(angulo) + 180
                else
                    alvos[p].Visible = false
                end
            end
        end
        task.wait(0.02) -- Resposta ultra rápida para não perder o olhar
    end
end)
