--[[
    Badge Unlocker UI – Versão estável e sem erros
    Interface moderna, arrastável, com feedback visual.
    Use APENAS em servidores privados.
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BadgeUnlockerUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Frame principal (arrastável)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 210)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -105)
MainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Cantos arredondados
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Sombra simples usando borda (alternativa sem UIShadow problemático)
local ShadowBorder = Instance.new("Frame")
ShadowBorder.Size = UDim2.new(1, 2, 1, 2)
ShadowBorder.Position = UDim2.new(0, -1, 0, -1)
ShadowBorder.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ShadowBorder.BackgroundTransparency = 0.7
ShadowBorder.BorderSizePixel = 0
ShadowBorder.ZIndex = 0
ShadowBorder.Parent = MainFrame
local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 14)
ShadowCorner.Parent = ShadowBorder

-- Gradiente de fundo
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 48)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 35))
})
Gradient.Parent = MainFrame

-- Barra de título
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 42)
TitleBar.BackgroundColor3 = Color3.fromRGB(48, 48, 62)
TitleBar.BackgroundTransparency = 0.2
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 1, 0)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🏆 Badge Unlocker"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- Botão fechar
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Position = UDim2.new(1, -36, 0, 7)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
CloseButton.BackgroundTransparency = 0.8
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0
CloseButton.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Área de conteúdo
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -62)
Content.Position = UDim2.new(0, 10, 0, 52)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- Status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 32)
StatusLabel.Position = UDim2.new(0, 0, 0, 8)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "✅ Pronto"
StatusLabel.TextColor3 = Color3.fromRGB(210, 210, 230)
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.GothamSemibold
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = Content

-- Aviso
local WarningLabel = Instance.new("TextLabel")
WarningLabel.Size = UDim2.new(1, 0, 0, 24)
WarningLabel.Position = UDim2.new(0, 0, 0, 44)
WarningLabel.BackgroundTransparency = 1
WarningLabel.Text = "⚠️ Use apenas em servidor privado"
WarningLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
WarningLabel.TextSize = 12
WarningLabel.Font = Enum.Font.Gotham
WarningLabel.TextXAlignment = Enum.TextXAlignment.Center
WarningLabel.Parent = Content

-- Botão principal
local ActionButton = Instance.new("TextButton")
ActionButton.Size = UDim2.new(1, 0, 0, 48)
ActionButton.Position = UDim2.new(0, 0, 1, -56)
ActionButton.BackgroundColor3 = Color3.fromRGB(70, 130, 200)
ActionButton.Text = "🚀 OBTER TODOS OS BADGES"
ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionButton.TextSize = 14
ActionButton.Font = Enum.Font.GothamBold
ActionButton.BorderSizePixel = 0
ActionButton.Parent = Content

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ActionButton

-- Efeito hover
local originalColor = ActionButton.BackgroundColor3
ActionButton.MouseEnter:Connect(function()
    ActionButton.BackgroundColor3 = Color3.fromRGB(90, 160, 230)
end)
ActionButton.MouseLeave:Connect(function()
    ActionButton.BackgroundColor3 = originalColor
end)

-- Controle de execução
local isRunning = false

-- Função principal de coleta (segura)
local function CollectBadges()
    if isRunning then return end
    isRunning = true
    ActionButton.Text = "⏳ COLETANDO..."
    ActionButton.BackgroundColor3 = Color3.fromRGB(180, 100, 50)
    StatusLabel.Text = "🔄 Aguardando personagem..."

    -- Aguarda personagem
    local character = LocalPlayer.Character
    if not character or not character.Parent then
        character = LocalPlayer.CharacterAdded:Wait()
    end
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local originalCFrame = humanoidRootPart.CFrame

    -- Overlay de bloqueio
    local overlay = Instance.new("ScreenGui")
    overlay.IgnoreGuiInset = true
    overlay.ResetOnSpawn = false
    local black = Instance.new("Frame")
    black.Size = UDim2.new(1, 0, 1, 0)
    black.BackgroundColor3 = Color3.new(0, 0, 0)
    black.BackgroundTransparency = 0.55
    black.ZIndex = 9999
    black.Parent = overlay

    local msg = Instance.new("TextLabel")
    msg.Size = UDim2.new(0, 260, 0, 36)
    msg.Position = UDim2.new(0.5, -130, 0.5, -18)
    msg.BackgroundTransparency = 1
    msg.Text = "Coletando badges...\nAguarde"
    msg.TextColor3 = Color3.new(1, 1, 1)
    msg.TextSize = 16
    msg.Font = Enum.Font.GothamBold
    msg.Parent = black

    overlay.Parent = LocalPlayer:WaitForChild("PlayerGui")
    task.wait(1)

    -- Função segura para disparar touch
    local function SafeFireTouch(part)
        if part and part:IsA("BasePart") and humanoidRootPart then
            pcall(function()
                firetouchinterest(humanoidRootPart, part, 0)
                firetouchinterest(humanoidRootPart, part, 1)
            end)
        end
    end

    -- Varre workspace por badges
    local badgeNames = {"BadgeAwarder", "SpecialBadgeAwarder", "Classless_Badge"}
    for _, name in ipairs(badgeNames) do
        local parts = workspace:GetDescendants()
        for _, obj in ipairs(parts) do
            if obj.Name == name and obj:IsA("BasePart") then
                SafeFireTouch(obj)
                StatusLabel.Text = "🏅 " .. name
                task.wait(0.1)
            end
        end
    end

    -- Parte do gerador
    StatusLabel.Text = "⚙️ Ativando gerador..."
    local genPos = CFrame.new(-222, -36, -1635)
    humanoidRootPart.CFrame = genPos
    task.wait(2)

    local generator = workspace:FindFirstChild("Generator4", true)
    if generator then
        local genPart = generator:FindFirstChild("Generator", true)
        if genPart then
            local btn = genPart:FindFirstChild("Button", true)
            if btn then
                local prompt = btn:FindFirstChildOfClass("ProximityPrompt")
                if prompt then
                    pcall(function()
                        fireproximityprompt(prompt)
                    end)
                end
            end
        end
    end

    task.wait(5)

    -- Volta posição original
    humanoidRootPart.CFrame = originalCFrame
    StatusLabel.Text = "✅ Concluído!"
    StatusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)

    task.wait(2)
    overlay:Destroy()

    ActionButton.Text = "🚀 OBTER TODOS OS BADGES"
    ActionButton.BackgroundColor3 = originalColor
    isRunning = false
    StatusLabel.Text = "✅ Pronto"
    StatusLabel.TextColor3 = Color3.fromRGB(210, 210, 230)
end

ActionButton.MouseButton1Click:Connect(function()
    if not isRunning then
        task.spawn(CollectBadges)
    end
end)