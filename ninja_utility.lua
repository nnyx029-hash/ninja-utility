--[[
    NINJA BATTLEGROUNDS UTILITY SCRIPT
    Version: 2.0
    Author: DeepSeek
    Description: Script utility untuk Ninja Battlegrounds (100% aman)
    Fitur: Player Info, Nearby Players, Tips, Performance Monitor
--]]

-- ================= KONFIGURASI AWAL =================
local function InitializeScript()
    -- Services
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local CoreGui = game:GetService("CoreGui")
    local LocalPlayer = Players.LocalPlayer
    
    -- Variabel Global Script
    local Script = {
        Name = "Ninja Utility",
        Version = "2.0",
        Author = "DeepSeek",
        Loaded = false,
        GUI = nil,
        Config = {
            MenuKey = Enum.KeyCode.F1,
            ShowFPS = true,
            ShowPing = true,
            ShowTips = true,
            MenuTransparency = 0.3
        }
    }
    
    -- ================= MEMBUAT GUI =================
    local function CreateGUI()
        -- ScreenGui
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "NinjaUtilityGUI"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = CoreGui
        
        -- Main Frame
        local mainFrame = Instance.new("Frame")
        mainFrame.Name = "MainFrame"
        mainFrame.Size = UDim2.new(0, 280, 0, 250)
        mainFrame.Position = UDim2.new(0, 10, 0, 10)
        mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        mainFrame.BackgroundTransparency = Script.Config.MenuTransparency
        mainFrame.BorderSizePixel = 2
        mainFrame.BorderColor3 = Color3.new(1, 0.5, 0)
        mainFrame.Active = true
        mainFrame.Draggable = true
        mainFrame.Parent = screenGui
        
        -- Title Bar
        local titleBar = Instance.new("Frame")
        titleBar.Size = UDim2.new(1, 0, 0, 30)
        titleBar.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        titleBar.Parent = mainFrame
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -40, 1, 0)
        titleLabel.Position = UDim2.new(0, 5, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = "⚔️ NINJA UTILITY v2.0"
        titleLabel.TextColor3 = Color3.new(1, 0.5, 0)
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Font = Enum.Font.SourceSansBold
        titleLabel.TextSize = 18
        titleLabel.Parent = titleBar
        
        local closeBtn = Instance.new("TextButton")
        closeBtn.Size = UDim2.new(0, 25, 1, -2)
        closeBtn.Position = UDim2.new(1, -27, 0, 1)
        closeBtn.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
        closeBtn.Text = "X"
        closeBtn.TextColor3 = Color3.new(1, 1, 1)
        closeBtn.Font = Enum.Font.SourceSansBold
        closeBtn.TextSize = 16
        closeBtn.Parent = titleBar
        
        closeBtn.MouseButton1Click:Connect(function()
            mainFrame.Visible = false
        end)
        
        -- Tab System
        local tabFrame = Instance.new("Frame")
        tabFrame.Size = UDim2.new(1, -10, 0, 25)
        tabFrame.Position = UDim2.new(0, 5, 0, 35)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Parent = mainFrame
        
        local tabs = {"📊 INFO", "👥 PLAYERS", "⚙️ SETTINGS"}
        local tabButtons = {}
        local currentTab = "INFO"
        
        for i, tabName in ipairs(tabs) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0.33, -2, 1, 0)
            btn.Position = UDim2.new((i-1) * 0.33, 2, 0, 0)
            btn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            btn.Text = tabName
            btn.TextColor3 = i == 1 and Color3.new(1, 0.5, 0) or Color3.new(0.8, 0.8, 0.8)
            btn.Font = Enum.Font.SourceSansBold
            btn.TextSize = 14
            btn.Parent = tabFrame
            
            tabButtons[tabName] = btn
        end
        
        -- Content Area
        local contentFrame = Instance.new("Frame")
        contentFrame.Size = UDim2.new(1, -10, 1, -95)
        contentFrame.Position = UDim2.new(0, 5, 0, 65)
        contentFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        contentFrame.Parent = mainFrame
        
        -- Tab: INFO
        local infoTab = Instance.new("Frame")
        infoTab.Size = UDim2.new(1, -10, 1, -10)
        infoTab.Position = UDim2.new(0, 5, 0, 5)
        infoTab.BackgroundTransparency = 1
        infoTab.Visible = true
        infoTab.Parent = contentFrame
        
        local playerInfo = Instance.new("TextLabel")
        playerInfo.Size = UDim2.new(1, 0, 0, 25)
        playerInfo.BackgroundTransparency = 1
        playerInfo.Text = "Player: " .. LocalPlayer.Name
        playerInfo.TextColor3 = Color3.new(1, 1, 1)
        playerInfo.TextXAlignment = Enum.TextXAlignment.Left
        playerInfo.Font = Enum.Font.SourceSans
        playerInfo.TextSize = 16
        playerInfo.Parent = infoTab
        
        local healthInfo = Instance.new("TextLabel")
        healthInfo.Size = UDim2.new(1, 0, 0, 25)
        healthInfo.Position = UDim2.new(0, 0, 0, 25)
        healthInfo.BackgroundTransparency = 1
        healthInfo.Text = "Health: --/--"
        healthInfo.TextColor3 = Color3.new(0, 1, 0)
        healthInfo.TextXAlignment = Enum.TextXAlignment.Left
        healthInfo.Font = Enum.Font.SourceSans
        healthInfo.TextSize = 16
        healthInfo.Parent = infoTab
        
        local energyInfo = Instance.new("TextLabel")
        energyInfo.Size = UDim2.new(1, 0, 0, 25)
        energyInfo.Position = UDim2.new(0, 0, 0, 50)
        energyInfo.BackgroundTransparency = 1
        energyInfo.Text = "Energy: --"
        energyInfo.TextColor3 = Color3.new(1, 1, 0)
        energyInfo.TextXAlignment = Enum.TextXAlignment.Left
        energyInfo.Font = Enum.Font.SourceSans
        energyInfo.TextSize = 16
        energyInfo.Parent = infoTab
        
        local positionInfo = Instance.new("TextLabel")
        positionInfo.Size = UDim2.new(1, 0, 0, 25)
        positionInfo.Position = UDim2.new(0, 0, 0, 75)
        positionInfo.BackgroundTransparency = 1
        positionInfo.Text = "Position: 0, 0, 0"
        positionInfo.TextColor3 = Color3.new(0.5, 0.5, 1)
        positionInfo.TextXAlignment = Enum.TextXAlignment.Left
        positionInfo.Font = Enum.Font.SourceSans
        positionInfo.TextSize = 14
        positionInfo.Parent = infoTab
        
        -- Tab: PLAYERS
        local playersTab = Instance.new("Frame")
        playersTab.Size = UDim2.new(1, -10, 1, -10)
        playersTab.Position = UDim2.new(0, 5, 0, 5)
        playersTab.BackgroundTransparency = 1
        playersTab.Visible = false
        playersTab.Parent = contentFrame
        
        local playersList = Instance.new("ScrollingFrame")
        playersList.Size = UDim2.new(1, 0, 1, 0)
        playersList.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        playersList.ScrollBarThickness = 5
        playersList.Parent = playersTab
        
        local playersListLayout = Instance.new("UIListLayout")
        playersListLayout.Padding = UDim.new(0, 2)
        playersListLayout.Parent = playersList
        
        -- Tab: SETTINGS
        local settingsTab = Instance.new("Frame")
        settingsTab.Size = UDim2.new(1, -10, 1, -10)
        settingsTab.Position = UDim2.new(0, 5, 0, 5)
        settingsTab.BackgroundTransparency = 1
        settingsTab.Visible = false
        settingsTab.Parent = contentFrame
        
        local settings = {
            {Name = "Show FPS", Var = "ShowFPS", Default = true},
            {Name = "Show Ping", Var = "ShowPing", Default = true},
            {Name = "Show Tips", Var = "ShowTips", Default = true}
        }
        
        for i, setting in ipairs(settings) do
            local settingFrame = Instance.new("Frame")
            settingFrame.Size = UDim2.new(1, 0, 0, 30)
            settingFrame.Position = UDim2.new(0, 0, 0, (i-1) * 35)
            settingFrame.BackgroundTransparency = 1
            settingFrame.Parent = settingsTab
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.7, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = setting.Name
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Font = Enum.Font.SourceSans
            label.TextSize = 16
            label.Parent = settingFrame
            
            local toggle = Instance.new("TextButton")
            toggle.Size = UDim2.new(0.25, -5, 0.8, 0)
            toggle.Position = UDim2.new(0.75, 5, 0.1, 0)
            toggle.BackgroundColor3 = setting.Default and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
            toggle.Text = setting.Default and "ON" or "OFF"
            toggle.TextColor3 = Color3.new(1, 1, 1)
            toggle.Font = Enum.Font.SourceSansBold
            toggle.TextSize = 14
            toggle.Parent = settingFrame
            
            toggle.MouseButton1Click:Connect(function()
                Script.Config[setting.Var] = not Script.Config[setting.Var]
                toggle.BackgroundColor3 = Script.Config[setting.Var] and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
                toggle.Text = Script.Config[setting.Var] and "ON" or "OFF"
            end)
        end
        
        -- Tab switching
        for tabName, btn in pairs(tabButtons) do
            btn.MouseButton1Click:Connect(function()
                for _, b in pairs(tabButtons) do
                    b.TextColor3 = Color3.new(0.8, 0.8, 0.8)
                end
                btn.TextColor3 = Color3.new(1, 0.5, 0)
                
                infoTab.Visible = (tabName == "📊 INFO")
                playersTab.Visible = (tabName == "👥 PLAYERS")
                settingsTab.Visible = (tabName == "⚙️ SETTINGS")
            end)
        end
        
        -- Performance Monitor (FPS/Ping)
        local perfFrame = Instance.new("Frame")
        perfFrame.Size = UDim2.new(0, 150, 0, 50)
        perfFrame.Position = UDim2.new(1, -160, 0, 70)
        perfFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        perfFrame.BackgroundTransparency = 0.5
        perfFrame.BorderSizePixel = 1
        perfFrame.BorderColor3 = Color3.new(0, 1, 0)
        perfFrame.Parent = screenGui
        
        local fpsLabel = Instance.new("TextLabel")
        fpsLabel.Size = UDim2.new(1, 0, 0.5, 0)
        fpsLabel.BackgroundTransparency = 1
        fpsLabel.Text = "FPS: 60"
        fpsLabel.TextColor3 = Color3.new(1, 1, 1)
        fpsLabel.Font = Enum.Font.SourceSans
        fpsLabel.TextSize = 14
        fpsLabel.Parent = perfFrame
        
        local pingLabel = Instance.new("TextLabel")
        pingLabel.Size = UDim2.new(1, 0, 0.5, 0)
        pingLabel.Position = UDim2.new(0, 0, 0.5, 0)
        pingLabel.BackgroundTransparency = 1
        pingLabel.Text = "Ping: --"
        pingLabel.TextColor3 = Color3.new(1, 1, 1)
        pingLabel.Font = Enum.Font.SourceSans
        pingLabel.TextSize = 14
        pingLabel.Parent = perfFrame
        
        -- Tips
        local tips = {
            "Gunakan shuriken untuk serangan jarak jauh",
            "Smoke bomb bisa membuatmu kabur dari musuh",
            "Double jump memungkinkan combo udara",
            "Block untuk mengurangi damage",
            "Ultimate charge lebih cepat saat bertarung",
            "Jangan lupa beli upgrade di shop",
            "Gunakan environment untuk keuntungan taktis",
            "Latihan combo di training area",
            "Perhatikan stamina saat berlari",
            "Gunakan ultimate saat momen tepat"
        }
        
        local tipLabel = Instance.new("TextLabel")
        tipLabel.Size = UDim2.new(0, 300, 0, 40)
        tipLabel.Position = UDim2.new(0.5, -150, 1, -50)
        tipLabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        tipLabel.BackgroundTransparency = 0.3
        tipLabel.Text = "💡 " .. tips[math.random(#tips)]
        tipLabel.TextColor3 = Color3.new(1, 1, 0.5)
        tipLabel.Font = Enum.Font.SourceSans
        tipLabel.TextSize = 14
        tipLabel.TextWrapped = true
        tipLabel.Parent = screenGui
        
        -- Return GUI elements
        return {
            ScreenGui = screenGui,
            MainFrame = mainFrame,
            PlayerInfo = playerInfo,
            HealthInfo = healthInfo,
            EnergyInfo = energyInfo,
            PositionInfo = positionInfo,
            PlayersList = playersList,
            FPSLabel = fpsLabel,
            PingLabel = pingLabel,
            TipLabel = tipLabel,
            PerfFrame = perfFrame
        }
    end
    
    -- ================= UPDATE FUNCTIONS =================
    local function UpdateInfo(gui)
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                gui.HealthInfo.Text = "Health: " .. math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
            end
            
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local pos = rootPart.Position
                gui.PositionInfo.Text = string.format("Position: %.1f, %.1f, %.1f", pos.X, pos.Y, pos.Z)
            end
            
            -- Cari energy
            local energy = character:FindFirstChild("Energy") or character:FindFirstChild("Stamina")
            if energy then
                gui.EnergyInfo.Text = "Energy: " .. math.floor(energy.Value)
            end
        end
        
        -- Update players list
        for _, child in ipairs(gui.PlayersList:GetChildren()) do
            if child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        
        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    local distance = "?"
                    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                    
                    if rootPart and myRoot then
                        local dist = (rootPart.Position - myRoot.Position).Magnitude
                        distance = string.format("%.1f studs", dist)
                    end
                    
                    local playerLabel = Instance.new("TextLabel")
                    playerLabel.Size = UDim2.new(1, -10, 0, 20)
                    playerLabel.BackgroundTransparency = 1
                    playerLabel.Text = player.Name .. " - " .. distance
                    playerLabel.TextColor3 = Color3.new(1, 1, 1)
                    playerLabel.TextXAlignment = Enum.TextXAlignment.Left
                    playerLabel.Font = Enum.Font.SourceSans
                    playerLabel.TextSize = 14
                    playerLabel.Parent = gui.PlayersList
                end
            end
        end
    end
    
    -- ================= PERFORMANCE MONITOR =================
    local function StartPerformanceMonitor(gui)
        local lastTime = tick()
        local frames = 0
        local fps = 60
        
        RunService.RenderStepped:Connect(function()
            frames = frames + 1
            local currentTime = tick()
            
            if currentTime - lastTime >= 1 then
                fps = frames
                frames = 0
                lastTime = currentTime
                
                if Script.Config.ShowFPS then
                    gui.FPSLabel.Text = "FPS: " .. fps
                    gui.PerfFrame.Visible = true
                else
                    gui.PerfFrame.Visible = false
                end
                
                if Script.Config.ShowPing then
                    local stats = game:GetService("Stats")
                    local network = stats:FindFirstChild("Network")
                    if network then
                        local ping = network:FindFirstChild("ServerStatsItem")
                        if ping then
                            gui.PingLabel.Text = "Ping: " .. math.floor(ping.Value) .. "ms"
                        end
                    end
                end
            end
        end)
    end
    
    -- ================= TIPS ROTATION =================
    local function StartTipsRotation(gui)
        local tips = {
            "Gunakan shuriken untuk serangan jarak jauh",
            "Smoke bomb bisa membuatmu kabur dari musuh",
            "Double jump memungkinkan combo udara",
            "Block untuk mengurangi damage",
            "Ultimate charge lebih cepat saat bertarung",
            "Jangan lupa beli upgrade di shop",
            "Gunakan environment untuk keuntungan taktis",
            "Latihan combo di training area",
            "Perhatikan stamina saat berlari",
            "Gunakan ultimate saat momen tepat",
            "Jangan spam attack, timing itu penting",
            "Pelajari movement lawan",
            "Gunakan dodge roll untuk menghindar"
        }
        
        spawn(function()
            while wait(30) do
                if Script.Config.ShowTips then
                    gui.TipLabel.Text = "💡 " .. tips[math.random(#tips)]
                    gui.TipLabel.Visible = true
                else
                    gui.TipLabel.Visible = false
                end
            end
        end)
    end
    
    -- ================= HOTKEY HANDLER =================
    local function SetupHotkeys(gui)
        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Script.Config.MenuKey then
                gui.MainFrame.Visible = not gui.MainFrame.Visible
            end
        end)
    end
    
    -- ================= MAIN INITIALIZATION =================
    local function Main()
        if Script.Loaded then
            warn("Script sudah diload!")
            return
        end
        
        -- Create GUI
        local gui = CreateGUI()
        Script.GUI = gui
        
        -- Start systems
        SetupHotkeys(gui)
        StartPerformanceMonitor(gui)
        StartTipsRotation(gui)
        
        -- Main update loop
        RunService.RenderStepped:Connect(function()
            UpdateInfo(gui)
        end)
        
        Script.Loaded = true
        
        -- Print welcome message
        print("=" .. string.rep("=", 50))
        print("  " .. Script.Name .. " v" .. Script.Version)
        print("  Author: " .. Script.Author)
        print("=" .. string.rep("=", 50))
        print("✅ Script berhasil diload!")
        print("📌 Tekan F1 untuk toggle menu")
        print("📊 Fitur: Info Player, Nearby Players, Performance Monitor, Tips")
        print("=" .. string.rep("=", 50))
    end
    
    -- Run script
    local success, err = pcall(Main)
    if not success then
        warn("Error: " .. tostring(err))
    end
    
    return Script
end

-- ================= LOADSTRING WRAPPER =================
-- Format yang siap untuk di-loadstring
local scriptSource = string.dump(InitializeScript)
local loadableScript = "local func = loadstring(" .. scriptSource .. "); func();"

-- Return untuk loadstring
return InitializeScript
