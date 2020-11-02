
function love.load()
    love.window.setTitle('Poke50')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    require 'src/Dependencies'
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    -- this time, we are using a stack for all of our states, where the field state is the
    -- foundational state; it will have its behavior preserved between state changes because
    -- it is essentially being placed "behind" other running states as needed (like the battle
    -- state)

    gStateStack = StateStack()
    gStateStack:push(StartState())

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end

function rgba(r, g, b, a)
    -- a = a > 1 and a / 255 or a
    if not a then
        a = 1
    else
        a = a / 255
    end

    return r / 255, g / 255, b / 255, a
end
