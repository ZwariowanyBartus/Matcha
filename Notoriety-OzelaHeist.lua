local Colors = {}
local Boxes = {
    ["443.6966552734375,59.548255920410156,-203.36570739746094"] = Vector3.new(441.31, 58.05, -204.65),
    ["505.6666564941406,59.998252868652344,-425.73577880859375"] = Vector3.new(503.46, 58, -426.82),
    ["297.7839660644531,52.84823989868164,-240.66659545898438"] = Vector3.new(295.05, 51, -240.52),
    ["228.33316040039062,39.00091552734375,-323.2840270996094"] = Vector3.new(226.75, 38, -321.79),
    ["b"] = Vector3.new(297.78, 52.85, -240.67)
}

local KeyCard = {
    ["370.1664733886719,-23.66987419128418,-215.52061462402344"] = Vector3.new(365.26, -23, -215.26),
    ["370.1664733886719,-23.66987419128418,-215.5206298828125"] = Vector3.new(365.26, -23, -215.26),
    ["370.1664733886719,-23.66987419128418,-215.52059936523438"] = Vector3.new(365.26, -23, -215.26),
    ["328.66650390625,-23.66987419128418,-221.82061767578125"] = Vector3.new(324.77, -23, -221.21),
    ["626.66650390625,-23.66987419128418,-262.5206298828125"] = Vector3.new(623.77, -23, -263.02),
    ["638.4165649414062,-23.66987419128418,-217.5206298828125"] = Vector3.new(633.88, -23, -216.23)
}

local Code = nil 
local Laptop = {
    ["217.08799743652344,60.09658432006836,258.1997375488281"] = Vector3.new(214.38, 62.38, 259.19),
    ["139.3879852294922,39.146583557128906,-212.75027465820312"] = Vector3.new(136.70, 41.43, -212.12)
}

local Ropes = {
    [""] = Vector3.new(0,0,0)
}

local Hooks = {
    [""] = Vector3.new(0,0,0)
}

local function vecToStr(v)
    return v.X..","..v.Y..","..v.Z
end

local function KeyBoard(key, time)
    if time == nil then time = 0.1 end
    keypress(key)
    wait(time)
    keyrelease(key)
end

local function PlayerTo(pos)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Position = pos
end

local function importcolors()
    local targetSerial = game.Workspace.prop_stadium_cardReader.main.serial.SurfaceGui.TextLabel.Text
    local correctBlueprint = nil

    for _, blueprint in ipairs(game.Workspace.Blueprints.prop_stadium_blueprintTableRNG.prop_stadium_blueprint:GetChildren()) do
        if blueprint:FindFirstChild("serial") then
            local serial = blueprint:FindFirstChild("serial")
            if serial.SurfaceGui.TextLabel.Text == targetSerial then
                correctBlueprint = blueprint
                break
            end
        end
    end

    local colorsFolder = correctBlueprint:FindFirstChild("colors")
    if colorsFolder then
        for _, colorPart in ipairs(colorsFolder:GetChildren()) do
            local t = colorPart.SurfaceGui.TextLabel.Text
            table.insert(Colors, t)
        end
    end
end

local function CorrectBox()
    for _, v in ipairs(game.Workspace:GetChildren()) do
        if v.serial then
            if v.serial.SurfaceGui.TextLabel.Text == game.Workspace.prop_stadium_cardReader.main.serial.SurfaceGui.TextLabel.Text then
                local pos = v.serial.Position
                local k = vecToStr(pos)
                if Boxes[k] then
                    local vector3 = Boxes[k] + Vector3.new(0, 2, 0)
                    PlayerTo(vector3)
                    wait(1)
                    KeyBoard(70)
                    wait(1.5)
                    KeyBoard(70)
                end
            end
        end
    end
end

local function color(Colors)
    for _, colorName in ipairs(Colors) do
        if colorName == "G" then
            mousemoveabs(880, 460)
            mousemoveabs(881, 460)
        elseif colorName == "R" then
            mousemoveabs(1040, 460)
            mousemoveabs(1041, 460)
        elseif colorName == "Y" then
            mousemoveabs(880, 620)
            mousemoveabs(881, 620)
        elseif colorName == "B" then
            mousemoveabs(1040, 620)
            mousemoveabs(1041, 620)
        end
        wait(.1)
        mouse1click()
    end
end

local function KillManager()
    KeyBoard(71)
    wait(2)
    PlayerTo(Vector3.new(61.44, 23, 68.62))
    mouse1press()
    wait(.01)
    mouse1release()
    wait(1)
end

