-- listen.lua program - Receive log messages from computers
-- log4cc compatible
peripheral.find("modem", rednet.open)
while true do
    local id, msg = rednet.receive()
    write(msg)
end
