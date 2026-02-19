-- LUIZ AURA VIP - TRACKER REAL (OLHAR DELES)
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local SG = Instance.new("ScreenGui", game:GetService("CoreGui"))

local function criarSeta(p)
    local s = Instance.new("TextLabel", SG)
    s.Text = "▼" -- Seta apontando para onde o pinguim olha
    s.TextColor3 = Color3.fromRGB(255, 255, 0)
    s.BackgroundTransparency = 1
    s.Size = UDim2.new(0, 30, 0, 30)
    s.Font = Enum.Font.SourceSansBold
    s.TextSize = 30
    return s
end

local setas = {}

game:GetService("RunService").RenderStepped:Connect(function()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            if not setas[v] then setas[v] = criarSeta(v) end
            
            local cam = workspace.CurrentCamera
            local hrp = v.Character.HumanoidRootPart
            local pos, vis = cam:WorldToViewportPoint(hrp.Position)
            
            if vis then
                setas[v].Visible = true
                setas[v].Position = UDim2.new(0, pos.X - 15, 0, pos.Y - 80)
                
                -- O SEGREDO: Pega a rotação do corpo do PLAYER, não da TUA câmera
                -- Isso faz a seta girar conforme o pinguim vira o olhar
                setas[v].Rotation = hrp.Orientation.Y + 180
            else
                setas[v].Visible = false
            end
        elseif setas[v] then
            setas[v]:Destroy()
            setas[v] = nil
        end
    end
end)
