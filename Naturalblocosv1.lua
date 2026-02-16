-- LUIZ MENU V1 - OMNI HERO EDITION (DELTA/MOBILE)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LUIZ MENU V1 👑",
   LoadingTitle = "Injetando Protocolo Herói...",
   LoadingSubtitle = "por Luiz",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

local lp = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local Mouse = lp:GetMouse()

-- --- ABA SOBREVIVENTES (HERÓI & BALÃO) ---
local TabHeroi = Window:CreateTab("Sobreviventes 🛡️", 4483362458)

TabHeroi:CreateToggle({
   Name = "Voo do Superman 🦸‍♂️",
   CurrentValue = false,
   Callback = function(Value)
      _G.FlyHero = Value
      local char = lp.Character
      local hrp = char.HumanoidRootPart
      
      if Value then
         local bg = Instance.new("BodyGyro", hrp)
         bg.P = 9e4
         bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
         bg.CFrame = hrp.CFrame
         
         local bv = Instance.new("BodyVelocity", hrp)
         bv.Velocity = Vector3.new(0,0.1,0)
         bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
         
         task.spawn(function()
            local tempo = 0
            while _G.FlyHero do
               tempo = tempo + 0.1
               local speed = 50
               local moveDir = char.Humanoid.MoveDirection
               
               -- Animação de Subir/Descer (Idle Hero)
               local idleOffset = math.sin(tempo * 2) * 0.5
               
               if moveDir.Magnitude > 0 then
                  bv.Velocity = moveDir * speed
                  bg.CFrame = CFrame.new(hrp.Position, hrp.Position + moveDir) * CFrame.Angles(math.rad(-30), 0, 0)
               else
                  bv.Velocity = Vector3.new(0, idleOffset, 0)
                  bg.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Camera.CFrame.LookVector * 10)
               end
               RunService.RenderStepped:Wait()
            end
            bg:Destroy()
            bv:Destroy()
         end)
      end
   end,
})

TabHeroi:CreateButton({
   Name = "Ativar Balão Mágico 🎈",
   Callback = function()
      local bf = Instance.new("BodyForce", lp.Character.HumanoidRootPart)
      bf.Force = Vector3.new(0, workspace.Gravity * lp.Character.HumanoidRootPart:GetMass() * 0.9, 0)
      Rayfield:Notify({Title = "Balão Ativado", Content = "Flutuando suavemente!", Duration = 3})
   end,
})

TabHeroi:CreateButton({
   Name = "Teleporte: Ilha Segura 🏝️",
   Callback = function() lp.Character.HumanoidRootPart.CFrame = CFrame.new(-285, 180, 380) end,
})

-- --- ABA PVP ELITE (ARMAS) 🎯 ---
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
            if hrp then hrp.Size = Vector3.new(15, 15, 15) hrp.Transparency = 0.7 end
         end
      end
   end,
})

-- --- ABA AURA (FLING ESTÁVEL) ♾️ ---
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
            gyro.P = 9e4
            gyro.MaxTorque = Vector3.new(9e9, 0, 9e9)
            
            while _G.Fling do
               for _, v in pairs(lp.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
               hrp.RotVelocity = Vector3.new(0, 10000, 0)
               hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z) -- Impede afundar
               
               for _, p in pairs(game.Players:GetPlayers()) do
                  if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                     if (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude < 8 then
                        p.Character.HumanoidRootPart.Velocity = Vector3.new(50000, 50000, 50000)
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

TabAura:CreateToggle({
   Name = "Furacão de Objetos (40 itens) 🌪️",
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

-- --- ABA MUNDO & CONFIG ---
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

local TabConfig = Window:CreateTab("Configurações ⚙️", 4483362458)
TabConfig:CreateButton({ Name = "Fechar Menu ❌", Callback = function() Rayfield:Destroy() end })

Rayfield:Notify({Title = "MONSTRO COMPLETO", Content = "Fly Hero, Balão e Aura Ativados!", Duration = 5})
