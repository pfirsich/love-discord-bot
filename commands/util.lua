local util = {}

local function genPatterns(templates, names)
    if type(names) ~= "table" then
        names = {names}
    end

    local ret = {}
    for _, name in ipairs(names) do
        for _, template in ipairs(templates) do
            local pattern = template:gsub("{name}", name)
            table.insert(ret, pattern)
        end
    end
    return ret
end

function util.oneArgErrorPatterns(names, noInText)
    local templates = {"!{name}$", "!{name}[%s!%?%.,].*"}
    if not noInText then
        table.insert(templates, "^{name}:$")
        table.insert(templates, "%s{name}:$")
        table.insert(templates, "^{name}:[%s!%?%.,].*")
        table.insert(templates, "%s{name}:[%s!%?%.,].*")
    end
    return genPatterns(templates, names)
end

function util.oneArgPatterns(names, noInText)
    local templates = {"!{name}%s+(%S+)[%s!%?%.,].*", "!{name}%s+(%S+)$"}
    if not noInText then
        table.insert(templates, "^{name}:(%S+)[%s!%?%.,].*")
        table.insert(templates, "%s{name}:(%S+)[%s!%?%.,].*")
        table.insert(templates, "^{name}:(%S+)$")
        table.insert(templates, "%s{name}:(%S+)$")
    end
    return genPatterns(templates, names)
end

function util.noArgPatterns(names)
    return genPatterns({"!{name}$", "!{name}[%s!%?%.,].*"}, names)
end

return util
