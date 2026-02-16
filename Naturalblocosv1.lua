-- LUIZ MENU V1 - OMNI HERO & REAL TORNADO (DELTA/MOBILE)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LUIZ MENU V1 👑",
   LoadingTitle = "Injetando Física de Colisão...",
   LoadingSubtitle = "por Luiz",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

local lp = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- --- ABA TORNADO (LIQUIDIFICADOR REAL) ---
local TabTornado = Window:CreateTab("Tornado Real 🌪️", 4483362458)

TabTornado:CreateToggle({
   Name = "Liquidificador de Spawn 🌀",
   CurrentValue = false,
   Callback = function(Value)
      _G.RealTornado = Value
      local angulo = 0
      
      task.spawn(function()
         while _G.RealTornado do
            angulo = angulo + 0.4
            local contador = 0
            
            -- Raio de busca focado no Spawn (Ilha principal)
            for _, item in pairs(workspace:GetDescendants()) do
               if item:IsA("BasePart") and not item.Anchored and not item:IsDescendantOf(lp.Character) then
                  -- Filtro: Apenas objetos pequenos (tamanho menor que 7)
                  if item.Size.Magnitude < 10 then
                     -- Filtro de Distância: Apenas se estiver perto do jogador (ou no spawn)
                     local dist = (lp.Character.HumanoidRootPart.Position - item.Position).Magnitude
                     if dist < 50 then
                        if contador > 50 then break end
                        
                        -- Física de Liquidificador (Orbital)
                        local targetPos = lp.Character.HumanoidRootPart.CFrame * CFrame.new(math.cos(angulo + contador) * 12, 2 + math.sin(angulo * 0.5) * 5, math.sin(angulo + contador) * 12).Position
                        
                        -- Aplica Velocidade Real (Pra não ser só visual)
                        item.Velocity = (targetPos - item.Position) * 30
                        item.RotVelocity = Vector3.new(20, 20, 20)
                        
                        contador = contador + 1
                     end
                  end
               end
            end
            RunService.Heartbeat:Wait()
         end
      end)
   end,
})

-- --- ABA SOBREVIVENTES (HERÓI & BALÃO) ---
local TabHeroi = Window:CreateTab("Sobreviventes 🛡️", 4483362458)

TabHeroi:CreateToggle({
   Name = "Voo do Superman 🦸‍♂️",
   CurrentValue = false,
   Callback = function(Value)
      _G.FlyHero = Value
      if Value then
         local hrp = lp.Character.HumanoidRootPart
         local bg = Instance.new("BodyGyro", hrp)
         bg.P = 9e4
         bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
         local bv = Instance.new("BodyVelocity", hrp)
         bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
         
         task.spawn(function()
            local t = 0
            while _G.FlyHero do
               t = t + 0.1
               local moveDir = lp.Character.Humanoid.MoveDirection
               if moveDir.Magnitude > 0 then
                  bv.Velocity = moveDir * 60
                  bg.CFrame = CFrame.new(hrp.Position, hrp.Position + moveDir) * CFrame.Angles(math.rad(-30), 0, 0)
               else
                  bv.Velocity = Vector3.new(0, math.sin(t * 2) * 0.6, 0)
                  bg.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Camera.CFrame.LookVector * 10)
               end
               task.wait()
            end
            bg:Destroy() bv:Destroy()
         end)
      end
   end,
})

TabHeroi:CreateButton({
   Name = "Ativar Balão 🎈",
   Callback = function()
      local bf = Instance.new("BodyForce", lp.Character.HumanoidRootPart)
      bf.Force = Vector3.new(0, workspace.Gravity * lp.Character.HumanoidRootPart:GetMass() * 0.9, 0)
   end,
})

-- --- ABA AURA (FLING ESTÁVEL) ---
local TabAura = Window:CreateTab("AURA ♾️", 4483362458)

TabAura:CreateToggle({
   Name = "Fling Supremacia 🌀",
   CurrentValue = false,
   Callback = function(Value)
      _G.Fling = Value
      if Value then
         task.spawn(function()
            local hrp = lp.Character.HumanoidRootPart
            local gyro = Instance.new("BodyGyro", hrp)
            gyro.MaxTorque = Vector3.new(9e9, 0, 9e9) -- Impede de deitar
            while _G.Fling do
               for _, v in pairs(lp.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
               hrp.RotVelocity = Vector3.new(0, 15000, 0)
               hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
               
               for _, p in pairs(game.Players:GetPlayers()) do
                  if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                     if (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude < 8 then
                        p.Character.HumanoidRootPart.Velocity = Vector3.new(60000, 60000, 60000)
                     end
                  end
               end
               RunService.Heartbeat:Wait()
            end
            gyro:Destroy()
         end)
      end
   end,
})

-- --- ABA MUNDO & PVP ---
local TabPvP = Window:CreateTab("PvP & Mundo 🌎", 4483362458)

TabPvP:CreateButton({
   Name = "Hitbox Gigante 📦",
   Callback = function()
      for _, p in pairs(game.Players:GetPlayers()) do
         if p ~= lp and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.Size = Vector3.new(15, 15, 15) hrp.Transparency = 0.7 end
         end
      end
   end,
})

TabPvP:CreateToggle({
   Name = "Aviso de Desastres ⚡",
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

Rayfield:Notify({Title = "TORNADO FIXADO", Content = "O liquidificador agora usa física real no spawn!", Duration = 5})
