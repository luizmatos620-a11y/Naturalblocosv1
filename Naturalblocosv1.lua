-- LUIZ AURA VIP - ESP TRACER & GHOST MODE
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local SG = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- FUNÇÃO 1: GHOST MODE (Atravessar Players)
-- No P35, isso evita que você seja jogado longe no Knockout
RunService.Stepped:Connect(function()
    if LP.Character then
        for _, part in pairs(LP.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false -- Você atravessa tudo
            end
        end
    end
end)

-- FUNÇÃO 2: ESP TRACER (Linha de Direção)
local function criarLinha()
    local line = Instance.new("Frame", SG)
    line.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Vermelho Alvo
    line.BorderSizePixel = 0
    line.AnchorPoint = Vector2.new(0.5, 0.5)
    return line
end

local tracers = {}

RunService.RenderStepped:Connect(function()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            if not tracers[v] then tracers[v] = criarLinha() end
            
            local hrp = v.Character.HumanoidRootPart
            local cam = workspace.CurrentCamera
            
            -- Ponto inicial (Pinguim) e Ponto final (Para onde ele olha)
            local startPos, vis1 = cam:WorldToViewportPoint(hrp.Position)
            local endPos, vis2 = cam:WorldToViewportPoint(hrp.Position + (hrp.CFrame.LookVector * 10))
            
            if vis1 and vis2 then
                local line = tracers[v]
                local dist = (Vector2.new(startPos.X, startPos.Y) - Vector2.new(endPos.X, endPos.Y)).Magnitude
                
                line.Visible = true
                line.Size = UDim2.new(0, dist, 0, 2)
                line.Position = UDim2.new(0, (startPos.X + endPos.X) / 2, 0, (startPos.Y + endPos.Y) / 2)
                line.Rotation = math.deg(math.atan2(endPos.Y - startPos.Y, endPos.X - startPos.X))
            else
                tracers[v].Visible = false
            end
        elseif tracers[v] then
            tracers[v]:Destroy()
            tracers[v] = nil
        end
    end
end)
