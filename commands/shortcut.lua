local registry = require("./registry")

local shortcuts = {
    ["dataja"] = {expansion = "Don't ask to ask, just ask! - http://sol.gfxile.net/dontask.html"}
    --["whatever"] = {expansion = "Whatever..", helpText = "Shows whatever"},
    --["test"] = {expansion = "It works.", helpText = "Test if it works"},
}

for short, data in pairs(shortcuts) do
    local patterns = {"^!" .. short .. "$", "^!" .. short .. "%s+.*"}
    registry.add(patterns, function()
        return data.expansion
    end, "!" .. short, data.helpText or data.expansion)
end
