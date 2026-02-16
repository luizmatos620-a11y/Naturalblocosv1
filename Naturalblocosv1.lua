-- LUIZ MENU V1 - OMNIPOTENCE X (SISTEMA DE ABAS)
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local function getChar() return lp.Character or lp.CharacterAdded:Wait() end
local function getHRP() return getChar():WaitForChild("HumanoidRootPart", 5) end

-- --- INTERFACE DE ABAS ---
local sg = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 650, 0, 500)
main.Position = UDim2.new(0.5, -325, 0.5, -250)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.BorderSizePixel = 0
Instance.new("UICorner", main)

-- Borda Neon
local border = Instance.new("Frame", main)
border.Size = UDim2.new(1, 4, 1, 4)
border.Position = UDim2.new(0, -2, 0, -2)
border.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
border.ZIndex = 0
Instance.new("UICorner", border)

-- Header de Abas
local tabHolder = Instance.new("Frame", main)
tabHolder.Size = UDim2.new(1, 0, 0, 50)
tabHolder.BackgroundTransparency = 1

local container = Instance.new("Frame", main)
container.Size = UDim2.new(1, -20, 1, -70)
container.Position = UDim2.new(0, 10, 0, 60)
container.BackgroundTransparency = 1

local layouts = {}
local function createTab(name, pos)
    local b = Instance.new("TextButton", tabHolder)
    b.Size = UDim2.new(0.25, 0, 1, 0)
    b.Position = UDim2.new(pos * 0.25, 0, 0, 0)
    b.Text = name
    b.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Code
    b.TextSize = 18
    
    local scroll = Instance.new("ScrollingFrame", container)
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.Visible = (pos == 0)
    scroll.CanvasSize = UDim2.new(0, 0, 5, 0)
    scroll.ScrollBarThickness = 2
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 5)
    
    b.MouseButton1Click:Connect(function()
        for _, v in pairs(layouts) do v.Visible = false end
        scroll.Visible = true
    end)
    
    table.insert(layouts, scroll)
    return scroll
end

local tabDestruicao = createTab("COMBATE", 0)
local tabFisica = createTab("FÍSICA", 1)
local tabVisual = createTab("VISUAL", 2)
local tabMundo = createTab("MUNDO", 3)

