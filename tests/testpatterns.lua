local noArgPatterns = {
    "!{name}$",
    "!{name}%W*",
}

local argPatterns = {
    "^!{name}%s+(.+)$",

    "^{name}:(%S*)[,!%s%?]",
    "^{name}:(%S*)$",
    "%s{name}:(%S*)[,!%s%?]",
    "%s{name}:(%S*)$",
}

local argErrorPatterns = {
    "!{name}$",

    "^{name}:$",
    "%s{name}:$",
    "^{name}:[,!%s%?].*",
    "%s{name}:[,!%s%?].*",
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

checkNoArg("!{name}")
checkNoArg("!{name} arg")
checkNoArg("!{name} arg.arg")

checkArg("{name}:arg")
checkArg("{name}:arg.arg", "arg.arg")
checkArg("{name}:arg is the answer")
checkArg("{name}:arg.arg is the answer", "arg.arg")
checkArg("Test {name}:arg")
checkArg("Test {name}:arg.arg", "arg.arg")
checkArg("{name}:arg!")
checkArg("{name}:arg.arg!", "arg.arg")
checkArg("Test {name}:arg!")
checkArg("Test {name}:arg.arg!", "arg.arg")
checkArg("{name}:arg.")
checkArg("{name}:arg.arg.", "arg.arg")
checkArg("{name}:arg.....")
checkArg("{name}:arg.arg....", "arg.arg")
checkArg("Test {name}:arg?")
checkArg("Test {name}:arg.arg?", "arg.arg")
checkArg("Test {name}:arg.")
checkArg("Test {name}:arg.arg.", "arg.arg")
checkArg("Test {name}:arg.....")
checkArg("Test {name}:arg.arg....", "arg.arg")

checkArgError("!{name}")
checkArgError("{name}:")
checkArgError("{name}:.")
checkArgError("{name}:?")
checkArgError("{name}:!")
checkArgError("{name}: blabla")
checkArgError("bloblo{name}: blabla", true)
