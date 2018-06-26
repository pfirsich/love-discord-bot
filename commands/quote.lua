local registry = require("./registry")
local util = require("./util")
local client = require("../client")

registry.add({"^!quote%s+(%S+)$", "^!quote%s+(%S+)%s+.*$"}, function(message, arg)
    local quoteChannelId, quoteMsgId = arg:match("^<?https://discordapp.com/channels/%d+/(%d+)/(%d+)>?$")
    if not quoteChannelId or not quoteMsgId then
        quoteChannelId, quoteMsgId = arg:match("^(%d+):(%d+)$")
        if not quoteChannelId or not quoteMsgId then
            quoteChannelId = message.channel.id
            quoteMsgId = arg:match("^(%d+)$")
        end
    end

    if not quoteChannelId or not quoteMsgId then
        return "Wrong syntax."
    end

    local quoteChannel = client:getChannel(quoteChannelId)
    if not quoteChannel then
        return "Channel does not exist."
    end

    local quoteMsg = quoteChannel:getMessage(quoteMsgId)
    if not quoteMsg then
        return "Message does not exist in this channel."
    end

    return ("<@%d> said in %s at %s:\n*%s*"):format(quoteMsg.author.id,
        quoteChannel.mentionString, os.date("!%Y.%m.%d %H:%M:%S UTC", quoteMsg.createdAt),
        quoteMsg.content:gsub("%*", "\\*"))
end, "!quote <messageid>, !quote <channelid>:<messageid>", "Quote a message")
