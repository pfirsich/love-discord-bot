local registry = require("./registry")
local util = require("./util")

local githubUrl = "https://github.com/pfirsich/love-discord-bot"
local repoUrl = githubUrl .. ".git"

local function exec(cmd)
    local p, err = io.popen(cmd)
    if p then
        local ret = p:read("*all")
        p:close()
        return ret
    else
        return "(Error:) " .. err:wrap()
    end
end

local function extractCommit(str)
    local commitPat = "(%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w%w)"
    local patterns = {"^" .. commitPat .. "$", "^" .. commitPat .. "%s+.*"}
    for _, pattern in ipairs(patterns) do
        local m = str:match(pattern)
        if m then
            return m
        end
    end
    return str
end

registry.add(util.noArgPatterns("info"), function(message)
    -- This makes a request to the internet, so this is pretty slow (and blocking?)
    local commit = extractCommit(exec("git rev-parse HEAD"))
    local remoteCommit = extractCommit(exec(("git ls-remote \"%s\" refs/heads/master"):format(repoUrl)))
    return ("Discord bot for the löve community.\n%s\n\nCurrent version: `%s`\nCurrent version on remote: `%s`"):format(
        githubUrl, commit, remoteCommit)
end, "!info", "Displays information (including current version) about the bot.")
