local config = { box = true, name = true }

local brainrots = {}
local last_update = 0

local function getPlayers()
    local players = {}
    for _, v in ipairs(game.Workspace:GetChildren()) do
        if v:FindFirstChild("NameTag") and v:FindFirstChild("HumanoidRootPart") then
            table.insert(players, v)
        end
    end
    return players
end

local function update_brainrots()
    for _, model in ipairs(getPlayers()) do
        local addr = tostring(model)
        if not brainrots[addr] then
            local root = model.HumanoidRootPart
            local text = Drawing.new("Text")
            text.Text = model.Name
            text.Color = Color3.fromRGB(255, 255, 255)
            text.Outline = true
            text.Center = true
            text.Visible = false

            local box_outline = Drawing.new("Square")
            box_outline.Color = Color3.fromRGB(0, 0, 0)
            box_outline.Thickness = 3
            box_outline.Visible = false

            local box = Drawing.new("Square")
            box.Color = Color3.fromRGB(255, 255, 255)
            box.Thickness = 1
            box.Visible = false

            brainrots[addr] = { root = root, text = text, box = box, box_outline = box_outline }
        end
    end
end

local function update_esp()
    for _, info in pairs(brainrots) do
        local root = info.root
        local text = info.text
        local box = info.box
        local box_outline = info.box_outline

        if root and root.Position then
            local head, vis1 = WorldToScreen(root.Position + Vector3.new(0, 4, 0))
            local leg, vis2 = WorldToScreen(root.Position - Vector3.new(0, 6, 0))

            if vis1 and vis2 then
                local h = math.abs(head.Y - leg.Y)
                local w = h / 1.5
                local x, y = head.X - w / 2, head.Y

                box_outline.Position, box_outline.Size, box_outline.Visible = Vector2.new(x, y), Vector2.new(w, h), config.box
                box.Position, box.Size, box.Visible = Vector2.new(x, y), Vector2.new(w, h), config.box
                text.Position, text.Visible = Vector2.new(head.X, y - 16), config.name
            else
                box.Visible, box_outline.Visible, text.Visible = false, false, false
            end
        else
            box.Visible, box_outline.Visible, text.Visible = false, false, false
        end
    end
end

update_brainrots()

while true do
    local now = os.clock()
    if now - last_update > 2 then
        update_brainrots()
        last_update = now
    end
    update_esp()
end