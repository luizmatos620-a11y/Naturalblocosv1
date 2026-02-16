-- LUIZ MENU V1 - NATURAL DISASTER ELITE (RAYFIELD UI)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "LUIZ MENU V1 | Natural Disaster Survival",
   LoadingTitle = "Carregando Protocolos de Elite...",
   LoadingSubtitle = "by Luiz",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "LuizMenu", 
      FileName = "NDS_Config"
   },
   KeySystem = false -- Sem sistema de key para facilitar seu uso
})

-- Variáveis de Controle
local lp = game:GetService("Players").LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()

-- --- ABA PRINCIPAL ---
local MainTab = Window:CreateTab("Sobrevivência", 4483362458) -- Ícone de escudo

MainTab:CreateSection("Automação de Desastres")

-- 1. AUTO-EVACUATE / ISLAND TP
MainTab:CreateButton({
   Name = "Auto-Evacuate (Safe Island TP)",
   Callback = function()
      local safeSpot = Vector3.new(-285, 180, 380) -- Ilha segura padrão do NDS
      if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
         lp.Character.HumanoidRootPart.CFrame = CFrame.new(safeSpot)
         Rayfield:Notify({Title = "EVACUAÇÃO", Content = "Teleportado para a zona segura!", Duration = 3})
      end
   end,
})

-- 2. DISASTER NOTIFIER (AVISO ANTECIPADO)
task.spawn(function()
    local lastDisaster = ""
    while task.wait(1) do
        local gui = lp.PlayerGui:FindFirstChild("MainGui")
        if gui and gui:FindFirstChild("DisplayGui") and gui.DisplayGui:FindFirstChild("Title") then
            local disasterText = gui.DisplayGui.Title.Text
            if disasterText ~= "" and disasterText ~= lastDisaster then
                lastDisaster = disasterText
                Rayfield:Notify({
                    Title = "🚨 DESASTRE DETECTADO",
                    Content = "O desastre atual é: " .. lastDisaster,
                    Duration = 10,
                    Image = 4483362458,
                })
            end
        end
    end
end)

-- 3. METEOR & LIGHTNING ESP
MainTab:CreateToggle({
   Name = "Meteor & Lightning ESP",
   CurrentValue = false,
   Flag = "MeteorESP",
   Callback = function(Value)
      _G.MeteorESP = Value
      if Value then
         Rayfield:Notify({Title = "ESP ATIVO", Content = "Você agora vê onde os raios e meteoros cairão!", Duration = 3})
         task.spawn(function()
            while _G.MeteorESP do
               for _, v in pairs(workspace:GetDescendants()) do
                  if v.Name == "Meteor" or v.Name == "LightningStrike" then -- Checagem de objetos de queda
                     if not v:FindFirstChild("SelectionBox") then
                        local sb = Instance.new("SelectionBox", v)
                        sb.Adornee = v
                        sb.Color3 = Color3.fromRGB(255, 0, 0)
                        sb.LineThickness = 0.05
                     end
                  end
               end
               task.wait(0.5)
            end
         end)
      end
   end,
})

MainTab:CreateSection("Vantagens Físicas")

-- 4. NO FALL DAMAGE
MainTab:CreateToggle({
   Name = "No Fall Damage (Anular Queda)",
   CurrentValue = false,
   Flag = "NoFall",
   Callback = function(Value)
      if Value then
         if lp.Character and lp.Character:FindFirstChild("FallDamageScript", true) then
            lp.Character:FindFirstChild("FallDamageScript", true).Disabled = true
            Rayfield:Notify({Title = "DANO ANULADO", Content = "Você não morre mais por queda!", Duration = 3})
         end
      else
         if lp.Character and lp.Character:FindFirstChild("FallDamageScript", true) then
            lp.Character:FindFirstChild("FallDamageScript", true).Disabled = false
         end
      end
   end,
})

-- 5. INSTANT BALLOON (GREEN BALLOON)
MainTab:CreateButton({
   Name = "Obter Balão Grátis (Green Balloon)",
   Callback = function()
      -- Tenta spawnar o balão via sistema de itens do jogo
      local balloon = game:GetObjects("rbxassetid://152299328")[1] -- ID do Balão Verde
      if balloon then
         balloon.Parent = lp.Backpack
         Rayfield:Notify({Title = "ITEM RECEBIDO", Content = "Balão equipado com sucesso!", Duration = 3})
      else
         Rayfield:Notify({Title = "ERRO", Content = "Não foi possível gerar o balão.", Duration = 3})
      end
   end,
})

-- Configurações de UI
local SettingsTab = Window:CreateTab("Configurações", 4483362458)
SettingsTab:CreateButton({
   Name = "Destruir Menu (Fechar Totalmente)",
   Callback = function()
      Rayfield:Destroy()
   end,
})

Rayfield:LoadConfiguration()