local function GetUsb()
    local pos = nil
    for _, v in ipairs(game.Workspace.Bodies:GetChildren()) do
        pos = v.HumanoidRootPart.Position 
    end
    local dx = pos.X - 1.5
    local dz = pos.Z

    pos = Vector3.new(dx, 24, dz)
    PlayerTo(pos)
    KeyBoard(17) -- crouch
    wait(.3)
    KeyBoard(86) -- get body
    wait(1.8)
    KeyBoard(70)
    wait(.5)
    PlayerTo(Vector3.new(301.81, 38, -305.20))
    wait(1)
    KeyBoard(71) -- throw body
    wait(2)
    PlayerTo(Vector3.new(99.16, 26, 68.65)) -- go to usb
    wait(.5)
    KeyBoard(70) -- get usb
    KeyBoard(70) -- fail check
    wait(1)
    KeyBoard(17)
    wait(1)
    if game.ReplicatedStorage:WaitForChild("ReplicatedMissionEquipment"):FindFirstChild("USB") == nil then GetUsb() end
end

local function GetKeyCard()
    local pos = game.Workspace.Map.KeyCard.hitbox.Position
    local k = vecToStr(pos)
    print("KeyCard: "..k , pos)
    if KeyCard[k] then
        pos = KeyCard[k]
        PlayerTo(pos)
    end
    wait(.5)
    KeyBoard(70)
    wait(1)
    if game.ReplicatedStorage:WaitForChild("ReplicatedMissionEquipment"):FindFirstChild("Key Card") == nil then GetKeyCard() end
end

local function LaptopUnlock()
    local MapLaptop = game.Workspace:WaitForChild("UseUSBComputer"):WaitForChild("Screen")
    local pos = MapLaptop.Position
    local k = vecToStr(pos)

    if Laptop[k] then
        npos = Laptop[k]
        PlayerTo(npos)
        print(npos)
        KeyBoard(17)
        wait(1)
        KeyBoard(70)
        wait(2)
        PlayerTo(Vector3.new(301.81, 38, -305.20))
        KeyBoard(17)
    end
end

local function VaultOpen()
    local Separated = {}
    Code = game.Workspace.UsedUSBComputer.Screen.SurfaceGui.TextLabel.Text
    print(Code)
    PlayerTo(Vector3.new(498.21, 40, -225.50))
    wait(.5)
    KeyBoard(70)
    wait(1)
    KeyBoard(70)
    wait(.5)

    for v in Code:gmatch(".") do
        table.insert(Separated, tonumber(v))
        print(v)
    end

    local positions = {
    [1] = {840, 380},
    [2] = {960, 380},
    [3] = {1080, 380},
    [4] = {840, 480},
    [5] = {960, 480},
    [6] = {1080, 480},
    [7] = {840, 580},
    [8] = {960, 580},
    [9] = {1080, 580},
    [0] = {960, 680},
    }

    for _, v in ipairs(Separated) do
        wait(.1)
        local pos = positions[v]
        if pos then
            mousemoveabs(pos[1], pos[2])
            wait(.3)
            mouse1click()
        end
    end
    mousemoveabs(1080, 660) -- Enter
    wait(.1)
    mouse1click()
    wait(2)
    PlayerTo(Vector3.new(509.70, 40, -205.98))
    KeyBoard(17)
    wait(.5)
    KeyBoard(70)
end

local function LaptopHackStage()
    wait(7)
    PlayerTo(Vector3.new(116.87, 61, 225.26))
    wait(.5)
    KeyBoard(70)
    wait(5)
    GetHook()
    GetRope()
    PlayerTo(Vector3.new(369.30, 80, 40.08))
    wait(.5)
    KeyBoard(70)
    wait(5)
    PlayerTo(Vector3.new(657.17, 102, 30.64))    
    wait(.5)
    KeyBoard(70)
    wait(1.5)
    KeyBoard(70)
    wait(1.5)
    PlayerTo(Vector3.new(668.99, 102, 29.98))    
    wait(.5)
    KeyBoard(70)
    wait(7)
    PlayerTo(Vector3.new(635.99, 102, 33.03))    
    wait(.5)
    KeyBoard(70)
    wait(1.5)
    PlayerTo(Vector3.new(281.36, 61, 277.21))    
    wait(.5)
    PlayerTo(Vector3.new(503.96, 59, -481.18))
end

local function GetHook()
    local hook = game.Workspace.mapEntities.missionItems.Hooks:WaitForChild("StageHook").Part.Position
    local k = vecToStr(hook)
    print(k)
    print(hook)
    if Hooks[k] then
        hook = Hooks[k]
    end
    PlayerTo(hook)
end

local function GetRope()
    local rope = game.Workspace.mapEntities.missionItems.Ropes:WaitForChild("StageRope").Part.Position
    local k = vecToStr(rope)
    print(k)
    print(rope)
    if Ropes[k] then
        rope = Ropes[k]
    end
    PlayerTo(rope)
end

local function Loading()
    local ContentProvider = game:GetService("ContentProvider")

    local assets = {}

    local function collect(path)
	    for _, v in ipairs(path:GetChildren()) do
		    table.insert(assets, v)
		    collect(v)
	    end
    end

    collect(game)

    for _, asset in ipairs(assets) do
	    pcall(function()
		    ContentProvider:PreloadAsync({asset})
	    end)
    end

    print("Loaded")
