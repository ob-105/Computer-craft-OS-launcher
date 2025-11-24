-- gps.lua
return {
    name = "GPS",
    description = "Shows your current GPS coordinates.",
    image = {
        "############",
        "#          #",
        "#   GPS    #",
        "#          #",
        "############",
        "############"
    },
    run = function()
        print("GPS Viewer")
        print("Press Ctrl+T to exit")
        while true do
            local x, y, z = gps.locate(2)
            term.clear()
            term.setCursorPos(1,1)
            if x then
                print("GPS Connected")
                print("X: " .. math.floor(x))
                print("Y: " .. math.floor(y))
                print("Z: " .. math.floor(z))
            else
                print("GPS: No Signal")
            end
            sleep(2)
        end
    end
}
