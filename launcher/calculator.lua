-- calculator.lua
print("Calculator")
print("Type an expression (e.g. 2+2) and press Enter")
print("Press Ctrl+T to exit")

while true do
    term.write("> ")
    local input = read()
    local fn, err = load("return " .. input)
    if fn then
        local ok, result = pcall(fn)
        if ok then
            print("= " .. tostring(result))
        else
            print("Error: " .. tostring(result))
        end
    else
        print("Invalid expression: " .. tostring(err))
    end
end
