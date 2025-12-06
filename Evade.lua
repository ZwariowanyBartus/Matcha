local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local targetAngle = 0
local rotationThread

local function getPrimitive(part)
    return memory_read("uintptr_t", part.Address + 0x148)
end

local function readCurrentRotation(part)
    local primitive = getPrimitive(part)
    local m11 = memory_read("float", primitive + 0xC0 + 0x00)
    local m31 = memory_read("float", primitive + 0xC0 + 0x18)
    local cosY = m11
    local sinY = m31
    local currentRad = math.atan2(sinY, cosY)
    local currentDeg = math.deg(currentRad)
    if currentDeg < 0 then
        currentDeg = currentDeg + 360
    end
    return currentDeg
end

local function writeRotation(part, angleDegrees)
    local primitive = getPrimitive(part)
    local rad = math.rad(angleDegrees)
    local cosY, sinY = math.cos(rad), math.sin(rad)
    memory_write("float", primitive + 0xC0 + 0x00, cosY)
    memory_write("float", primitive + 0xC0 + 0x04, 0)
    memory_write("float", primitive + 0xC0 + 0x08, -sinY)
    memory_write("float", primitive + 0xC0 + 0x0C, 0)
    memory_write("float", primitive + 0xC0 + 0x10, 1)
    memory_write("float", primitive + 0xC0 + 0x14, 0)
    memory_write("float", primitive + 0xC0 + 0x18, sinY)
    memory_write("float", primitive + 0xC0 + 0x1C, 0)
    memory_write("float", primitive + 0xC0 + 0x20, cosY)
end

local function startRotationLock()
    if rotationThread then 
        task.cancel(rotationThread)
        rotationThread = nil
    end
    
    rotationThread = task.spawn(function()
        while true do
            writeRotation(hrp, targetAngle)
            task.wait()
        end
    end)
end

local function stopRotationLock()
    if rotationThread then
        task.cancel(rotationThread)
        rotationThread = nil
    end
end

spawn(function()
    local running = false
    while true do
        task.wait()
        if iskeypressed(bind) then
            if not running then
                running = true
                local currentDeg = readCurrentRotation(hrp)
                targetAngle = (currentDeg + 180) % 360
                
                task.spawn(function()
                    while running do
                        writeRotation(hrp, targetAngle)
                        task.wait()
                    end
                end)
            end
        else
            running = false
        end
    end
end)
