-- calculator.lua
return {
    name = "Calculator",
    description = "A simple calculator for math operations.",
    image = {
        "############",
        "#          #",
        "#   Calc   #",
        "#          #",
        "############",
        "############"
    },
    run = function()
        print("Calculator")
        print("Type an expression (e.g. 2+2) and press Enter")
        print("Press Ctrl+T to exit")

        while true do
            term.write("> ")
            local input = read()
            local fn, err = load("return " .. input)
            if fn then
                local
