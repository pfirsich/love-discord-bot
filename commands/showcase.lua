local registry = require("./registry")
local util = require("./util")
local client = require("../client")

local creationsDiscussionId = "485038899371048964"
local creationsShowcaseId = "485038863916597248"

registry.add({"^!showcase%s*()$", "^!showcase%s+(.*)$"}, function(message, arg)
    if message.channel.id == creationsDiscussionId then
        local author = message.author

        local attachmentLinks = {}
        for i, attachment in ipairs(message.attachments or {}) do
            --table.insert(attachmentLinks, ("[attachment %d](%s)"):format(i, attachment.url))
            table.insert(attachmentLinks, ("%s"):format(attachment.url))
        end
        arg = arg .. ("\n\nOriginal Message: <https://discordapp.com/channels/%s/%s/%s>"):format(
            message.guild.id, message.channel.id, message.id)
        if #attachmentLinks > 0 then
            arg = arg .. "\n" .. table.concat(attachmentLinks, ", ")
        end
        -- I am not using an embed here, since I can't embed videos/images links there.
        -- I could one image to the embed, but that doesn't even work for attached videos.
        -- For later reference: https://leovoel.github.io/embed-visualizer/
        --                      https://github.com/SinisterRectus/Discordia/blob/7bd919a476c6f0eb223c406549ba6f517c44585f/examples/embed.lua
        client:getChannel(creationsShowcaseId):send(
            ("```\n```\n**Showcase posted by <@%s>**:\n%s"):format(author.id, arg))
    else
        return ("Please post your `!showcase` submissions in <#%s>!"):format(creationsDiscussionId)
    end
end)
