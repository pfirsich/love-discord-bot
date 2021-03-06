local registry = require("./registry")
local util = require("./util")

local loveModules = {
    "audio",
    "data",
    "event",
    "filesystem",
    "font",
    "graphics",
    "image",
    "joystick",
    "keyboard",
    "math",
    "mouse",
    "physics",
    "sound",
    "system",
    "thread",
    "timer",
    "touch",
    "video",
    "window",
}
-- Some modules start with the same letter:
--     love.filesystem & love.font
--     love.math & love.mouse
--     love.sound & love.system
--     love.thread & love.timer & love.touch
-- The order of this list is adjusted in a way, that the "most commonly used" module is listed
-- before the others and therefore the one the short module name version is replaced with, e.g.
-- love.timer is listed before love.thread so "lt." is replaced to "love.timer"

registry.add(util.oneArgErrorPatterns({"wiki", "love"}), function()
    return "Please pass an argument, e.g.: `!wiki love.data.pack` or `!wiki ld.pack` or `!wiki data.pack`"
end)

registry.add(util.oneArgPatterns({"wiki", "love"}), function(message, page)
    page = util.rtrim(page, "%.")
    for _, mod in ipairs(loveModules) do
        -- replace e.g. "lg." with "love.graphics."
        page = page:gsub("^l" .. mod:sub(1,1) .. "%.", "love." .. mod .. ".")
        if page:sub(1, mod:len() + 1) == mod .. "." then
            page = "love." .. page
        end
    end
    page = page:gsub("^[Ii]mage:", "(Image):")
    page = page:gsub("^[Ff]ile:", "(File):")
    return "https://love2d.org/wiki/" .. page
end, "!wiki <page>, wiki:<page>, !love <page>, love:<page>", "Look up a page on the löve wiki, e.g.: `!wiki love.data.pack` or `!wiki ld.pack`, `!wiki data.pack` or `!wiki Canvas` or `have a look at wiki:Canvas`")

local function charToHex(char)
    return ("%%%02X"):format(char:byte())
end

local function escapeNonAscii(char)
    if char:byte() < 0x80 then
        return char
    else
        return charToHex(char)
    end
end

local function urlEncode(str)
    str = str:gsub(" ", "+")
    str = str:gsub("([%%%:%/%?%#%[%]%@%$%&%'%(%)%*%+%,%;%=])", charToHex)
    str = str:gsub("(.)", escapeNonAscii)
    return str
end

registry.add(util.oneArgErrorPatterns("wikisearch"), function()
    return "Please pass an argument, e.g.: `!wikisearch setColor`"
end)

registry.add(util.oneArgPatterns("wikisearch"), function(message, query)
    query = util.rtrim(query, "%.")
    return "https://love2d.org/w/index.php?title=Special%3ASearch&go=Go&search=" .. urlEncode(query)
end, "!wikisearch <query>, wikisearch:<page>", "Search the wiki, e.g.: `!wikisearch setColor`")
