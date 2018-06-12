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
    local templates = {"!cmd$", "!cmd[%s!%?%.,].*"}
    if not noInText then
        table.insert(templates, "^cmd:$")
        table.insert(templates, "%scmd:$")
        table.insert(templates, "^cmd:[%s!%?%.,].*")
        table.insert(templates, "%scmd:[%s!%?%.,].*")
    end
    return genPatterns(templates, names)
end

function util.oneArgPatterns(names, noInText)
    local templates = {"!cmd%s+(%S+)[%s!%?%.,].*", "!cmd%s+(%S+)$"}
    if not noInText then
        table.insert(templates, "^cmd:(%S+)[%s!%?%.,].*")
        table.insert(templates, "%scmd:(%S+)[%s!%?%.,].*")
        table.insert(templates, "^cmd:(%S+)$")
        table.insert(templates, "%scmd:(%S+)$")
    end
    return genPatterns(templates, names)
end

function util.noArgPatterns(names)
    return genPatterns({"!{name}$", "!{name}[%s!%?%.,].*"}, names)
end

return util
