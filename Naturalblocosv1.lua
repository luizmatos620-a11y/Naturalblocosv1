-- LUIZ MENU V1 - EDIÇÃO OMNI (FLING FIXADO)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LUIZ MENU V1 👑",
   LoadingTitle = "Injetando Protocolos de Elite...",
   LoadingSubtitle = "por Luiz",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "LuizMenu", 
      FileName = "Luiz_Config"
   },
   KeySystem = false
})

local lp = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")

-- --- ABA SOBREVIVÊNCIA ---
local TabSobrevivencia = Window:CreateTab("Sobrevivência 🛡️", 4483362458)

TabSobrevivencia:CreateButton({
   Name = "Teleporte Seguro (Ilha) 🏝️",
   Callback = function()
      if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
         lp.Character.HumanoidRootPart.CFrame = CFrame.new(-285, 180, 380)
         Rayfield:Notify({Title = "SUCESSO", Content = "Você foi para a zona de segurança!", Duration = 3})
      end
   end,
})

TabSobrevivencia:CreateToggle({
   Name = "Anular Dano de Queda 🦴",
   CurrentValue = false,
   Flag = "NoFall",
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
   Name = "Ativar Balão Mágico 🎈",
   Callback = function()
      local bodyFloat = Instance.new("BodyForce")
      bodyFloat.Parent = lp.Character.HumanoidRootPart
      bodyFloat.Force = Vector3.new(0, game.Workspace.Gravity * lp.Character.HumanoidRootPart:GetMass() * 0.9, 0)
      Rayfield:Notify({Title = "BALÃO ATIVO", Content = "Física de flutuação aplicada!", Duration = 3})
   end,
})

-- --- ABA AURA (FLING ARRUMADO COM NOCLIP) ---
local TabAura = Window:CreateTab("AURA ♾️", 4483362458)

TabAura:CreateToggle({
   Name = "Aura de Expulsão (Fling) 🌀",
   CurrentValue = false,
   Flag = "FlingAura",
   Callback = function(Value)
      _G.FlingAura = Value
      
      -- Loop do Noclip e Estabilidade (Para você não voar junto)
      task.spawn(function()
         while _G.FlingAura do
            if lp.Character then
               for _, part in pairs(lp.Character:GetDescendants()) do
                  if part:IsA("BasePart") then
                     part.CanCollide = false -- Noclip ativo
                  end
               end
            end
            RunService.Stepped:Wait()
         end
         -- Devolve a colisão ao desligar
         if lp.Character then
            for _, part in pairs(lp.Character:GetDescendants()) do
               if part:IsA("BasePart") then
                  part.CanCollide = true
               end
            end
         end
      end)

      -- Loop da Força de Expulsão
      task.spawn(function()
         while _G.FlingAura do
            local hrp = lp.Character.HumanoidRootPart
            local vel = hrp.Velocity
            -- Faz o personagem girar loucamente, mas mantém a posição estável no seu pé
            hrp.Velocity = Vector3.new(0, 0, 0) -- Reseta a sua subida
            hrp.RotVelocity = Vector3.new(0, 1000000, 0) -- Gira apenas no eixo Y para não capotar
            
            -- Cria uma pequena "explosão" de física constante ao redor
            local bodyVel = Instance.new("BodyVelocity")
            bodyVel.Velocity = Vector3.new(10000, 10000, 10000)
            bodyVel.MaxForce = Vector3.new(10000, 10000, 10000)
            bodyVel.Parent = hrp
            task.wait(0.1)
            bodyVel:Destroy()
            
            RunService.Heartbeat:Wait()
         end
      end)
   end,
})

TabAura:CreateToggle({
   Name = "Furacão de Objetos (40 Itens) 🌪️",
   CurrentValue = false,
   Flag = "ObjectTornado",
   Callback = function(Value)
      _G.Tornado = Value
      local angulo = 0
      task.spawn(function()
         while _G.Tornado do
            angulo = angulo + 0.2
            local count = 0
            for _, v in pairs(workspace:GetDescendants()) do
               if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(lp.Character) then
                  if count > 40 then break end
                  v.Velocity = Vector3.new(0, 50, 0)
                  v.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(math.cos(angulo + count) * 15, 5, math.sin(angulo + count) * 15)
                  count = count + 1
               end
            end
            task.wait()
         end
      end)
   end,
})

-- --- ABA MUNDO/EXTRAS ---
local TabMundo = Window:CreateTab("Mundo 🌎", 4483362458)

TabMundo:CreateToggle({
   Name = "Revelar Meteoros e Raios ⚡",
   CurrentValue = false,
   Flag = "DisasterESP",
   Callback = function(Value)
      _G.DisasterESP = Value
      task.spawn(function()
         while _G.DisasterESP do
            for _, v in pairs(workspace:GetDescendants()) do
               if v.Name == "Meteor" or v.Name == "LightningStrike" then
                  if not v:FindFirstChild("Highlight") then
                     local hl = Instance.new("Highlight", v)
                     hl.FillColor = Color3.fromRGB(255, 0, 0)
                  end
               end
            end
            task.wait(0.5)
         end
      end)
   end,
})

-- --- ABA CONFIGURAÇÕES ---
local TabConfig = Window:CreateTab("Configurações ⚙️", 4483362458)

TabConfig:CreateButton({
   Name = "Destruir Menu ❌",
   Callback = function()
      Rayfield:Destroy()
   end,
})

Rayfield:Notify({
   Title = "MENU CARREGADO",
   Content = "Luiz Menu V1: Fling e Noclip estabilizados!",
   Duration = 5,
})
