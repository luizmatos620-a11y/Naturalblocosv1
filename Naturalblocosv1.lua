-- LUIZ MENU V1 - EDIÇÃO OMNI (FLING ESTÁTICO)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LUIZ MENU V1 👑",
   LoadingTitle = "Estabilizando Físicas...",
   LoadingSubtitle = "por Luiz",
   ConfigurationSaving = { Enabled = false },
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
      end
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

-- --- ABA AURA (FLING ESTÁTICO CORRIGIDO) ---
local TabAura = Window:CreateTab("AURA ♾️", 4483362458)

TabAura:CreateToggle({
   Name = "Aura de Expulsão (Fling Fixo) 🌀",
   CurrentValue = false,
   Flag = "FlingAura",
   Callback = function(Value)
      _G.FlingAura = Value
      
      if Value then
         local hrp = lp.Character.HumanoidRootPart
         local posInicial = hrp.Position -- Salva onde você está

         -- Criar trava de posição para não flutuar
         local trava = Instance.new("BodyPosition")
         trava.Name = "TravaFling"
         trava.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
         trava.Position = posInicial
         trava.Parent = hrp

         task.spawn(function()
            while _G.FlingAura do
               -- Noclip para não bugar no chão
               if lp.Character then
                  for _, part in pairs(lp.Character:GetDescendants()) do
                     if part:IsA("BasePart") then part.CanCollide = false end
                  end
               end
               
               -- Rotação extrema apenas no eixo Y (sem flutuar)
               hrp.RotVelocity = Vector3.new(0, 500000, 0)
               
               -- Força de expulsão lateral
               local f = Instance.new("BodyVelocity")
               f.Velocity = Vector3.new(500, 0, 500)
               f.MaxForce = Vector3.new(1000, 0, 1000)
               f.Parent = hrp
               task.wait(0.05)
               f:Destroy()
               
               RunService.Heartbeat:Wait()
            end
            
            -- Limpeza ao desligar
            if trava then trava:Destroy() end
            if lp.Character then
               for _, part in pairs(lp.Character:GetDescendants()) do
                  if part:IsA("BasePart") then part.CanCollide = true end
               end
            end
         end)
      end
   end,
})

TabAura:CreateToggle({
   Name = "Furacão de Objetos (40 Itens) 🌪️",
   CurrentValue = false,
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
                  v.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(math.cos(angulo+count)*15, 5, math.sin(angulo+count)*15)
                  count = count + 1
               end
            end
            task.wait()
         end
      end)
   end,
})

-- --- ABA CONFIGURAÇÕES ---
local TabConfig = Window:CreateTab("Configurações ⚙️", 4483362458)
TabConfig:CreateButton({
   Name = "Destruir Menu ❌",
   Callback = function() Rayfield:Destroy() end,
})
