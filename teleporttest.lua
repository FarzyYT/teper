-- Локальный скрипт для телепортации с GUI
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Создаём GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Основной фрейм
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 200, 0, 100)
mainFrame.Position = UDim2.new(0.5, -100, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Заголовок для перетаскивания
local titleBar = Instance.new("TextLabel")
titleBar.Name = "TitleBar"
titleBar.Text = "Телепортация"
titleBar.Size = UDim2.new(1, 0, 0, 20)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.TextColor3 = Color3.new(1, 1, 1)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

-- Кнопка телепортации к точке A
local teleportToAButton = Instance.new("TextButton")
teleportToAButton.Name = "TeleportToAButton"
teleportToAButton.Text = "Точка A"
teleportToAButton.Size = UDim2.new(0.8, 0, 0, 30)
teleportToAButton.Position = UDim2.new(0.1, 0, 0.3, 0)
teleportToAButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
teleportToAButton.TextColor3 = Color3.new(1, 1, 1)
teleportToAButton.BorderSizePixel = 0
teleportToAButton.Parent = mainFrame

-- Кнопка телепортации к точке B
local teleportToBButton = Instance.new("TextButton")
teleportToBButton.Name = "TeleportToBButton"
teleportToBButton.Text = "Точка B"
teleportToBButton.Size = UDim2.new(0.8, 0, 0, 30)
teleportToBButton.Position = UDim2.new(0.1, 0, 0.6, 0)
teleportToBButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
teleportToBButton.TextColor3 = Color3.new(1, 1, 1)
teleportToBButton.BorderSizePixel = 0
teleportToBButton.Parent = mainFrame

-- Координаты для телепортации
local pointA = Vector3.new(-164.35, 3.55, 60.23)
local pointB = Vector3.new(-137.03, 5.35, 37.71)

-- Функция телепортации
local function teleportTo(point)
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(point)
    end
end

-- Обработчики нажатия на кнопки
teleportToAButton.MouseButton1Click:Connect(function()
    teleportTo(pointA)
end)

teleportToBButton.MouseButton1Click:Connect(function()
    teleportTo(pointB)
end)

-- Перетаскивание окна
local dragging
local dragInput
local dragStart
local startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
