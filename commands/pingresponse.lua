local registry = require("./registry")
local client = require("../client")

local responses = {
    "Please leave me alone, <username>.",
    "This is none of my business.",
    "What do I've got to do with it?",
    "I am busy with important bot business.",
    "I do no wish to converse with lesser creatures such as you, <username>.",
    "No.",
    "I really don't like <username> in particular.",
}

registry.add(".*", function(message)
    for user in message.mentionedUsers:iter() do
        if user.id == client.user.id then
            local resp = responses[math.random(1, #responses)]
            resp = resp:gsub("<username>", message.author.nickname or message.author.name)
            return resp
        end
    end
end)
