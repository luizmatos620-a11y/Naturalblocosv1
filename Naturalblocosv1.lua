-- LUIZ AURA VIP V10 - ANTI-LOBBY ATTACK
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local autoHit = false

-- Função para verificar se o pinguim está REALMENTE no gelo
-- Geralmente o Lobby fica em uma altura diferente ou longe do centro (0,0,0)
local function estaNoGelo(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local pos = player.Character.HumanoidRootPart.Position
        -- No Be a Penguin, o gelo geralmente fica perto da altura 0 a 20.
        -- Se o player estiver muito alto ou muito longe do centro, ele está no lobby.
        if pos.Y < 30 and pos.Y > -10 and (pos.Magnitude < 250) then 
            return true 
        end
    end
    return false
end

local function getAlvoValido()
    local maisPerto = nil
    local menorDist = math.huge
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and estaNoGelo(p) then
            local d = (LP.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
            if d < menorDist then
                menorDist = d
                maisPerto = p
            end
        end
    end
    return maisPerto
end

-- LÓGICA DE ATAQUE (Executar no botão do seu Menu)
task.spawn(function()
    while true do
        if autoHit then
            local alvo = getAlvoValido()
            if alvo and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                local meuHrp = LP.Character.HumanoidRootPart
                local alvoHrp = alvo.Character.HumanoidRootPart
                
                -- IMPACTO VELOZ (Frente e Trás instantâneo)
                meuHrp.CFrame = alvoHrp.CFrame * CFrame.new(0, 0, 1.2)
                task.wait(0.05) -- Pequeno delay para o motor físico registrar o peso
                meuHrp.CFrame = alvoHrp.CFrame * CFrame.new(0, 0, -1.2)
            end
        end
        task.wait(0.1) -- Proteção para o seu Helio P35
    end
end)
