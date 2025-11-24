-- init.lua

-- Create launcher folder if it doesn't exist
if not fs.exists("launcher") then
    fs.makeDir("launcher")
end

-- Install launcher to startup
if fs.exists("startup.lua") then
    fs.delete("startup.lua")
end
fs.copy("launcher/main.lua", "startup.lua")

print("Launcher installed to startup.")
