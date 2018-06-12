local registry = require("./registry")

registry.add("^!lua$", function()
    return "Please pass an argument, e.g.: `!lua io.open`"
end)

registry.add("^!lua%s+(.+)", function(message, func)
    return "https://www.lua.org/manual/5.1/manual.html#pdf-" .. func
end, "!lua <function>", "Look up the documentation on a lua function, e.g.: `!lua io.open`")
