-- LUIZ MENU V1 - SUPREMACIA TOTAL (SPIDER EDITION)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LUIZ MENU V1 👑",
   LoadingTitle = "Carregando Luiz Menu...",
   LoadingSubtitle = "por Luiz",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true,
   KeySettings = {
      Title = "Sistema de Chave",
      Subtitle = "Digite a senha do Luiz",
      Note = "Luiz menu ⚡", -- Nota personalizada conforme solicitado
      FileName = "LuizKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Luizmenu2026"} 
   }
})

local lp = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- --- ABA 1: FÍSICA & MOVIMENTO (SPIDER & FLY) 🕷️ ---
local TabMov = Window:CreateTab("Movimento 🕷️", 4483362458)

TabMov:CreateToggle({
   Name = "Modo Homem-Aranha (Wall Walk) 🕸️",
   CurrentValue = false,
   Callback = function(Value)
      _G.SpiderMode = Value
      task.spawn(function()
         while _G.SpiderMode do
            local char = lp.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
               -- Raio para detetar paredes à frente
               local raycastParams = RaycastParams.new()
               raycastParams.FilterDescendantsInstances = {char}
               local ray = workspace:Raycast(char.HumanoidRootPart.Position, char.HumanoidRootPart.CFrame.LookVector * 3, raycastParams)
               
               if ray then
                  -- Alinha o boneco com a parede e anula a gravidade para subir
                  char.HumanoidRootPart.Velocity = Vector3.new(char.HumanoidRootPart.Velocity.X, 20, char.HumanoidRootPart.Velocity.Z)
               end
            end
            task.wait()
         end
      end)
   end,
})

TabMov:CreateToggle({
   Name = "Noclip (Atravessar Tudo) 👻",
   CurrentValue = false,
   Callback = function(Value)
      _G.Noclip = Value
      RunService.Stepped:Connect(function()
         if _G.Noclip and lp.Character then
            for _, v in pairs(lp.Character:GetDescendants()) do
               if v:IsA("BasePart") then v.CanCollide = false end
            end
         end
      end)
   end,
})

TabMov:CreateButton({
   Name = "Ativar Balão 🎈",
   Callback = function()
      local bf = Instance.new("BodyForce", lp.Character.HumanoidRootPart)
      bf.Force = Vector3.new(0, workspace.Gravity * lp.Character.HumanoidRootPart:GetMass() * 0.9, 0)
   end,
})

-- --- ABA 2: DEFESA & PVP 🛡️ ---
local TabDefesa = Window:CreateTab("Defesa & PvP 🛡️", 4483362458)

TabDefesa:CreateToggle({
   Name = "Anti-Fling (Proteção) 🛡️",
   CurrentValue = false,
   Callback = function(Value)
      _G.AntiFling = Value
      task.spawn(function()
         while _G.AntiFling do
            if lp.Character then
               -- Anula velocidades extremas aplicadas por outros players
               local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
               if hrp and hrp.Velocity.Magnitude > 100 then
                  hrp.Velocity = Vector3.new(0, 0, 0)
                  hrp.RotVelocity = Vector3.new(0, 0, 0)
               end
            end
            task.wait()
         end
      end)
   end,
})

TabDefesa:CreateButton({
   Name = "Hitbox Gigante (Caixa Box) 📦",
   Callback = function()
      for _, p in pairs(game.Players:GetPlayers()) do
         if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            hrp.Size = Vector3.new(15, 15, 15)
            hrp.Transparency = 0.7
            hrp.CanCollide = false
         end
      end
   end,
})

-- --- ABA 3: VISUAL (ESP) 👁️ ---
local TabVisual = Window:CreateTab("Visual 👁️", 4483362458)

TabVisual:CreateToggle({
   Name = "ESP Players (Ver Através) 👥",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP = Value
      while _G.ESP do
         for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= lp and p.Character and not p.Character:FindFirstChild("Highlight") then
               local hl = Instance.new("Highlight", p.Character)
               hl.FillColor = Color3.fromRGB(0, 255, 255)
            end
         end
         task.wait(1)
      end
      if not Value then
         for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Highlight") then
               p.Character.Highlight:Destroy()
            end
         end
      end
   end,
})

-- --- ABA 4: AURA & TORNADO (O RESTO DO MENU) 🌀 ---
local TabAura = Window:CreateTab("Aura & Fling 🌀", 4483362458)

TabAura:CreateToggle({
   Name = "Fling Supremacia 🌪️",
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
                  if p ~= lp and p.Character and (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude < 10 then
                     p.Character.HumanoidRootPart.Velocity = Vector3.new(70000, 70000, 70000)
                  end
               end
               RunService.Heartbeat:Wait()
            end
            gyro:Destroy()
         end)
      end
   end,
})

Rayfield:Notify({Title = "ACESSO LIBERADO", Content = "Luiz menu ⚡ ativo!", Duration = 5})
