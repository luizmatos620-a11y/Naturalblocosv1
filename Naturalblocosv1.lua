-- LUIZ MENU V1 - SUPREMACIA TOTAL (KEY SYSTEM)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LUIZ MENU V1 👑",
   LoadingTitle = "Verificando Credenciais...",
   LoadingSubtitle = "por Luiz",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true, -- Ativado
   KeySettings = {
      Title = "Sistema de Chave",
      Subtitle = "Digite a senha do Luiz",
      Note = "A senha é: Luizmenu2026",
      FileName = "LuizKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Luizmenu2026"} -- SENHA DEFINIDA
   }
})

local lp = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- --- ABA 1: FUSÃO OMNI (FLY OBJETOS) 🧩 ---
local TabFusao = Window:CreateTab("Fusão Omni 🧩", 4483362458)

TabFusao:CreateToggle({
   Name = "Fly Objeto (Modo Possessão) 🚀",
   CurrentValue = false,
   Callback = function(Value)
      _G.ObjectFly = Value
      if Value then
         local alvo = nil
         local distMax = 30
         for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v.Anchored and not v:IsDescendantOf(lp.Character) and v.Size.Magnitude < 25 then
               local d = (lp.Character.HumanoidRootPart.Position - v.Position).Magnitude
               if d < distMax then alvo = v distMax = d end
            end
         end

         if alvo then
            task.spawn(function()
               local hrp = lp.Character.HumanoidRootPart
               local bv = Instance.new("BodyVelocity", alvo)
               bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
               local bg = Instance.new("BodyGyro", alvo)
               bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)

               while _G.ObjectFly do
                  alvo.CanCollide = true
                  hrp.CFrame = alvo.CFrame * CFrame.new(0, 2, 0)
                  for _, p in pairs(lp.Character:GetDescendants()) do
                     if p:IsA("BasePart") then p.Transparency = 1 p.CanCollide = false end
                  end

                  local moveDir = lp.Character.Humanoid.MoveDirection
                  if moveDir.Magnitude > 0 then
                     bv.Velocity = (moveDir * 80) + Vector3.new(0, (Camera.CFrame.LookVector.Y * 60), 0)
                     bg.CFrame = CFrame.new(alvo.Position, alvo.Position + moveDir)
                  else
                     bv.Velocity = Vector3.new(0, math.sin(tick()*4), 0)
                     bg.CFrame = Camera.CFrame
                  end
                  task.wait()
               end
               bv:Destroy() bg:Destroy()
               for _, p in pairs(lp.Character:GetDescendants()) do
                  if p:IsA("BasePart") then p.Transparency = 0 p.CanCollide = true end
               end
            end)
         end
      end
   end,
})

-- --- ABA 2: MOVER OBJETOS (ESTILO IMAGEM) 🏠 ---
local TabMapa = Window:CreateTab("Mover Objetos 🏠", 4483362458)

TabMapa:CreateToggle({
   Name = "Arrastar Objetos Próximos 🔥",
   CurrentValue = false,
   Callback = function(Value)
      _G.Grab = Value
      task.spawn(function()
         while _G.Grab do
            for _, obj in pairs(workspace:GetDescendants()) do
               if obj:IsA("BasePart") and not obj.Anchored and not obj:IsDescendantOf(lp.Character) then
                  if (lp.Character.HumanoidRootPart.Position - obj.Position).Magnitude < 25 then
                     obj.Velocity = (lp.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -20).Position - obj.Position) * 15
                  end
               end
            end
            task.wait()
         end
      end)
   end,
})

-- --- ABA 3: AURA & FLING 🌀 ---
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

-- --- ABA 4: SOBREVIVENTES 🦸‍♂️ ---
local TabHero = Window:CreateTab("Sobreviventes 🛡️", 4483362458)

TabHero:CreateToggle({
   Name = "Voo do Superman 🦸‍♂️",
   CurrentValue = false,
   Callback = function(Value)
      _G.FlyH = Value
      if Value then
         local hrp = lp.Character.HumanoidRootPart
         local bg = Instance.new("BodyGyro", hrp); bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
         local bv = Instance.new("BodyVelocity", hrp); bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
         task.spawn(function()
            while _G.FlyH do
               local moveDir = lp.Character.Humanoid.MoveDirection
               bv.Velocity = moveDir.Magnitude > 0 and moveDir * 65 or Vector3.new(0, math.sin(tick()*2)*0.5, 0)
               bg.CFrame = Camera.CFrame
               task.wait()
            end
            bg:Destroy(); bv:Destroy()
         end)
      end
   end,
})

-- --- ABA 5: PVP & MUNDO 🌎 ---
local TabPvP = Window:CreateTab("PvP & Mundo 🌎", 4483362458)
TabPvP:CreateButton({ Name = "Hitbox Gigante 📦", Callback = function()
   for _, p in pairs(game.Players:GetPlayers()) do
      if p ~= lp and p.Character then p.Character.HumanoidRootPart.Size = Vector3.new(15, 15, 15) end
   end
end})

Rayfield:Notify({Title = "ACESSO LIBERADO", Content = "Bem-vindo, Luiz!", Duration = 5})
