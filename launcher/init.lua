-- init.lua
-- Installer for modular ComputerCraft Launcher

local githubBase = "https://raw.githubusercontent.com/ob-105/Computer-craft-OS-launcher/refs/heads/main/launcher/"
local files = { "main.lua", "apps.lua", "ui.lua", "chat.lua", "gps.lua", "calculator.lua" }

-- Ensure launcher folder exists
if not fs.exists("launcher") then
    fs.makeDir("launcher")
    print("Created folder: launcher")
end

-- Delete old files and download fresh ones
for _, file in ipairs(files) do
    local path = "launcher/" .. file
    if fs.exists(path) then
        fs.delete(path)
        print("Deleted old: " .. path)
    end
    local url = githubBase .. file
    shell.run("wget", url, path)
    print("Downloaded: " .. path)
end

-- Replace startup.lua with launcher entry point
if fs.exists("startup.lua") then
    fs.delete("startup.lua")
    print("Deleted old startup.lua")
end
fs.copy("launcher/main.lua", "startup.lua")
print("Installed launcher to startup.lua")

print("✅ Setup complete! Reboot to launch.")
