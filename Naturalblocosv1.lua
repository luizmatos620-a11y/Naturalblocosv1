-- LUIZ MENU V1 - DELTA ESTÁVEL (ANTI-CAPOTAR)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LUIZ MENU V1 👑",
   LoadingTitle = "Estabilizando Giroscópios...",
   LoadingSubtitle = "por Luiz",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

local lp = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- --- ABA 1: PVP ELITE (ARMAS) 🎯 ---
local TabPvP = Window:CreateTab("PvP Elite 🎯", 4483362458)

TabPvP:CreateToggle({
   Name = "Aimbot Lock-On 🔫",
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
            if target then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Character.Head.Position), 0.1) end
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
            if hrp then hrp.Size = Vector3.new(15, 15, 15) hrp.Transparency = 0.7 hrp.CanCollide = false end
         end
      end
   end,
})

-- --- ABA 2: SOBREVIVENTES 🛡️ ---
local TabSobrevivencia = Window:CreateTab("Sobreviventes 🛡️", 4483362458)

TabSobrevivencia:CreateButton({
   Name = "Teleporte: Ilha Segura 🏝️",
   Callback = function() lp.Character.HumanoidRootPart.CFrame = CFrame.new(-285, 180, 380) end,
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

-- --- ABA 3: AURA (FLING EIXO TRAVADO) ♾️ ---
local TabAura = Window:CreateTab("AURA ♾️", 4483362458)

TabAura:CreateToggle({
   Name = "Fling Estabilizado (Não Deita) 🌀",
   CurrentValue = false,
   Callback = function(Value)
      _G.Fling = Value
      if Value then
         task.spawn(function()
            local hrp = lp.Character.HumanoidRootPart
            
            -- Giroscópio para manter o boneco EM PÉ (90 graus)
            local gyro = Instance.new("BodyGyro")
            gyro.P = 9e4
            gyro.MaxTorque = Vector3.new(9e9, 0, 9e9) -- Trava os eixos X e Z (não capota)
            gyro.CFrame = hrp.CFrame
            gyro.Parent = hrp

            -- Força para não afundar
            local float = Instance.new("BodyVelocity")
            float.MaxForce = Vector3.new(0, math.huge, 0)
            float.Velocity = Vector3.new(0, 0, 0)
            float.Parent = hrp

            while _G.Fling do
               if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                  -- Noclip constante
                  for _, v in pairs(lp.Character:GetDescendants()) do
                     if v:IsA("BasePart") then v.CanCollide = false end
                  end
                  
                  -- Rotação apenas no eixo Y (Vertical)
                  hrp.RotVelocity = Vector3.new(0, 10000, 0)
                  
                  -- Ataque Ativo nos players próximos
                  for _, p in pairs(game.Players:GetPlayers()) do
                     if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local pRoot = p.Character.HumanoidRootPart
                        if (hrp.Position - pRoot.Position).Magnitude < 8 then
                           pRoot.Velocity = Vector3.new(50000, 50000, 50000)
                        end
                     end
                  end
               end
               RunService.Heartbeat:Wait()
            end
            
            gyro:Destroy()
            float:Destroy()
         end)
      end
   end,
})

TabAura:CreateToggle({
   Name = "Tornado de Objetos 🌪️",
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
                  v.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(math.cos(a+c)*15, 5, math.sin(a+c)*15)
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
                  Instance.new("Highlight", v).FillColor = Color3.fromRGB(255, 0, 0)
               end
            end
            task.wait(0.5)
         end
      end)
   end,
})

-- --- ABA 5: CONFIGURAÇÕES ⚙️ ---
local TabConfig = Window:CreateTab("Config ⚙️", 4483362458)
TabConfig:CreateButton({ Name = "Fechar Menu ❌", Callback = function() Rayfield:Destroy() end })

Rayfield:Notify({Title = "ESTABILIDADE OK", Content = "Giroscópio ativado. Você não vai mais capotar!", Duration = 5})
