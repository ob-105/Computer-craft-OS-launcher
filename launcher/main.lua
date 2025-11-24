-- main.lua
local apps = require("launcher/apps")
local ui = require("launcher/ui")

local scrollIndex = 1
local selectedApp = 1

-- GPS status
local function getGPSStatus()
    local x, y, z = gps.locate(2)
    if x then
        return "GPS: Connected (" .. math.floor(x) .. "," .. math.floor(y) .. "," .. math.floor(z) .. ")"
    else
        return "GPS: No Signal"
    end
end

-- Chat status (global channel = 1)
local function getChatStatus()
    local modem = peripheral.find("modem")
    if modem and modem.isOpen(1) then
        return "Chat: Global Online"
    else
        return "Chat: Offline"
    end
end

-- Draw system info
local function drawSystemInfo()
    ui.drawText(1, 1, getGPSStatus(), colors.green)
    ui.drawText(1, 2, getChatStatus(), colors.green)
end

-- Draw app list
local function drawAppList()
    for i = 0, 4 do
        local appIndex = scrollIndex + i
        local app = apps[appIndex]
        if app then
            local y = 4 + i
            local prefix = (appIndex == selectedApp) and ">" or " "
            ui.drawText(2, y, prefix .. app.name)
        end
    end
    ui.drawArrows(scrollIndex > 1, scrollIndex + 5 <= #apps)
end

-- Draw app details
local function drawAppDetails()
    local app = apps[selectedApp]
    if not app then return end
    ui.drawImage(2, 10, app.image)
    ui.drawText(2, 16, app.description)
end

-- Render screen
local function render()
    ui.clear()
    drawSystemInfo()
    drawAppList()
    drawAppDetails()
end

-- Main loop
while true do
    render()
    local event, p1, p2, p3 = os.pullEvent()

    if event == "key" then
        local key = p1
        if key == keys.up and scrollIndex > 1 then
            scrollIndex = scrollIndex - 1
            selectedApp = math.max(scrollIndex, selectedApp - 1)
        elseif key == keys.down and scrollIndex + 5 <= #apps then
            scrollIndex = scrollIndex + 1
            selectedApp = math.min(scrollIndex + 4, selectedApp + 1)
        elseif key == keys.enter then
            shell.run("launcher/" .. apps[selectedApp].name:lower())
        end

    elseif event == "mouse_click" then
        local button, x, y = p1, p2, p3

        if y == 3 and scrollIndex > 1 then
            scrollIndex = scrollIndex - 1
            selectedApp = math.max(scrollIndex, selectedApp - 1)
        elseif y == 9 and scrollIndex + 5 <= #apps then
            scrollIndex = scrollIndex + 1
            selectedApp = math.min(scrollIndex + 4, selectedApp + 1)
        elseif y >= 4 and y <= 8 then
            local appIndex = scrollIndex + (y - 4)
            if apps[appIndex] then
                selectedApp = appIndex
            end
        elseif y >= 15 then
            shell.run("launcher/" .. apps[selectedApp].name:lower())
        end
    end
end
