local registry = require("./registry")
local util = require("./util")
local client = require("../client")

registry.add({"^!quote%s+(%S+)$", "^!quote%s+(%S+)%s+.*$"}, function(message, arg)
    local quoteMsgId = arg:match("^<?https://discordapp.com/channels/%d+/%d+/(%d+)>?$")
    if not quoteMsgId then
        quoteMsgId = arg
    end
    if not quoteMsgId:match("^%d+$") then
        return "Wrong syntax."
    end

    local quoteChannel, quoteMsg
    for guild in client.guilds:iter() do
        for channel in guild.textChannels:iter() do
            quoteMsg = channel:getMessage(quoteMsgId)
            if quoteMsg then
                quoteChannel = channel
                break
            end
        end
    end

    if not quoteMsg then
        return "Message not found."
    end

    return ("<@%d> said in %s at %s:\n*%s*"):format(quoteMsg.author.id,
        quoteChannel.mentionString, os.date("!%Y.%m.%d %H:%M:%S UTC", quoteMsg.createdAt),
        quoteMsg.content:gsub("%*", "\\*"))
end, "!quote <messageid>, !quote <channelid>:<messageid>", "Quote a message")
