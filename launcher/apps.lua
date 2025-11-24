-- apps.lua
-- Dynamically loads all apps in the launcher folder

local apps = {}

for _, file in ipairs(fs.list("launcher")) do
    if file:match("%.lua$") and file ~= "apps.lua" and file ~= "ui.lua" and file ~= "main.lua" then
        local ok, app = pcall(require, "launcher/" .. file:gsub("%.lua$", ""))
        if ok and type(app) == "table" and app.name then
            table.insert(apps, app)
        end
    end
end

return apps
