-- LUIZ AURA VIP - TRACKER SEGURO
local p = game:GetService("Players")
local lp = p.LocalPlayer
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))

local function criarSeta(player)
    local s = Instance.new("TextLabel", sg)
    s.Text = "V"
    s.TextColor3 = Color3.fromRGB(255, 255, 0)
    s.BackgroundTransparency = 1
    s.Size = UDim2.new(0, 30, 0, 30)
    s.Font = Enum.Font.SourceSansBold
    s.TextSize = 25
    return s
end

local setas = {}

game:GetService("RunService").RenderStepped:Connect(function()
    for _, v in pairs(p:GetPlayers()) do
        if v ~= lp and v.Character and v.Character:FindFirstChild("Head") then
            if not setas[v] then setas[v] = criarSeta(v) end
            
            local cam = workspace.CurrentCamera
            local head = v.Character.Head
            local pos, vis = cam:WorldToViewportPoint(head.Position)
            
            if vis then
                setas[v].Visible = true
                setas[v].Position = UDim2.new(0, pos.X - 15, 0, pos.Y - 70)
                
                -- Rastreia para onde a cabeça do pinguim está virada (Câmera dele)
                local look = head.CFrame.LookVector
                local angulo = math.atan2(look.X, look.Z)
                setas[v].Rotation = math.deg(angulo) + 180
            else
                setas[v].Visible = false
            end
        elseif setas[v] then
            setas[v]:Destroy()
            setas[v] = nil
        end
    end
end)
