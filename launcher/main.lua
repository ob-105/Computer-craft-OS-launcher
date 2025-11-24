-- main.lua
local apps = require("launcher/apps")
local ui = require("launcher/ui")

local scrollIndex = 1
local selectedApp = 1

-- Draw system info at the top
local function drawSystemInfo()
    ui.drawText(1, 1, "GPS: Connected", colors.green)
    ui.drawText(1, 2, "Chat: Online", colors.green)
end

-- Draw the scrollable app list
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

-- Draw image and description of selected app
local function drawAppDetails()
    local app = apps[selectedApp]
    if not app then return end
    ui.drawImage(2, 10, app.image)
    ui.drawText(2, 16, app.description)
end

-- Full screen render
local function render()
    ui.clear()
    drawSystemInfo()
    drawAppList()
    drawAppDetails()
end

-- Main input loop
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
            shell.run(apps[selectedApp].name)
        end

    elseif event == "mouse_click" then
        local button, x, y = p1, p2, p3

        -- Scroll arrows
        if y == 3 and scrollIndex > 1 then
            scrollIndex = scrollIndex - 1
            selectedApp = math.max(scrollIndex, selectedApp - 1)
        elseif y == 9 and scrollIndex + 5 <= #apps then
            scrollIndex = scrollIndex + 1
            selectedApp = math.min(scrollIndex + 4, selectedApp + 1)

        -- App selection
        elseif y >= 4 and y <= 8 then
            local appIndex = scrollIndex + (y - 4)
            if apps[appIndex] then
                selectedApp = appIndex
            end

        -- Launch app by tapping bottom
        elseif y >= 15 then
            shell.run(apps[selectedApp].name)
        end
    end
end
