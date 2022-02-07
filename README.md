# Log4CC

A simple log system for your programs in CC: Tweaked mod of Minecraft.

## Usage

First download the lib via `wget`:

```
wget run https://gitlab.com/-/snippets/2249573/raw/main/get_log4cc.lua
```

This remote script will get the latest version of log4cc and save it into `lib/log4cc.lua`.

### Simple Logging

Include the module in your program:

```lua
local log4cc = require "lib.log4cc"
```

Then use `log4cc.info()`, `log4cc.debug()`, `log4cc.warn()` and `log4cc.error()` to make log:

```lua
log4cc.info("Hello log4cc!")
log4cc.debug("Some debugging message")
log4cc.warn("You'd better watch out...")
log4cc.error("Something went wrong!")
```

The default config only enables console logging. Beside this, log4cc supports file and remote logging.

### Configuration

#### Method 1: Edit config in your program

The config data is stored in `log4cc.config` as a table. The following piece of code enables file logging into `log.txt`:

```lua
log4cc.config.file.enabled = true
log4cc.config.file.fileName = "log.txt"

log4cc.info("log something")
```

Use `edit log.txt` in CraftOS to read the log.

#### Method 2: Import config from file

First get the default config template:

```
wget run https://gitlab.com/-/snippets/2249573/raw/main/get_config.lua
```

Type `edit config.lua`, then you can make configuration as you like, for example enable the remote logging and make computer #5 as the receiver:

```lua
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
        enabled = true, -- modify into true
        format = "[{time}][{level}] {source}: {content}{newline}",
        level = log4cc.logLevel.info,
        targetID = {5} -- set computer #5 as the receiver
    }
}
```

Now import the config in your program:

```lua
log4cc.config = require "config"
```

### Remote Logging

Let's say you have a mining turtle in your cave and you are 1000 blocks away from your home. You want to make sure the turtle is working well all the time. Walking back to home takes too much time, then you can use remote log in the mining program of your turtle and target your mobile computer as the receiver.

First, include log4cc in your mining program, and do some configuration:

```lua
local log4cc = require "lib.log4cc"
log4cc.config.remote.enabled = true
log4cc.config.remote.targetID = {3} -- Replace the 3 with the ID of your own mobile computer
```

Then, send log while turtle's working:

``` lua
if outOfFuel then
    log4cc.warn("Out of fuel!") -- Use log4cc.warn or log4cc.error if someting went wrong
end
if inventoryIsFull then
    log4cc.warn("Inventory is full!")
end
dig()
log4cc.log("Dig success!")
```

Finally, run a listener program on your mobile computer to receive log. We have already prepared one, download it by running:

```
wget run https://gitlab.com/-/snippets/2249573/raw/main/get_listener.lua
```

Then type `listen` to start listening. Hold `Ctrl+T` to terminate it.

### Custom Formatting

Edit the `format` string of logging method in `log4cc.config` to modify log format. You can use some symbols to output time, log level, ID of the log sender, etc.

```
{time}    --  System time, like "11:02:40"
{level}   --  Log level, like "Info", "Warn", "Error", "Debug"
{content} --  The content of log
{source}  --  Lable and ID of the log sender, like "#6 Mining Turtle". Useful in remote logging
{newline} --  Start a new line
```

## Bug report

Please file an issue at [here](https://gitlab.com/MineCommander/log4cc/-/issues/new) if anything comes out of the expected.

## Contribution

Merge Requests are welcome if you have any great ideas!
