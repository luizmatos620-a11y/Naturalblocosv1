local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Criar ScreenGui
local sg = Instance.new("ScreenGui", CoreGui)
sg.Name = "LuizMenuV1_Advanced"
sg.ResetOnSpawn = false

-- --- 1. INTRO LUIZ MENU V1 "3D" ---
local introContainer = Instance.new("Frame", sg)
introContainer.Size = UDim2.new(1, 0, 1, 0)
introContainer.BackgroundTransparency = 1

local introText = Instance.new("TextLabel", introContainer)
introText.Size = UDim2.new(0, 500, 0, 100)
introText.Position = UDim2.new(0.5, -250, 0.5, -50)
introText.BackgroundTransparency = 1
introText.Text = "LUIZ MENU V1"
introText.TextColor3 = Color3.fromRGB(255, 255, 255)
introText.Font = Enum.Font.GothamBold
introText.TextSize = 1
introText.TextTransparency = 1

-- Efeito de Sombra (Para o "3D")
local shadow = introText:Clone()
shadow.Parent = introContainer
shadow.TextColor3 = Color3.fromRGB(100, 0, 255)
shadow.ZIndex = introText.ZIndex - 1

-- Animação de Entrada
task.spawn(function()
    local info = TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    TweenService:Create(introText, info, {TextSize = 80, TextTransparency = 0}):Play()
    TweenService:Create(shadow, info, {TextSize = 82, TextTransparency = 0.5, Position = UDim2.new(0.5, -248, 0.5, -48)}):Play()
    wait(2)
    TweenService:Create(introText, info, {TextTransparency = 1, TextSize = 120}):Play()
    TweenService:Create(shadow, info, {TextTransparency = 1, TextSize = 122}):Play()
    wait(1)
    introContainer:Destroy()
end)

-- --- 2. INTERFACE PRINCIPAL ---
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 500, 0, 350)
main.Position = UDim2.new(0.5, -250, 0.5, -175)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
main.BorderSizePixel = 0
main.Visible = false -- Fica invisível até a intro acabar
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

-- Barra Superior (Abas)
local tabHolder = Instance.new("Frame", main)
tabHolder.Size = UDim2.new(1, 0, 0, 45)
tabHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
tabHolder.BorderSizePixel = 0
local tabCorner = Instance.new("UICorner", tabHolder)

local tabLayout = Instance.new("UIListLayout", tabHolder)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabLayout.Padding = UDim.new(0, 5)

-- Container de Páginas
local pages = Instance.new("Frame", main)
pages.Size = UDim2.new(1, -20, 1, -65)
pages.Position = UDim2.new(0, 10, 0, 55)
pages.BackgroundTransparency = 1

-- Botão Minimizar
local minBtn = Instance.new("TextButton", main)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -35, 0, 7)
minBtn.Text = "-"
minBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", minBtn)

-- Ícone para Reabrir
local openIcon = Instance.new("TextButton", sg)
openIcon.Size = UDim2.new(0, 50, 0, 50)
openIcon.Position = UDim2.new(0, 10, 0.5, -25)
openIcon.Visible = false
openIcon.Text = "L"
openIcon.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
openIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)

-- Lógica de Minimizar
minBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    openIcon.Visible = true
end)
openIcon.MouseButton1Click:Connect(function()
    main.Visible = true
    openIcon.Visible = false
end)

-- --- 3. SISTEMA DE ABAS ---
local function createTab(name)
    local tabBtn = Instance.new("TextButton", tabHolder)
    tabBtn.Size = UDim2.new(0, 90, 0, 35)
    tabBtn.BackgroundTransparency = 1
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 14
    
    local page = Instance.new("ScrollingFrame", pages)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Visible = false
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 0
    page.Name = name .. "Page"
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages:GetChildren()) do p.Visible = false end
        for _, t in pairs(tabHolder:GetChildren()) do 
            if t:IsA("TextButton") then t.TextColor3 = Color3.fromRGB(150, 150, 150) end 
        end
        page.Visible = true
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    return page
end

-- Criando as Abas solicitadas
local jogoTab = createTab("Jogo")
local playerTab = createTab("Player")
local serverTab = createTab("Servidor")
local farmTab = createTab("Farm")
local trollTab = createTab("Troll")

-- Mostrar a primeira aba por padrão
jogoTab.Visible = true

-- Finalizar Intro e mostrar menu
task.delay(3.5, function() main.Visible = true end)

-- Arrastar (Mobile e PC)
local dragging, dragStart, startPos
main.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging = true dragStart = i.Position startPos = main.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local delta = i.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function() dragging = false end)
