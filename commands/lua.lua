local registry = require("./registry")
local util = require("./util")

local baseUrl = "https://www.lua.org/manual/5.1/manual.html#"

registry.add(util.oneArgErrorPatterns({"lua", "manual"}), function()
    return "Please pass an argument, e.g.: `!lua io.open`"
end)

registry.add(util.oneArgPatterns({"lua", "manual"}), function(message, func)
    if func:lower() == "pil" then
        return "https://www.lua.org/pil/contents.html"
    end
    if func:match("%d%.?%d?%d?%.?%d?") then
        return baseUrl .. func
    else
        return baseUrl .. "pdf-" .. func
    end
end, "!lua <function>, lua:<function>, !manual <function>, manual:<function>", "Look up the documentation on a lua function, e.g.: `!lua io.open`")
