local registry = require("./registry")

registry.add("^!lua%s+(.+)", function(message, func)
    return "https://www.lua.org/manual/5.1/manual.html#pdf-" .. func
end, "!lua", "Look up the documentation on a lua function.")
