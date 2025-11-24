-- ui.lua
local ui = {}

function ui.clear()
    term.clear()
    term.setCursorPos(1,1)
end

function ui.drawText(x, y, text, color)
    term.setCursorPos(x, y)
    term.setTextColor(color or colors.white)
    term.write(text)
end

function ui.drawImage(x, y, image)
    if not image then return end
    for i, line in ipairs(image) do
        term.setCursorPos(x, y + i - 1)
        term.write(line)
    end
end

function ui.drawArrows(top, bottom)
    if top then
        ui.drawText(1, 3, "↑", colors.yellow)
    end
    if bottom then
        ui.drawText(1, 9, "↓", colors.yellow)
    end
end

return ui
