local noArgPatterns = {
    "!cmd[%s!%?%.,].*",
    "!cmd$",
}

local argPatterns = {
    "!cmd%s+(%S+)[%s!%?%.,].*",
    "!cmd%s+(%S+)$",
    "^cmd:(%S+)[%s!%?%.,].*",
    "%scmd:(%S+)[%s!%?%.,].*",
    "^cmd:(%S+)$",
    "%scmd:(%S+)$",
}

local argErrorPatterns = {
    "!cmd$",
    "!cmd[%s!%?%.,].*",
    "^cmd:$",
    "%scmd:$",
    "^cmd:[%s!%?%.,].*",
    "%scmd:[%s!%?%.,].*",
}

local function matchAll(str, patterns)
    for _, pat in ipairs(patterns) do
        local m = str:match(pat)
        if m then
            return m
        end
    end
end

local function checkNoArg(str, noMatch)
    if not matchAll(str, noArgPatterns) then
        print(str, "fails")
    end
end

local function checkArg(str, match)
    match = match or "arg"
    local m = matchAll(str, argPatterns)
    if not m then
        print(str, "fails (no match)")
    elseif m ~= match then
        print(str, ("fails ('%s' instead of '%s')"):format(m, match))
    end
end

local function checkArgError(str, noMatch)
    if not matchAll(str, argErrorPatterns) and not noMatch then
        print(str, "fails")
    end
end

checkNoArg("!cmd")
checkNoArg("Test !cmd")
checkNoArg("Test !cmd!")
checkNoArg("Test !cmd.")
checkNoArg("Test !cmd, blabla")
checkNoArg("Test !cmd?")
checkNoArg("Test !cmd blabla")

checkArg("!cmd arg")
checkArg("Test !cmd arg")
checkArg("!cmd arg!")
checkArg("Test !cmd arg!")
checkArg("!cmd arg.")
checkArg("!cmd arg?")
checkArg("!cmd arg is fine")

checkArg("cmd:arg")
checkArg("cmd:arg is the answer")
checkArg("Test cmd:arg")
checkArg("cmd:arg!")
checkArg("Test cmd:arg!")
checkArg("cmd:arg.")
checkArg("cmd:arg.....")
checkArg("Test cmd:arg?")
checkArg("Test cmd:arg.")
checkArg("Test cmd:arg.....")

checkArgError("!cmd")
checkArgError("!cmd!")
checkArgError("Blabla !cmd!")
checkArgError("Blabla !cmd!")
checkArgError("Blabla !cmd.")
checkArgError("Blabla !cmd....")
checkArgError("Blabla !cmdblabla", true)
checkArgError("cmd:")
checkArgError("cmd:.")
checkArgError("cmd:?")
checkArgError("cmd:!")
checkArgError("cmd: blabla")
checkArgError("bloblocmd: blabla", true)