end

local function Restart()
    KeyBoard(9)
    wait(1)
    mousemoveabs(960, 500)
    mousemoveabs(960, 499)
    wait(.1)
    mouse1click()
    wait(1)
    mousemoveabs(880, 560)
    mousemoveabs(879, 560)
    wait(.1)
    mouse1click()
end

local function Check()
    task.spawn(function()
        while wait(.1) do
            local time = game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.TimeLeft.Show.Text 
            wait(2)
            local Ctime = game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.TimeLeft.Show.Text
            if Ctime == time then
                mousemoveabs(750, 840)
                mousemoveabs(749, 840)
                wait(.1)
                mouse1click()
            end
            task.wait(.1)
        end
    end)
    task.spawn(function()
        while wait(.1) do
            local Mission = game.ReplicatedStorage.ReplicatedMissionEquipment
            local usb = Mission:FindFirstChild("USB")
	        local keycard = Mission:FindFirstChild("Key Card")
            if (usb == nil or keycard == nil) and game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.TimeLeft.Show.Text == "0:17" then
                print(usb, keycard)
                print("Restarted bc of keycard/usb")
                Restart()
            end
            task.wait(.1)
        end
    end)
    task.spawn(function()
        while wait(.1) do
            if game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.Objective.text_objectiveSecondary.Text == "Open the RFID reader" and game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.TimeLeft.Show.Text == "0:20" then
                print("Restarted bc of RFID")
                Restart()
            end
            task.wait(.1)
        end
    end) 
    task.spawn(function()
        while wait(.1) do
            if game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.Objective.text_objectiveSecondary.Text == "Find and disable the correct alarm box" and game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.TimeLeft.Show.Text == "0:40" then
                print("Restarted bc of alarm boxes")
                Restart()
            end
            task.wait(.1)
        end
    end)
    task.spawn(function()
        while wait(.1) do
            if game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.Objective.text_objectiveMain.Text == "Disable the security" and game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.TimeLeft.Show.Text == "1:10" then
                print("Restarted bc of security")
                Restart()
            end
            task.wait(.1)
        end
    end)
    task.spawn(function()
        while wait(.1) do
            if game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.Objective.text_objectiveMain.Text == "ESCAPE OR YOU WILL FAIL!!" then
                print("Restarted bc of ESCAPE")
                Restart()
            end
            task.wait(.1)
        end
    end)
end

wait(299)

Loading()
while wait(.1) do if game.Players.LocalPlayer.PlayerGui:WaitForChild("SG_Package").MainGui.PregameFrame.button_playerReady.buttonText.Text == "READY" then break end end
wait(5)
mousemoveabs(1760, 960)
mousemoveabs(1759, 960)
wait(.1)
mouse1click()  
while wait(.1) do if game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.TimeLeft.Show.Text == "0:01" then break end end
task.spawn(function()
	local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
	hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    task.wait(0)
end)
wait(.1)
Check()
print("In game")
KillManager()
GetUsb()
GetKeyCard()
print("Usb done waiting for coms")
while wait(.1) do if game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.Objective.text_objectiveSecondary.Text == "Open the RFID reader" then break end end
importcolors()
wait(.1)
PlayerTo(Vector3.new(293.82, 39, -305.98))
wait(1)
KeyBoard(70)
wait(1)
PlayerTo(Vector3.new(301.81, 38, -305.20))
while wait(.1) do if game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.Objective.text_objectiveSecondary.Text == "Find and disable the correct alarm box" then break end end
CorrectBox()
Check()
wait(1)
color(Colors)
wait(1)
while wait(.1) do if game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.Objective.text_objectiveMain.Text == "Open the basement door" then break end end
PlayerTo(Vector3.new(292.36, 38, -309.71))
wait(.1)
KeyBoard(70)
wait(.5)
KeyBoard(70)
wait(.5)
KeyBoard(70)
wait(1)
PlayerTo(Vector3.new(301.81, 38, -305.20))
while wait(.1) do if game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.Objective.text_objectiveMain.Text == "Disable the security" then break end end
LaptopUnlock()
while wait(.1) do if game.Players.LocalPlayer.PlayerGui.SG_Package.MainGui.Objective.text_objectiveMain.Text == "Access the vault with a keycard" then break end end
wait(10)
VaultOpen()
wait(5)
LaptopHackStage()

print("Complete")

-- Vector3.new(158.04, 58.07, -221.64) -- Door to laptop to hack
-- Vector3.new(369.30, 79.80, 40.08) -- Laptop to hack
-- Vector3.new(657.17, 101.65, 30.64) -- Assemble hook
-- Vector3.new(668.99, 101.65, 29.98) -- activate hook
-- Vector3.new(635.99, 101.65, 33.03) -- Get gitar
-- Vector3.new(281.36, 60.05, 277.21) -- Change outfit
-- Vector3.new(503.96, 58.10, -481.18) -- Exit
