local discordia = require("discordia")
local token = require("token")

local client = discordia.Client()

client:on("ready", function()
    print("Logged in as ".. client.user.username)
end)

client:on("messageCreate", function(message)
    if message.content == "!ping" then
        message.channel:send("Pong!")
    end
end)

client:run("Bot " .. token)
