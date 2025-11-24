-- chat.lua
local modem = peripheral.find("modem")

if not modem then
    print("No modem found!")
    return
end

-- Open global channel (1)
modem.open(1)

print("Connected to Global Chat (channel 1)")
print("Type messages and press Enter. Press Ctrl+T to exit.")

local function sendMessage(msg)
    modem.transmit(1, 1, msg)
end

while true do
    local event, p1, p2, p3, p4 = os.pullEvent()

    if event == "modem_message" then
        local side, channel, replyChannel, message = p1, p2, p3, p4
        if channel == 1 then
            print("Global: " .. tostring(message))
        end

    elseif event == "key" and p1 == keys.enter then
        term.write("> ")
        local msg = read()
        sendMessage(msg)
    end
end
