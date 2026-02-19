-- LUIZ AURA VIP V10 - FINAL
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local SG = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- VARIÁVEIS DE CONTROLE
local autoHitAtivo = false

-- CRIAR INTERFACE (Design Luiz Aura)
local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 200, 0, 180)
Main.Position = UDim2.new(0.5, -100, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "LUIZ AURA VIP V10"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

-- BOTÃO AUTO HIT (FILTRADO)
local HitBtn = Instance.new("TextButton", Main)
HitBtn.Size = UDim2.new(0.8, 0, 0, 40)
HitBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
HitBtn.Text = "AUTO HIT: OFF"
HitBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
HitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", HitBtn)

-- LÓGICA DO FILTRO DE ARENA (SÓ PEGA QUEM TÁ NO GELO)
local function estaNoGelo(p)
    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
        local y = p.Character.HumanoidRootPart.Position.Y
        -- Filtra por altura: Se estiver muito alto ou baixo, é Lobby
        if y > -10 and y < 25 then 
            return true 
        end
    end
    return false
end

HitBtn.MouseButton1Click:Connect(function()
    autoHitAtivo = not autoHitAtivo
    HitBtn.Text = autoHitAtivo and "HIT: ATIVO" or "HIT: OFF"
    HitBtn.BackgroundColor3 = autoHitAtivo and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(40, 40, 40)
end)

-- LOOP PRINCIPAL (OTIMIZADO PARA P35)
task.spawn(function()
    while true do
        if autoHitAtivo then
            local alvoPerto = nil
            local menorDist = math.huge
            
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and estaNoGelo(p) then
                    local d = (LP.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if d < menorDist then
                        menorDist = d
                        alvoPerto = p
                    end
                end
            end
            
            if alvoPerto then
                local hrp = LP.Character.HumanoidRootPart
                local alvoHrp = alvoPerto.Character.HumanoidRootPart
                -- Impacto rápido (atravessa e volta)
                hrp.CFrame = alvoHrp.CFrame * CFrame.new(0, 0, 1.3)
                task.wait(0.05)
                hrp.CFrame = alvoHrp.CFrame * CFrame.new(0, 0, -1.3)
            end
        end
        task.wait(0.15) -- Delay de segurança para o Delta não fechar
    end
end)

print("LUIZ AURA VIP CARREGADO COM SUCESSO")
