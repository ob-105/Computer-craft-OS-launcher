-- init.lua
local fs = require("fs")

-- Copy main launcher to startup
local function install()
    if fs.exists("startup.lua") then
        fs.delete("startup.lua")
    end
    fs.copy("launcher/main.lua", "startup.lua")
    print("Launcher installed to startup.")
end

install()
