local registry = require("./registry")
local util = require("./util")
local client = require("../client")

local creationsDiscussionId = "485038899371048964"
local creationsShowcaseId = "485038863916597248"

registry.add({"^!showcase%s(.*)$"}, function(message, arg)
    if message.channel.id == creationsDiscussionId then
        local author = message.author
        client:getChannel(creationsShowcaseId):send({
            embed = {
                title = "Choose this wisely",
                description = arg,
                author = {
                    name = author.username,
                    icon_url = author.avatarURL,
                },
                footer = {
                    text = ("Posted by <@%s>: https://discordapp.com/channels/%s/%s/%s"):format(
                        author.id, message.guild.id, message.channel.id, message.id)
                }
            }
        })
    else
        return "Please post your !showcase submissions in #creations-showcase!"
    end
end)
