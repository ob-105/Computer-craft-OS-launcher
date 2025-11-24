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
        if key == keys.up and selectedApp > 1 then
            selectedApp = selectedApp - 1
            if selectedApp < scrollIndex then
                scrollIndex = scrollIndex - 1
            end
        elseif key == keys.down and selectedApp < #apps then
            selectedApp = selectedApp + 1
            if selectedApp > scrollIndex + 4 then
                scrollIndex = scrollIndex + 1
            end
        elseif key == keys.enter then
            local appName = apps[selectedApp].name:lower()
            local path = "launcher/" .. appName .. ".lua"
            if fs.exists(path) then
                shell.run(path)
            else
                print("App not found: " .. path)
                sleep(1)
            end
        end

    elseif event == "mouse_click" then
        local button, x, y = p1, p2, p3

        if y >= 4 and y <= 8 then
            local appIndex = scrollIndex + (y - 4)
            if apps[appIndex] then
                selectedApp = appIndex
            end
        elseif y >= 15 then
            local appName = apps[selectedApp].name:lower()
            local path = "launcher/" .. appName .. ".lua"
            if fs.exists(path) then
                shell.run(path)
            else
                print("App not found: " .. path)
                sleep(1)
            end
        end
    end
end
