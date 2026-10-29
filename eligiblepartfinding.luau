
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local parts = {}

local function isEligible(part)
    if not part:IsA("BasePart") then
        return false
    end

    if part.Anchored then
        return false
    end

    if part.Name == "Handle" then
        return false
    end

    local character = LocalPlayer.Character

    if character and part:IsDescendantOf(character) then
        return false
    end

    local parent = part.Parent

    if parent and (
        parent:FindFirstChildOfClass("Humanoid")
        or parent:FindFirstChild("Head")
    ) then
        return false
    end

    return true
end

local function addPart(part)
    if isEligible(part) and not table.find(parts, part) then
        table.insert(parts, part)
    end
end

local function removePart(part)
    local index = table.find(parts, part)

    if index then
        table.remove(parts, index)
    end
end

for _, part in ipairs(Workspace:GetDescendants()) do
    addPart(part)
end

Workspace.DescendantAdded:Connect(addPart)
Workspace.DescendantRemoving:Connect(removePart)
