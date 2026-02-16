-- LUIZ MENU V1 - OMNIPOTENCE EDITION (20+ OPÇÕES REAIS)
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local function getChar() return lp.Character or lp.CharacterAdded:Wait() end
local function getHRP() return getChar():WaitForChild("HumanoidRootPart", 5) end

-- --- INTERFACE OMNI ---
local sg = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 600, 0, 500)
main.Position = UDim2.new(0.5, -300, 0.5, -250)
main.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
main.BorderSizePixel = 3
main.BorderColor3 = Color3.fromRGB(255, 0, 0)
Instance.new("UICorner", main)

local container = Instance.new("ScrollingFrame", main)
container.Size = UDim2.new(1, -20, 1, -80)
container.Position = UDim2.new(0, 10, 0, 70)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 6, 0) -- Espaço para muitas opções
Instance.new("UIListLayout", container).Padding = UDim.new(0, 8)

local function addOption(txt, cb)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, -15, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Code
    b.TextSize = 16
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(cb)
end

-- --- ARSENAL DE 20+ OPÇÕES ---

-- [ CATEGORIA: DESTRUIÇÃO DE PLAYERS ]
addOption("1. FLING AURA (TOQUE MORTAL)", function()
    _G.Fling = not _G.Fling
    task.spawn(function()
        while _G.Fling do
            getHRP().Velocity = Vector3.new(0, 10000, 0)
            getHRP().RotVelocity = Vector3.new(10000, 10000, 10000)
            task.wait()
        end
    end)
end)

addOption("2. BRING ALL (TRAZER VÍTIMAS)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then p.Character.HumanoidRootPart.CFrame = getHRP().CFrame * CFrame.new(0, 0, -5) end
    end
end)

addOption("3. FREEZE ALL (CONGELAR SERVIDOR)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then p.Character.HumanoidRootPart.Anchored = true end
    end
end)

addOption("4. UNFREEZE ALL (DESCONGELAR)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then p.Character.HumanoidRootPart.Anchored = false end
    end
end)

addOption("5. YEET ALL (LANÇAR TODOS AO CÉU)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then p.Character.HumanoidRootPart.Velocity = Vector3.new(0, 5000, 0) end
    end
end)

addOption("6. KILL NEAREST (MATAR PRÓXIMO)", function()
    local target = nil
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and (p.Character.HumanoidRootPart.Position - getHRP().Position).Magnitude < 50 then
            p.Character.HumanoidRootPart.Velocity = Vector3.new(100000, 100000, 100000)
        end
    end
end)

-- [ CATEGORIA: MANIPULAÇÃO DO MAPA ]
addOption("7. VOID MAP (MANDAR MAPA PRO VÁCUO)", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v.Anchored then v.CFrame = CFrame.new(0, -500, 0) end
    end
end)

addOption("8. GRAVITY ZERO (FLUTUAR TUDO)", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v.Anchored then v.Velocity = Vector3.new(0, 50, 0) end
    end
end)

addOption("9. BLACK HOLE (BURACO NEGRO)", function()
    _G.BH = not _G.BH
    task.spawn(function()
        while _G.BH do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and not v.Anchored then v.Velocity = (getHRP().Position - v.Position).Unit * 100 end
            end
            task.wait(0.1)
        end
    end)
end)

addOption("10. EXPLODE MAP (PHYSICS CHAOS)", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v.Anchored then v.Velocity = Vector3.new(math.random(-500,500), 500, math.random(-500,500)) end
    end
end)

-- [ CATEGORIA: MOVIMENTAÇÃO GOD ]
addOption("11. FLY ADMIN (CONTROLE TOTAL)", function()
    _G.Fly = not _G.Fly
    local bv = Instance.new("BodyVelocity", getHRP())
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    task.spawn(function()
        while _G.Fly do
            bv.Velocity = Camera.CFrame.LookVector * 100
            RunService.RenderStepped:Wait()
        end
        bv:Destroy()
    end)
end)

addOption("12. SPEED HACK (300 KM/H)", function() lp.Character.Humanoid.WalkSpeed = 300 end)
addOption("13. JUMP POWER (GOD JUMP)", function() lp.Character.Humanoid.JumpPower = 500 end)
addOption("14. NOCLIP (ATRAVESSAR TUDO)", function()
    _G.NC = not _G.NC
    RunService.Stepped:Connect(function()
        if _G.NC then for _, v in pairs(getChar():GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end end
    end)
end)

addOption("15. TELEPORT TO RANDOM PLAYER", function()
    local r = Players:GetPlayers()[math.random(1, #Players:GetPlayers())]
    if r ~= lp then getHRP().CFrame = r.Character.HumanoidRootPart.CFrame end
end)

-- [ CATEGORIA: VISUAL E EXTRA ]
addOption("16. ESP NAMES (VER NOMES)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local b = Instance.new("BillboardGui", p.Character.Head)
            b.AlwaysOnTop = true b.Size = UDim2.new(0, 200, 0, 50)
            local t = Instance.new("TextLabel", b)
            t.Text = p.Name t.Size = UDim2.new(1, 0, 1, 0) t.TextColor3 = Color3.fromRGB(255, 0, 0) t.BackgroundTransparency = 1
        end
    end
end)

addOption("17. CHAT SPAM (DOMINAÇÃO)", function()
    for i = 1, 5 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("LUIZ MENU DOMINA!", "All") end
end)

addOption("18. DELETE MY LIMBS (GHOST MODE)", function()
    for _, v in pairs(getChar():GetChildren()) do if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then v:Destroy() end end
end)

addOption("19. INFINITE YIELD (CARREGAR TUDO)", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)

addOption("20. REJOIN SERVER (RESET)", function() game:GetService("TeleportService"):Teleport(game.PlaceId, lp) end)

addOption("21. DESTROY GUI (FECHAR TUDO)", function() sg:Destroy() end)

-- --- ÍCONE ---
local icon = Instance.new("ImageButton", sg)
icon.Size = UDim2.new(0, 60, 0, 60)
icon.Position = UDim2.new(0, 10, 0.2, 0)
icon.Image = "rbxassetid://6031097225" -- Ícone de Engrenagem
icon.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
