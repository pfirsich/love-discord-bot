local discordia = require("discordia")
local token = require("token")
local commands = require("commands")

local client = discordia.Client()

client:on("ready", function()
    print("Logged in as ".. client.user.username)
end)

client:on("messageCreate", function(message)
    commands.registry.processMessage(message)
end)

client:run("Bot " .. token)
