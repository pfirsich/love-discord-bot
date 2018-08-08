local registry = require("./registry")
local util = require("./util")

local shortcuts = {
    {shortcut = "dataja", expansion = "Don't ask to ask, just ask! - <http://sol.gfxile.net/dontask.html>"},
    {shortcut = "code", expansion = "You can embed code in Discord messages like this:\n\\`\\`\\`lua\n-- put code here\nprint(\"foo\")\n\\`\\`\\`\nwhich looks like this:\n```lua\n-- put code here\nprint(\"foo\")\n```",
        helpText = "How to embed code in Discord messages."},
    {shortcut = {"ssl", "tls"}, expansion = "löve does not have built-in SSL/TLS, but you can use this library instead: <https://github.com/LPGhatguy/luajit-request/>\nBackground info on why TLS is not included can be found here: <https://bitbucket.org/rude/love/issues/363/add-ssl-tls-apis>",
        helpText = "Information on the state of SSL/TLS in löve (<https://bitbucket.org/rude/love/issues/363/add-ssl-tls-apis>)"},
    {shortcut = "bikeshed", expansion = "http://bikeshed.com/", helpText = "*\"1-indexing is the worst part about Lua\"*"},
    {shortcut = "sscce", expansion = "http://sscce.org/", helpText = "Short, Self Contained, Correct (Compilable), Example"},
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
    end, joinShorcuts(shortcut.shortcut), shortcut.helpText or shortcut.expansion)
end
