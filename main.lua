-- main.lua
local apps = require("launcher/apps")
local ui = require("launcher/ui")

local scrollIndex = 1
local selectedApp = 1

local function drawSystemInfo()
    ui.drawText(1, 1, "GPS: Connected", colors.green)
    ui.drawText(1, 2, "Chat: Online", colors.green)
end

local function drawAppList()
    for i = 0, 4 do
        local app = apps[scrollIndex + i]
        if app then
            local y = 4 + i
            local prefix = (scrollIndex + i == selectedApp) and ">" or " "
            ui.drawText(2, y, prefix .. app.name)
        end
    end
    ui.drawArrows(scrollIndex > 1, scrollIndex + 5 <= #apps)
end

local function drawAppDetails()
    local app = apps[selectedApp]
    if not app then return end
    ui.drawImage(2, 10, app.image)
    ui.drawText(2, 16, app.description)
end

local function render()
    ui.clear()
    drawSystemInfo()
    drawAppList()
    drawAppDetails()
end

-- Main loop
while true do
    render()
    local e, key = os.pullEvent("key")
    if key == keys.up and scrollIndex > 1 then
        scrollIndex = scrollIndex - 1
        selectedApp = math.max(scrollIndex, selectedApp - 1)
    elseif key == keys.down and scrollIndex + 5 <= #apps then
        scrollIndex = scrollIndex + 1
        selectedApp = math.min(scrollIndex + 4, selectedApp + 1)
    elseif key == keys.enter then
        -- Launch selected app (placeholder)
        shell.run(apps[selectedApp].name)
    end
end
