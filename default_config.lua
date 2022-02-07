-- Default config template of log4cc
local log4cc = require "lib.log4cc"

return {
    console = {
        enabled = true,
        format = "[{time}][{level}] {content}{newline}",
        level = log4cc.logLevel.info
    },
    file = {
        enabled = false,
        format = "[{time}][{level}] {content}{newline}",
        level = log4cc.logLevel.info,
        fileName = nil
    },
    remote = {
        enabled = false,
        format = "[{time}][{level}] {source}: {content}{newline}",
        level = log4cc.logLevel.info,
        targetID = {} -- fill the ID of receiver computers in this array, e.g. {1, 2, 3}
    }
}
