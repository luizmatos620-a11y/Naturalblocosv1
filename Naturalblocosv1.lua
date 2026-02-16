-- LUIZ MENU V1 - OMNI FUSION EDITION (DELTA/MOBILE)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LUIZ MENU V1 👑",
   LoadingTitle = "Sincronizando Matéria...",
   LoadingSubtitle = "por Luiz",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

local lp = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- --- ABA 1: FUSÃO OMNI (FLY OBJETOS) 🧩 ---
local TabFusao = Window:CreateTab("Fusão Omni 🧩", 4483362458)

TabFusao:CreateToggle({
   Name = "Fundir e Voar com Objeto (Fly Part) 🚀",
   CurrentValue = false,
   Callback = function(Value)
      _G.ObjectFly = Value
      if Value then
         -- Procura o objeto mais próximo para possuir
         local alvo = nil
         local distMax = 20
         for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(lp.Character) and v.Size.Magnitude < 15 then
               local d = (lp.Character.HumanoidRootPart.Position - v.Position).Magnitude
               if d < distMax then alvo = v distMax = d end
            end
         end

         if alvo then
            Rayfield:Notify({Title = "FUSÃO ACEITA", Content = "Você possuiu: "..alvo.Name, Duration = 3})
            
            task.spawn(function()
               local hrp = lp.Character.HumanoidRootPart
               -- Prende o player no objeto
               local weld = Instance.new("Weld", alvo)
               weld.Part0 = alvo
               weld.Part1 = hrp
               weld.C0 = CFrame.new(0, 0, 0)

               -- Forças de Voo para o Objeto
               local bg = Instance.new("BodyGyro", alvo)
               bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
               local bv = Instance.new("BodyVelocity", alvo)
               bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)

               while _G.ObjectFly do
                  -- Deixa o player invisível/noclip para parecer que é só o objeto
                  for _, p in pairs(lp.Character:GetDescendants()) do
                     if p:IsA("BasePart") then p.Transparency = 1 p.CanCollide = false end
                  end
                  
                  local moveDir = lp.Character.Humanoid.MoveDirection
                  if moveDir.Magnitude > 0 then
                     bv.Velocity = moveDir * 70
                     bg.CFrame = CFrame.new(alvo.Position, alvo.Position + moveDir)
                  else
                     bv.Velocity = Vector3.new(0, math.sin(tick()*3)*1, 0)
                     bg.CFrame = Camera.CFrame
                  end
                  task.wait()
               end
               
               -- Limpeza ao desligar
               weld:Destroy() bg:Destroy() bv:Destroy()
               for _, p in pairs(lp.Character:GetDescendants()) do
                  if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.Transparency = 0 end
               end
            end)
         else
            Rayfield:Notify({Title = "ERRO", Content = "Chegue perto de um objeto solto!", Duration = 3})
         end
      end
   end,
})

-- --- ABA 2: SOBREVIVENTES (SUPERMAN) 🦸‍♂️ ---
local TabHeroi = Window:CreateTab("Sobreviventes 🛡️", 4483362458)

TabHeroi:CreateToggle({
   Name = "Voo do Superman 🦸‍♂️",
   CurrentValue = false,
   Callback = function(Value)
      _G.FlyHero = Value
      if Value then
         local hrp = lp.Character.HumanoidRootPart
         local bg = Instance.new("BodyGyro", hrp)
         bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
         local bv = Instance.new("BodyVelocity", hrp)
         bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
         task.spawn(function()
            while _G.FlyHero do
               local moveDir = lp.Character.Humanoid.MoveDirection
               if moveDir.Magnitude > 0 then
                  bv.Velocity = moveDir * 60
                  bg.CFrame = CFrame.new(hrp.Position, hrp.Position + moveDir) * CFrame.Angles(math.rad(-30), 0, 0)
               else
                  bv.Velocity = Vector3.new(0, math.sin(tick()*2)*0.5, 0)
                  bg.CFrame = Camera.CFrame
               end
               task.wait()
            end
            bg:Destroy() bv:Destroy()
         end)
      end
   end,
})

TabHeroi:CreateButton({ Name = "Ativar Balão 🎈", Callback = function() 
   local bf = Instance.new("BodyForce", lp.Character.HumanoidRootPart)
   bf.Force = Vector3.new(0, workspace.Gravity * lp.Character.HumanoidRootPart:GetMass() * 0.9, 0)
end})

-- --- ABA 3: AURA & TORNADO 🌪️ ---
local TabAura = Window:CreateTab("AURA ♾️", 4483362458)

TabAura:CreateToggle({
   Name = "Fling Supremacia (Anti-Deitar) 🌀",
   CurrentValue = false,
   Callback = function(Value)
      _G.Fling = Value
      if Value then
         task.spawn(function()
            local hrp = lp.Character.HumanoidRootPart
            local gyro = Instance.new("BodyGyro", hrp)
            gyro.MaxTorque = Vector3.new(9e9, 0, 9e9)
            while _G.Fling do
               hrp.RotVelocity = Vector3.new(0, 15000, 0)
               hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
               for _, p in pairs(game.Players:GetPlayers()) do
                  if p ~= lp and p.Character and (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude < 8 then
                     p.Character.HumanoidRootPart.Velocity = Vector3.new(60000, 60000, 60000)
                  end
               end
               RunService.Heartbeat:Wait()
            end
            gyro:Destroy()
         end)
      end
   end,
})

TabAura:CreateToggle({
   Name = "Liquidificador de Spawn 🌪️",
   CurrentValue = false,
   Callback = function(Value)
      _G.Tornado = Value
      local a = 0
      task.spawn(function()
         while _G.Tornado do
            a = a + 0.4
            local c = 0
            for _, v in pairs(workspace:GetDescendants()) do
               if v:IsA("BasePart") and not v.Anchored and v.Size.Magnitude < 10 and not v:IsDescendantOf(lp.Character) then
                  if c > 40 then break end
                  local targetPos = lp.Character.HumanoidRootPart.CFrame * CFrame.new(math.cos(a+c)*12, 2, math.sin(a+c)*12).Position
                  v.Velocity = (targetPos - v.Position) * 30
                  c = c + 1
               end
            end
            task.wait()
         end
      end)
   end,
})

-- --- ABA 4: PVP & MUNDO 🌎 ---
local TabPvP = Window:CreateTab("PvP & Mundo 🌎", 4483362458)
TabPvP:CreateButton({ Name = "Hitbox Gigante 📦", Callback = function()
   for _, p in pairs(game.Players:GetPlayers()) do
      if p ~= lp and p.Character then p.Character.HumanoidRootPart.Size = Vector3.new(15, 15, 15) end
   end
end})

TabPvP:CreateToggle({ Name = "Aviso de Meteoros ⚡", CurrentValue = false, Callback = function(Value)
   _G.ESP = Value
   while _G.ESP do
      for _, v in pairs(workspace:GetDescendants()) do
         if (v.Name == "Meteor" or v.Name == "LightningStrike") and not v:FindFirstChild("Highlight") then
            Instance.new("Highlight", v).FillColor = Color3.fromRGB(255, 0, 0)
         end
      end
      task.wait(0.5)
   end
end})
