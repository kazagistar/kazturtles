shell.run("persistance.lua")

mover = {}
mover.south = 0
mover.west = 1
mover.north = 2
mover.east = 3
mover.up = 4
mover.down = 5

function mover.position()
    print(persistance.read("xpos")..", "..persistance.read("ypos")..", "..persistance.read("zpos")..", "..persistance.read("direction"))
end

function mover.face(direction)
    local current = tonumber(persistance.read("direction"))
    current = (current - direction) % 4
    if current == 1 then turtle.turnLeft()
    elseif current == 2 then turtle.turnRight() turtle.turnRight()
    elseif current == 3 then turtle.turnRight() end
    persistance.write("direction", direction)
end

function mover.move(direction)
    mover.position()
    mover.face(direction)
    if turtle.forward() then
        if direction == 0 then
            persistance.write("zpos", persistance.read("zpos") + 1)
        elseif direction == 1 then
            persistance.write("xpos", persistance.read("xpos") - 1)
        elseif direction == 2 then
            persistance.write("zpos", persistance.read("zpos") - 1)
        elseif direction == 3 then
            persistance.write("xpos", persistance.read("xpos") + 1)
        end
        return true
    else
        return false
    end
end

function mover.up()
    if turtle.up() then
        persistance.write("ypos", persistance.read("ypos") + 1)
        return true
    else
        return false
    end
end

function mover.down()
    if turtle.down() then
        persistance.write("ypos", persistance.read("ypos") - 1)
        return true
    else
        return false
    end
end
