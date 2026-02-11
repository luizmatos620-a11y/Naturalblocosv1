local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextButton = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Active = true
Frame.Draggable = true -- Permite arrastar o menu

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
TextButton.Size = UDim2.new(1, 0, 1, 0)
TextButton.Text = "MOVER BLOCOS"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 20

-- Função que roda quando clica no botão
TextButton.MouseButton1Click:Connect(function()
    print("Executando bypass de blocos...")
    local estrutura = workspace:FindFirstChild("Structure")
    if estrutura then
        for _, obj in pairs(estrutura:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.CFrame = obj.CFrame + Vector3.new(0, 100, 0)
            end
        end
    end
end)

