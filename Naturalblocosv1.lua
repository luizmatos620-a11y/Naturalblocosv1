-- LUIZ MENU V1 - EDIÇÃO ESPECIAL DELTA/MOBILE
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LUIZ MENU V1 👑 (DELTA)",
   LoadingTitle = "Injetando Protocolos Mobile...",
   LoadingSubtitle = "por Luiz",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

local lp = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- --- ABA 1: PVP ELITE 🎯 ---
local TabPvP = Window:CreateTab("PvP Elite 🎯", 4483362458)

TabPvP:CreateToggle({
   Name = "Mira Automática (Aimbot) 🔫",
   CurrentValue = false,
   Callback = function(Value)
      _G.Aimbot = Value
      task.spawn(function()
         while _G.Aimbot do
            local target = nil
            local dist = 180
            for _, p in pairs(game.Players:GetPlayers()) do
               if p ~= lp and p.Character and p.Character:FindFirstChild("Head") then
                  local pos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
                  if vis then
                     local mDist = (Vector2.new(pos.X, pos.Y) - game:GetService("UserInputService"):GetMouseLocation()).Magnitude
                     if mDist < dist then dist = mDist target = p end
                  end
               end
            end
            if target then
               -- Suavização para não bugar no mobile
               Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Character.Head.Position), 0.1)
            end
            task.wait()
         end
      end)
   end,
})

TabPvP:CreateButton({
   Name = "Hitbox Gigante 📦",
   Callback = function()
      for _, p in pairs(game.Players:GetPlayers()) do
         if p ~= lp and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then 
               hrp.Size = Vector3.new(15, 15, 15) 
               hrp.Transparency = 0.7 
               hrp.CanCollide = false 
            end
         end
      end
   end,
})

-- --- ABA 2: SOBREviventes 🛡️ ---
local TabSobrevivencia = Window:CreateTab("Sobreviventes 🛡️", 4483362458)

TabSobrevivencia:CreateButton({
   Name = "Teleporte: Ilha Segura 🏝️",
   Callback = function()
      lp.Character.HumanoidRootPart.CFrame = CFrame.new(-285, 180, 380)
   end,
})

TabSobrevivencia:CreateToggle({
   Name = "Sem Dano de Queda 🦴",
   CurrentValue = false,
   Callback = function(Value)
      _G.NoFall = Value
      task.spawn(function()
         while _G.NoFall do
            if lp.Character and lp.Character:FindFirstChild("FallDamageScript", true) then
               lp.Character:FindFirstChild("FallDamageScript", true).Disabled = true
            end
            task.wait(1)
         end
      end)
   end,
})

TabSobrevivencia:CreateButton({
   Name = "Ativar Balão 🎈",
   Callback = function()
      local bf = Instance.new("BodyForce", lp.Character.HumanoidRootPart)
      bf.Force = Vector3.new(0, workspace.Gravity * lp.Character.HumanoidRootPart:GetMass() * 0.9, 0)
   end,
})

-- --- ABA 3: AURA ♾️ (FIX PARA MOBILE) ---
local TabAura = Window:CreateTab("AURA ♾️", 4483362458)

TabAura:CreateToggle({
   Name = "Fling Assassino (Móvel) 🌀",
   CurrentValue = false,
   Callback = function(Value)
      _G.Fling = Value
      task.spawn(function()
         while _G.Fling do
            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
               local hrp = lp.Character.HumanoidRootPart
               
               -- Noclip Constante para Mobile
               for _, v in pairs(lp.Character:GetDescendants()) do
                  if v:IsA("BasePart") then v.CanCollide = false end
               end
               
               -- Gira o boneco mas trava a altura (Eixo Y) para não voar sozinho
               hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z) 
               hrp.RotVelocity = Vector3.new(0, 3000, 0) -- Velocidade ideal para Mobile
            end
            RunService.Heartbeat:Wait()
         end
      end)
   end,
})

TabAura:CreateToggle({
   Name = "Furacão de Objetos 🌪️",
   CurrentValue = false,
   Callback = function(Value)
      _G.Tornado = Value
      local angulo = 0
      task.spawn(function()
         while _G.Tornado do
            angulo = angulo + 0.3
            local c = 0
            for _, v in pairs(workspace:GetDescendants()) do
               if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(lp.Character) then
                  if c > 40 then break end
                  v.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(math.cos(angulo+c)*15, 5, math.sin(angulo+c)*15)
                  c = c + 1
               end
            end
            task.wait()
         end
      end)
   end,
})

-- --- ABA 4: MUNDO 🌎 ---
local TabMundo = Window:CreateTab("Mundo 🌎", 4483362458)

TabMundo:CreateToggle({
   Name = "Aviso de Meteoros/Raios ⚡",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP = Value
      task.spawn(function()
         while _G.ESP do
            for _, v in pairs(workspace:GetDescendants()) do
               if (v.Name == "Meteor" or v.Name == "LightningStrike") and not v:FindFirstChild("Highlight") then
                  local hl = Instance.new("Highlight", v)
                  hl.FillColor = Color3.fromRGB(255, 0, 0)
               end
            end
            task.wait(0.5)
         end
      end)
   end,
})

-- --- ABA 5: CONFIGURAÇÕES ⚙️ ---
local TabConfig = Window:CreateTab("Config ⚙️", 4483362458)

TabConfig:CreateButton({
   Name = "Fechar Menu ❌",
   Callback = function() Rayfield:Destroy() end
})

Rayfield:Notify({Title = "MONSTRO ATIVADO", Content = "Luiz Menu pronto para Delta Mobile!", Duration = 5})
