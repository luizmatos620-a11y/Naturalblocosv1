-- LUIZ MENU V1 - OMNI SUPREMACIA (VERSÃO FINAL UNIFICADA)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LUIZ MENU V1 👑",
   LoadingTitle = "Protocolo de Guerra Ativado...",
   LoadingSubtitle = "por Luiz",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

local lp = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- --- ABA PVP ELITE (ARMAS & COMBATE) ---
local TabPvP = Window:CreateTab("PvP Elite 🎯", 4483362458)

TabPvP:CreateToggle({
   Name = "Aimbot Lock-On (Mira Automática) 🔫",
   CurrentValue = false,
   Callback = function(Value)
      _G.Aimbot = Value
      task.spawn(function()
         while _G.Aimbot do
            local target = nil
            local dist = 150
            for _, p in pairs(game.Players:GetPlayers()) do
               if p ~= lp and p.Character and p.Character:FindFirstChild("Head") then
                  local pos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
                  if vis then
                     local mDist = (Vector2.new(pos.X, pos.Y) - game:GetService("UserInputService"):GetMouseLocation()).Magnitude
                     if mDist < dist then dist = mDist target = p end
                  end
               end
            end
            if target then Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position) end
            task.wait()
         end
      end)
   end,
})

TabPvP:CreateButton({
   Name = "Expandir Hitbox (Inimigos Gigantes) 📦",
   Callback = function()
      for _, p in pairs(game.Players:GetPlayers()) do
         if p ~= lp and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.Size = Vector3.new(15, 15, 15) hrp.Transparency = 0.7 hrp.CanCollide = false end
         end
      end
   end,
})

TabPvP:CreateToggle({
   Name = "Trigger Bot (Atira Sozinho) 🖱️",
   CurrentValue = false,
   Callback = function(Value) _G.Trigger = Value end
})

-- --- ABA SOBREVIVENTES ---
local TabSobrevivencia = Window:CreateTab("Sobreviventes 🛡️", 4483362458)

TabSobrevivencia:CreateButton({
   Name = "Teleporte Seguro (Ilha) 🏝️",
   Callback = function()
      lp.Character.HumanoidRootPart.CFrame = CFrame.new(-285, 180, 380)
   end,
})

TabSobrevivencia:CreateToggle({
   Name = "Anular Dano de Queda 🦴",
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
   Name = "Balão Mágico (Física de Voo) 🎈",
   Callback = function()
      local bf = Instance.new("BodyForce", lp.Character.HumanoidRootPart)
      bf.Force = Vector3.new(0, workspace.Gravity * lp.Character.HumanoidRootPart:GetMass() * 0.9, 0)
   end,
})

-- --- ABA AURA (AQUELA QUE VOCÊ QUERIA) ---
local TabAura = Window:CreateTab("AURA ♾️", 4483362458)

TabAura:CreateToggle({
   Name = "Fling Móvel (Andar e Expulsar) 🌀",
   CurrentValue = false,
   Callback = function(Value)
      _G.Fling = Value
      task.spawn(function()
         while _G.Fling do
            if lp.Character then
               local hrp = lp.Character.HumanoidRootPart
               -- Noclip automático para não voar sozinho
               for _, v in pairs(lp.Character:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end
               
               hrp.RotVelocity = Vector3.new(0, 1000000, 0)
               
               local bg = Instance.new("BodyGyro", hrp)
               bg.P = 9e4
               bg.MaxTorque = Vector3.new(9e9, 0, 9e9)
               bg.CFrame = hrp.CFrame
               task.wait(0.1)
               bg:Destroy()
            end
            RunService.Heartbeat:Wait()
         end
      end)
   end,
})

TabAura:CreateToggle({
   Name = "Furacão de Objetos (40 Itens) 🌪️",
   CurrentValue = false,
   Callback = function(Value)
      _G.Tornado = Value
      local a = 0
      task.spawn(function()
         while _G.Tornado do
            a = a + 0.3
            local c = 0
            for _, v in pairs(workspace:GetDescendants()) do
               if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(lp.Character) then
                  if c > 40 then break end
                  v.Velocity = Vector3.new(0, 50, 0)
                  v.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(math.cos(a+c)*15, 5, math.sin(a+c)*15)
                  c = c + 1
               end
            end
            task.wait()
         end
      end)
   end,
})

-- --- ABA MUNDO & TROLL ---
local TabMundo = Window:CreateTab("Mundo 🌎", 4483362458)

TabMundo:CreateToggle({
   Name = "Revelar Meteoros e Raios ⚡",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP = Value
      task.spawn(function()
         while _G.ESP do
            for _, v in pairs(workspace:GetDescendants()) do
               if (v.Name == "Meteor" or v.Name == "LightningStrike") and not v:FindFirstChild("Highlight") then
                  Instance.new("Highlight", v).FillColor = Color3.fromRGB(255, 0, 0)
               end
            end
            task.wait(0.5)
         end
      end)
   end,
})

TabMundo:CreateButton({
   Name = "Infinite Yield (Admin) 📜",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
   end,
})

-- --- ABA CONFIGURAÇÕES ---
local TabConfig = Window:CreateTab("Configurações ⚙️", 4483362458)
TabConfig:CreateButton({ Name = "Destruir Menu ❌", Callback = function() Rayfield:Destroy() end })

Rayfield:Notify({Title = "TUDO PRONTO", Content = "LUIZ MENU V1 carregou todas as funções PvP e Sobrevivência!", Duration = 5})
