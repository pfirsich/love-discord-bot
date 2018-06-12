local registry = {}

local entries = {}

function registry.add(pattern, func, commandName, helpText)
    table.insert(entries, {
        pattern = pattern,
        func = func,
        commandName = commandName,
        helpText = helpText,
    })
end

function registry.processMessage(message)
    for _, entry in ipairs(entries) do
        local match = {message.content:match(entry.pattern)}
        if #match > 0 then
            local response = entry.func(message, unpack(match))
            if response then
                message.channel:send(response)
            end
        end
    end
end

registry.add("^!help%s*.*", function()
    table.sort(entries, function(a, b) return a.commandName < b.commandName end)
    local ret = ""
    for _, entry in ipairs(entries) do
        ret = ret .. ("**%s**: %s\n"):format(entry.commandName, entry.helpText)
    end
    return ret
end, "!help", "Display this help")

return registry
