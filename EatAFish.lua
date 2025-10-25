
local Food = game.Workspace.Scriptable.Elements:GetChildren()
local tweenInfo = TweenService.TweenInfo.new(1.5, "Sine", "Out", 0, false, 0)
local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart

local function Food()
    local Food = game.Workspace.Scriptable.Elements:GetChildren()
    for _, v in ipairs(Food) do
        if v.Name == "TestFood3" or v.Name == "TestFood2" then 
            pcall(function()
                local tween = TweenService:Create(hrp, tweenInfo, { Position = v.Hitbox.Position })
                tween:Play()
                while tween.IsPlaying do wait(0) end
            end)
        end
	end
end

while wait(.1) do Food() end
