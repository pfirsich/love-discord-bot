local registry = require("./registry")
local util = require("./util")

local shortcuts = {
    {shortcut = "dataja", expansion = "Don't ask to ask, just ask! - http://sol.gfxile.net/dontask.html"},
    {shortcut = {"ssl", "tls"}, expansion = "löve does not have built-in SSL/TLS, but you can use this library instead: https://github.com/LPGhatguy/luajit-request/\nBackground info on why TLS is not included can be found here: https://bitbucket.org/rude/love/issues/363/add-ssl-tls-apis"},
}

local function joinShorcuts(shortcut)
    if type(shortcut) == "string" then
        return "!" .. shortcut
    else
        local mapped = {}
        for _, item in ipairs(shortcut) do
            table.insert(mapped, "!" .. item)
        end
        return table.concat(mapped, ", ")
    end
end

for _, shortcut in ipairs(shortcuts) do
    registry.add(util.noArgPatterns(shortcut.shortcut), function()
        return shortcut.expansion
    end, joinShorcuts(shortcut), shortcut.helpText or shortcut.expansion)
end
