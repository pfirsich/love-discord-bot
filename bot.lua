local client = require("./client")
local token = require("token")
local commands = require("commands")

client:on("ready", function()
    print("Logged in as ".. client.user.username)
end)

client:on("messageCreate", function(message)
    commands.registry.processMessage(message)
end)

client:run("Bot " .. token)
