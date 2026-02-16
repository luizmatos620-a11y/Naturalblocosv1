-- LUIZ MENU V1 - SUPREMACIA TOTAL (FLY 3D + ESCUDO + INTRO)
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local function getChar() return lp.Character or lp.CharacterAdded:Wait() end
local function getHRP() return getChar():WaitForChild("HumanoidRootPart", 5) end

local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenu_V1_Final"
sg.ResetOnSpawn = false

-- --- 1. INTRO LUIZ MENU 3D ---
local introContainer = Instance.new("Frame", sg)
introContainer.Size = UDim2.new(1, 0, 1, 0)
introContainer.BackgroundTransparency = 1

local introText = Instance.new("TextLabel", introContainer)
introText.Size = UDim2.new(0, 600, 0, 100)
introText.Position = UDim2.new(0.5, -300, 0.5, -50)
introText.BackgroundTransparency = 1
introText.Text = "LUIZ MENU V1"
introText.TextColor3 = Color3.fromRGB(255, 0, 0)
introText.Font = Enum.Font.GothamBold
introText.TextSize = 1
introText.TextTransparency = 1

task.spawn(function()
    local info = TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    TweenService:Create(introText, info, {TextSize = 85, TextTransparency = 0}):Play()
    task.wait(2)
    TweenService:Create(introText, info, {TextTransparency = 1, TextSize = 130}):Play()
    task.wait(0.5)
    introContainer:Destroy()
end)

-- --- 2. INTERFACE E ÍCONE ---
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 550, 0, 520)
main.Position = UDim2.new(0.5, -275, 0.5, -260)
main.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
main.BorderSizePixel = 3
main.BorderColor3 = Color3.fromRGB(255, 0, 0)
main.Visible = false 
Instance.new("UICorner", main)

local openIcon = Instance.new("ImageButton", sg)
openIcon.Size = UDim2.new(0, 75, 0, 75)
openIcon.Position = UDim2.new(0, 15, 0.5, -37)
openIcon.Image = "rbxassetid://11293318182"
openIcon.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
openIcon.Visible = false
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)

local function toggle()
    main.Visible = not main.Visible
    openIcon.Visible = not main.Visible
end

openIcon.MouseButton1Click:Connect(toggle)
local closeX = Instance.new("TextButton", main)
closeX.Size = UDim2.new(0, 40, 0, 40)
closeX.Position = UDim2.new(1, -45, 0, 5)
closeX.Text = "X"
closeX.TextColor3 = Color3.fromRGB(255, 0, 0)
closeX.BackgroundTransparency = 1
closeX.TextSize = 35
closeX.MouseButton1Click:Connect(toggle)

local container = Instance.new("ScrollingFrame", main)
container.Size = UDim2.new(1, -20, 1, -70)
container.Position = UDim2.new(0, 10, 0, 60)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 2.5, 0)
Instance.new("UIListLayout", container).Padding = UDim.new(0, 10)

local function addOption(txt, cb)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, -10, 0, 45)
    b.BackgroundColor3 = Color3.fromRGB(35, 0, 0)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 20
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- --- 3. PODERES REAIS (100% FUNCIONAIS) ---

-- FLY ADMIN COMPLETO (SOBE/DESCE PELA CÂMERA + ESTATICO)
local flyActive = false
local flySpeed = 70
addOption("FLY ADMIN (CÂMERA + ESTÁTICO)", function()
    flyActive = not flyActive
    local hrp = getHRP()
    if flyActive then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "LuizFlyVel"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0,0,0)
        
        local bg = Instance.new("BodyGyro", hrp)
        bg.Name = "LuizFlyGyro"
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.CFrame = hrp.CFrame

        task.spawn(function()
            while flyActive do
                RunService.RenderStepped:Wait()
                local char = getChar()
                local hum = char:FindFirstChildOfClass("Humanoid")
                
                if hum and hrp then
                    local dir = hum.MoveDirection
                    -- Se mover, segue a câmera (sobe e desce)
                    if dir.Magnitude > 0 then
                        bv.Velocity = Camera.CFrame.LookVector * (dir.Z < 0 and flySpeed or -flySpeed) + 
                                      Camera.CFrame.RightVector * (dir.X > 0 and flySpeed or -flySpeed)
                    else
                        bv.Velocity = Vector3.new(0, 0.1, 0) -- Trava no ar
                    end
                    bg.CFrame = Camera.CFrame
                end
            end
            bv:Destroy() bg:Destroy()
        end)
    end
end)

-- ESCUDO DE ENTULHO (FÍSICA REAL E MORTAL)
local shieldActive = false
addOption("ESCUDO DE ENTULHO (MORTAL)", function()
    shieldActive = not shieldActive
    local angle = 0
    task.spawn(function()
        while shieldActive do
            angle = angle + 0.7
            local hrp = getHRP()
            if hrp then
                local count = 0
                for _, p in pairs(workspace:GetDescendants()) do
                    if p:IsA("BasePart") and not p.Anchored and not p:IsDescendantOf(lp.Character) then
                        if count > 35 then break end
                        local targetPos = hrp.Position + Vector3.new(math.cos(angle + count)*18, 5, math.sin(angle + count)*18)
                        
                        -- Colisão por transferência de energia (Impacto)
                        p.CFrame = CFrame.new(targetPos)
                        p.Velocity = (targetPos - p.Position) * 75
                        p.RotVelocity = Vector3.new(70, 70, 70)
                        count = count + 1
                    end
                end
            end
            task.wait(0.01)
        end
    end)
end)

-- MODO TORNADO (GIRAR PARA MATAR)
local tornadoActive = false
addOption("MODO TORNADO (GIRAR = KILL)", function()
    tornadoActive = not tornadoActive
    local hrp = getHRP()
    if tornadoActive then
        local av = Instance.new("BodyAngularVelocity", hrp)
        av.Name = "LuizTornado"
        av.AngularVelocity = Vector3.new(0, 999999, 0)
        av.MaxTorque = Vector3.new(0, math.huge, 0)
        task.spawn(function()
            while tornadoActive do
                for _, v in pairs(getChar():GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end
                RunService.Stepped:Wait()
            end
        end)
    else
        if getHRP():FindFirstChild("LuizTornado") then getHRP().LuizTornado:Destroy() end
    end
end)

addOption("APOCALIPSE (LIMPAR TUDO)", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(lp.Character) then
            v.CFrame = CFrame.new(0, -10000, 0)
        end
    end
end)

-- --- SISTEMA DE ARRASTE ---
local function drag(gui)
    local dragging, dragStart, startPos
    gui.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true dragStart = i.Position startPos = gui.Position end end)
    UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local delta = i.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end end)
    gui.InputEnded:Connect(function() dragging = false end)
end
drag(main) drag(openIcon)

-- Ativa menu após Intro
task.wait(3.5)
main.Visible = true