local function addOpt(tab, txt, cb)
    local b = Instance.new("TextButton", tab)
    b.Size = UDim2.new(1, -10, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(35, 0, 0)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Code
    b.TextSize = 16
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- --- ABA 1: COMBATE (MORTAL) ---
addOpt(tabDestruicao, "FLING AURA (INSTANT KILL)", function()
    _G.Fling = not _G.Fling
    task.spawn(function()
        while _G.Fling do
            getHRP().Velocity = Vector3.new(999999, 999999, 999999)
            getHRP().RotVelocity = Vector3.new(999999, 999999, 999999)
            RunService.Heartbeat:Wait()
        end
    end)
end)
addOpt(tabDestruicao, "KILL ALL (TP FLING)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            getHRP().CFrame = p.Character.HumanoidRootPart.CFrame
            getHRP().Velocity = Vector3.new(100000, 100000, 100000)
            task.wait(0.1)
        end
    end
end)
addOpt(tabDestruicao, "BRING ALL (Puxar Todos)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then p.Character.HumanoidRootPart.CFrame = getHRP().CFrame end
    end
end)
addOpt(tabDestruicao, "FREEZE ALL (Congelar)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then p.Character.HumanoidRootPart.Anchored = true end
    end
end)
addOpt(tabDestruicao, "UNFREEZE ALL", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then p.Character.HumanoidRootPart.Anchored = false end
    end
end)
addOpt(tabDestruicao, "OBLITERAR CABEÇAS", function()
    for _, p in pairs(Players:GetPlayers()) do if p ~= lp and p.Character:FindFirstChild("Head") then p.Character.Head:Destroy() end end
end)
addOpt(tabDestruicao, "SENTAR TODOS", function()
    for _, p in pairs(Players:GetPlayers()) do if p ~= lp then p.Character.Humanoid.Sit = true end end
end)
addOpt(tabDestruicao, "REMOVER FERRAMENTAS", function()
    for _, p in pairs(Players:GetPlayers()) do p.Character:FindFirstChildOfClass("Tool"):Destroy() end
end)

-- --- ABA 2: FÍSICA (DESTRUIÇÃO) ---
addOpt(tabFisica, "MAGNETO SHIELD (Puxar Itens)", function()
    _G.MS = not _G.MS
    task.spawn(function()
        while _G.MS do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and not v.Anchored then v.Velocity = (getHRP().Position - v.Position).Unit * 150 end
            end
            task.wait(0.1)
        end
    end)
end)
addOpt(tabFisica, "FLY OMNI (150 SPD)", function()
    _G.Fly = not _G.Fly
    local bv = Instance.new("BodyVelocity", getHRP())
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    task.spawn(function()
        while _G.Fly do
            bv.Velocity = Camera.CFrame.LookVector * 150
            RunService.RenderStepped:Wait()
        end
        bv:Destroy()
    end)
end)
addOpt(tabFisica, "SPEED 300", function() lp.Character.Humanoid.WalkSpeed = 300 end)
addOpt(tabFisica, "JUMP 500", function() lp.Character.Humanoid.JumpPower = 500 end)
addOpt(tabFisica, "NOCLIP (Atravessar)", function()
    _G.NC = not _G.NC
    RunService.Stepped:Connect(function()
        if _G.NC then for _, v in pairs(getChar():GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end end
    end)
end)
addOpt(tabFisica, "GRAVIDADE ZERO", function() workspace.Gravity = 0 end)
addOpt(tabFisica, "GRAVIDADE 500", function() workspace.Gravity = 500 end)
addOpt(tabFisica, "ANTI-QUEDA", function() lp.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0) end)

-- --- ABA 3: VISUAL (ESP/GOD) ---
addOpt(tabVisual, "ESP NAMES (Nomes)", function()
    for _, p in pairs(Players:GetPlayers()) do
        local bg = Instance.new("BillboardGui", p.Character.Head)
        bg.Size = UDim2.new(0,100,0,50); bg.AlwaysOnTop = true
        local tl = Instance.new("TextLabel", bg)
        tl.Text = p.Name; tl.Size = UDim2.new(1,0,1,0); tl.TextColor3 = Color3.fromRGB(255,0,0); tl.BackgroundTransparency = 1
    end
end)
addOpt(tabVisual, "HIGHLIGHT ALL (Brilho)", function()
    for _, p in pairs(Players:GetPlayers()) do Instance.new("Highlight", p.Character) end
end)
addOpt(tabVisual, "FULL BRIGHT", function() game.Lighting.Brightness = 5; game.Lighting.ClockTime = 12 end)
addOpt(tabVisual, "REMOVER TEXTURAS (FPS)", function()
    for _, v in pairs(workspace:GetDescendants()) do if v:IsA("Texture") or v:IsA("Decal") then v:Destroy() end end
end)
addOpt(tabVisual, "FOG REMOVER", function() game.Lighting.FogEnd = 999999 end)
addOpt(tabVisual, "INVISÍVEL (Local)", function()
    for _, v in pairs(getChar():GetChildren()) do if v:IsA("BasePart") then v.Transparency = 0.5 end end
end)
addOpt(tabVisual, "CHAM ESP", function()
    for _, p in pairs(Players:GetPlayers()) do
        local box = Instance.new("BoxHandleAdornment", p.Character)
        box.Size = Vector3.new(4,6,0.1); box.AlwaysOnTop = true; box.Adornee = p.Character; box.Color3 = Color3.fromRGB(255,0,0)
    end
end)

-- --- ABA 4: MUNDO (CHAOS) ---
addOpt(tabMundo, "DELETE MAP (Sem Anchored)", function()
    for _, v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") and not v.Anchored then v:Destroy() end end
end)
addOpt(tabMundo, "VOID ALL PARTS", function()
    for _, v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") and not v.Anchored then v.CFrame = CFrame.new(0,-1000,0) end end
end)
addOpt(tabMundo, "TERREMOTO INSANO", function()
    for _, v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") and not v.Anchored then v.Velocity = Vector3.new(1000,1000,1000) end end
end)
addOpt(tabMundo, "SPAM CHAT", function()
    for i=1,10 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("LUIZ MENU V1 OWNED", "All") end
end)
addOpt(tabMundo, "REJOIN", function() game:GetService("TeleportService"):Teleport(game.PlaceId, lp) end)
addOpt(tabMundo, "SERVER LAG", function()
    while task.wait() do for i=1,100 do Instance.new("Part", workspace).Velocity = Vector3.new(999,999,999) end end
end)
addOpt(tabMundo, "CARREGAR IY", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)

-- Ícone
local icon = Instance.new("ImageButton", sg)
icon.Size = UDim2.new(0, 60, 0, 60)
icon.Position = UDim2.new(0, 10, 0.4, 0)
icon.Image = "rbxassetid://11293318182"
icon.BackgroundColor3 = Color3.fromRGB(20,0,0)
Instance.new("UICorner", icon).CornerRadius = UDim.new(1,0)
icon.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
