-- LUIZ MENU V1 - SUPREMACIA TOTAL (FLY CORRIGIDO + ANTI-DANO)
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
sg.Name = "LuizMenu_V1_Corrected"
sg.ResetOnSpawn = false

-- --- INTRO 3D ---
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
    task.wait(1.5)
    TweenService:Create(introText, info, {TextTransparency = 1, TextSize = 130}):Play()
    task.wait(0.5)
    introContainer:Destroy()
end)

-- --- INTERFACE ---
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

-- --- FUNÇÕES CORRIGIDAS ---

-- 1. FLY ADMIN V2 (DIREÇÃO CORRIGIDA + GOD MODE)
local flyActive = false
local flySpeed = 80
addOption("FLY ADMIN (FIXED + GOD MODE)", function()
    flyActive = not flyActive
    local char = getChar()
    local hrp = getHRP()
    local hum = char:FindFirstChildOfClass("Humanoid")
    
    if flyActive then
        -- Anti-Dano/God Mode enquanto voa
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "LuizFlyVel"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        
        local bg = Instance.new("BodyGyro", hrp)
        bg.Name = "LuizFlyGyro"
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        
        task.spawn(function()
            while flyActive do
                RunService.RenderStepped:Wait()
                hrp.CanCollide = false -- Noclip enquanto voa para não tomar dano de batida
                
                local moveDir = hum.MoveDirection
                if moveDir.Magnitude > 0 then
                    -- Cálculo de direção corrigido (segue para onde você olha)
                    bv.Velocity = Camera.CFrame.LookVector * (moveDir.Z < 0 and flySpeed or -flySpeed) + 
                                  Camera.CFrame.RightVector * (moveDir.X > 0 and flySpeed or -flySpeed)
                else
                    bv.Velocity = Vector3.new(0, 0, 0)
                end
                bg.CFrame = Camera.CFrame
            end
            bv:Destroy() bg:Destroy()
            hum.MaxHealth = 100
            hrp.CanCollide = true
        end)
    end
end)

-- 2. ESCUDO DE ENTULHO (ANTI-MORTE)
local shieldActive = false
addOption("ESCUDO MORTAL (SÓ MATA OS OUTROS)", function()
    shieldActive = not shieldActive
    local angle = 0
    task.spawn(function()
        while shieldActive do
            angle = angle + 0.8
            local hrp = getHRP()
            if hrp then
                local count = 0
                for _, p in pairs(workspace:GetDescendants()) do
                    if p:IsA("BasePart") and not p.Anchored and not p:IsDescendantOf(lp.Character) then
                        if count > 30 then break end
                        local targetPos = hrp.Position + Vector3.new(math.cos(angle + count)*22, 5, math.sin(angle + count)*22)
                        p.CanCollide = false -- Não te machuca
                        p.CFrame = CFrame.new(targetPos)
                        p.Velocity = (targetPos - p.Position) * 80
                        p.RotVelocity = Vector3.new(100, 100, 100)
                        count = count + 1
                    end
                end
            end
            task.wait(0.01)
        end
    end)
end)

-- 3. TORNADO KILL
local tornadoActive = false
addOption("MODO TORNADO (GIRAR = KILL)", function()
    tornadoActive = not tornadoActive
    local hrp = getHRP()
    if tornadoActive then
        local av = Instance.new("BodyAngularVelocity", hrp)
        av.AngularVelocity = Vector3.new(0, 999999, 0)
        av.MaxTorque = Vector3.new(0, math.huge, 0)
        task.spawn(function()
            while tornadoActive do
                for _, v in pairs(getChar():GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end
                RunService.Stepped:Wait()
            end
        end)
    else
        if getHRP():FindFirstChildOfClass("BodyAngularVelocity") then getHRP():FindFirstChildOfClass("BodyAngularVelocity"):Destroy() end
    end
end)

-- Arrastar
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

task.wait(3.5)
main.Visible = true
