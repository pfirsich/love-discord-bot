local registry = require("./registry")

local shortcuts = {
    --["whatever"] = {expansion = "Whatever..", helpText = "Shows whatever"},
    --["test"] = {expansion = "It works.", helpText = "Test if it works"},
}

for short, data in pairs(shortcuts) do
    local pattern = "^!" .. short .. "%s*.*"
    registry.add(pattern, function()
        return data.expansion
    end, "!" .. short, data.helpText)
end
