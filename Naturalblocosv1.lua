-- LUIZ AURA VIP - AUTO WIN COM FILTRO
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RunService = game:GetService("RunService")
local SG = Instance.new("ScreenGui", game:GetService("CoreGui"))

local autoWin = false

-- INTERFACE MÍNIMA (PARA NÃO TRAVAR O P35)
local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 160, 0, 100)
Main.Position = UDim2.new(0.5, -80, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "LUIZ AURA VIP"
Title.TextColor3 = Color3.fromRGB(0, 255, 127)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

local WinBtn = Instance.new("TextButton", Main)
WinBtn.Size = UDim2.new(0.85, 0, 0, 45)
WinBtn.Position = UDim2.new(0.075, 0, 0.4, 0)
WinBtn.Text = "AUTO WIN: OFF"
WinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
WinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
WinBtn.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", WinBtn).CornerRadius = UDim.new(0, 8)

-- FILTRO DE ARENA (Ignora o Lobby)
local function estaNaPartida(p)
    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
        local pos = p.Character.HumanoidRootPart.Position
        -- Altura padrão da arena do pinguim (Evita os jogadores que estão no alto do lobby)
        if pos.Y > -15 and pos.Y < 22 then 
            return true 
        end
    end
    return false
end

WinBtn.MouseButton1Click:Connect(function()
    autoWin = not autoWin
    WinBtn.Text = autoWin and "WIN: ATIVO" or "AUTO WIN: OFF"
    WinBtn.BackgroundColor3 = autoWin and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(40, 40, 40)
end)

-- LÓGICA DE ATAQUE POR IMPACTO
task.spawn(function()
    while true do
        if autoWin and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            local alvo = nil
            local dist = math.huge
            
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and estaNaPartida(p) then
                    local d = (LP.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if d < dist then
                        dist = d
                        alvo = p
                    end
                end
            end
            
            if alvo then
                local hrp = LP.Character.HumanoidRootPart
                local targetHrp = alvo.Character.HumanoidRootPart
                -- Impacto violento (Atropelar)
                hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 1.1)
                task.wait(0.03)
                hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, -1.1)
            end
        end
        task.wait(0.12) -- Seguro para o Delta no Helio P35
    end
end)
