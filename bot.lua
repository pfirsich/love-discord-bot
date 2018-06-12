local client = require("./client")
local token = require("./token")
local commands = require("./commands")

client:on("ready", function()
    print("Logged in as ".. client.user.username)
end)

client:on("messageCreate", function(message)
    if message.author.id ~= client.user.id then
        commands.registry.processMessage(message)
    end
end)

client:run("Bot " .. token)
