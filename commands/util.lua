local util = {}

local function genPatterns(templates, names)
    if type(names) ~= "table" then
        names = {names}
    end

    local ret = {}
    for _, name in ipairs(names) do
        for _, template in ipairs(templates) do
            table.insert(ret, template:gsub("{name}", name))
        end
    end
    return ret
end

function util.oneArgErrorPatterns(names, noInText)
    local templates = {"^!{name}$"}
    if not noInText then
        table.insert(templates, "{name}:$")
    end
    return genPatterns(templates, names)
end

function util.oneArgPatterns(names, noInText)
    local templates = {"^!{name}%s+(.+)"}
    if not noInText then
        table.insert(templates, "{name}:(%S+)%s.*")
        table.insert(templates, "{name}:(%S+)[!%?%.]?$")
    end
    return genPatterns(templates, names)
end

function util.noArgPatterns(names)
    return genPatterns({"^!{name}$", "^!{name}%s+.*"}, names)
end

return util
