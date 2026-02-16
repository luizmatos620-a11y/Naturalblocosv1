-- LUIZ MENU V1 - SUPREMACIA FINAL (ÍCONE + FLY ADMIN + TORNADO)
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local mouse = lp:GetMouse()

local function getChar() return lp.Character or lp.CharacterAdded:Wait() end
local function getHRP() return getChar():WaitForChild("HumanoidRootPart", 5) end

-- --- INTERFACE E ÍCONE ---
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "LuizMenu_V1_Supremacia"
sg.ResetOnSpawn = false

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 550, 0, 500)
main.Position = UDim2.new(0.5, -275, 0.5, -250)
main.BackgroundColor3 = Color3.fromRGB(5, 0, 0)
main.BorderSizePixel = 3
main.BorderColor3 = Color3.fromRGB(255, 0, 0)
main.Visible = true
Instance.new("UICorner", main)

local openIcon = Instance.new("ImageButton", sg)
openIcon.Size = UDim2.new(0, 70, 0, 70)
openIcon.Position = UDim2.new(0, 15, 0.5, -35)
openIcon.Image = "rbxassetid://11293318182" -- Ícone de Hacker
openIcon.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
openIcon.Visible = false
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)

-- Alternar entre Menu e Ícone
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
closeX.TextSize = 30
closeX.MouseButton1Click:Connect(toggle)

local container = Instance.new("ScrollingFrame", main)
container.Size = UDim2.new(1, -20, 1, -60)
container.Position = UDim2.new(0, 10, 0, 50)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 2, 0)
Instance.new("UIListLayout", container).Padding = UDim.new(0, 8)

local function addOption(txt, cb)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, -10, 0, 45)
    b.BackgroundColor3 = Color3.fromRGB(25, 0, 0)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 18
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- --- FUNÇÕES NOVAS ---

-- 1. FLY ADMIN (ESTÁTICO/FLUTUAR)
local flying = false
local flySpeed = 50
addOption("FLY ADMIN (ESTÁTICO)", function()
    flying = not flying
    local char = getChar()
    local hrp = getHRP()
    
    if flying then
        local bg = Instance.new("BodyGyro", hrp)
        bg.Name = "FlyGyro"
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = hrp.CFrame
        
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "FlyVel"
        bv.velocity = Vector3.new(0, 0.1, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        
        task.spawn(function()
            while flying do
                RunService.RenderStepped:Wait()
                local moveDir = char.Humanoid.MoveDirection
                if moveDir.Magnitude > 0 then
                    bv.velocity = moveDir * flySpeed
                else
                    bv.velocity = Vector3.new(0, 0, 0) -- Fica parado no ar
                end
                bg.cframe = workspace.CurrentCamera.CFrame
            end
            bg:Destroy()
            bv:Destroy()
        end)
    end
end)

-- 2. TORNADO MORTAL (GIRAR PARA MATAR)
local tornado = false
addOption("MODO TORNADO (GIRAR = KILL)", function()
    tornado = not tornado
    local hrp = getHRP()
    if tornado then
        local av = Instance.new("BodyAngularVelocity", hrp)
        av.Name = "TornadoGiro"
        av.MaxTorque = Vector3.new(0, math.huge, 0)
        av.AngularVelocity = Vector3.new(0, 80000, 0) -- Giro extremo
        
        -- Noclip automático para o giro não bater no chão e travar
        task.spawn(function()
            while tornado do
                for _, p in pairs(getChar():GetChildren()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
                RunService.Stepped:Wait()
            end
        end)
    else
        if hrp:FindFirstChild("TornadoGiro") then hrp.TornadoGiro:Destroy() end
    end
end)

-- 3. ESCUDO DE ENTULHO (ORBITAL) - Otimizado
_G.Shield = false
addOption("ESCUDO DE ENTULHO (ORBITAL)", function()
    _G.Shield = not _G.Shield
    local angle = 0
    task.spawn(function()
        while _G.Shield do
            angle = angle + 0.5
            local hrp = getHRP()
            if hrp then
                local count = 0
                for _, p in pairs(workspace:GetDescendants()) do
                    if p:IsA("BasePart") and not p.Anchored and not p:IsDescendantOf(lp.Character) then
                        if count > 30 then break end
                        local targetPos = hrp.Position + Vector3.new(math.cos(angle + count)*20, 5, math.sin(angle + count)*20)
                        p.CFrame = CFrame.new(targetPos)
                        p.Velocity = (targetPos - p.Position) * 60
                        count = count + 1
                    end
                end
            end
            task.wait(0.01)
        end
    end)
end)

-- --- FUNÇÕES DE ARRASTAR ---
local function makeDraggable(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true dragStart = input.Position startPos = gui.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    gui.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
end

makeDraggable(main)
makeDraggable(openIcon)

-- Opções Extras (Rápidas)
addOption("APOCALIPSE (LIMPAR MAPA)", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(lp.Character) then
            v.CFrame = CFrame.new(0, -10000, 0)
        end
    end
end)
