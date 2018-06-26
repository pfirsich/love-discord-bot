local registry = require("./registry")
local util = require("./util")
local client = require("../client")

registry.add(util.oneArgPatterns("quote", true), function(message, arg)
    local quoteChannelId = message.channel.id
    local quoteMsgId, message = arg:match("^(%d+)%s+(.*)$")
    if not quoteMsgId then
        quoteChannelId, quoteMsgId, message = arg:match("^(%d+):(%d+)%s+(.*)$")
    end

    if not quoteChannelId or not quoteMsgId then
        return "Wrong syntax."
    end

    local quoteChannel = client:getChannel(tonumber(quoteChannelId))
    if not quoteChannel then
        return "Channel does not exist."
    end

    local quoteMsg = quoteChannel:getMessage(tonumber(quoteMsgId))
    if not quoteMsgId then
        return "Channel does not exist."
    end

    return ("<@%d> said in %s at %s: \"\" - %s"):format(quoteMsg.author.id,
        tostring(quoteChannel.name), quoteMsg.timestamp, quoteMsg.content, message)
end)
