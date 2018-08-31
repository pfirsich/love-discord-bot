local commands = {}

commands.registry = require("./registry")

require("./lua")
require("./shortcut")
require("./wiki")
require("./info")
require("./pingresponse")
require("./quote")
require("./showcase")

return commands
