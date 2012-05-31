shell.run("persistance.lua")
shell.run("mover.lua")

pathing = {}

-- Sometimes, it is needed to select choices nondeterministically, so as to avoid deadlock
-- fisher-yates, http://www.gammon.com.au/forum/?id=9908
function pathing.shuffle(t)
  local n = #t
  while n >= 2 do
    local k = math.random(n)
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end
  return t
end

pathing.avoidheadings = {}
pathing.avoidheadings[0] = {1,3,4}
pathing.avoidheadings[1] = {0,2,4}
pathing.avoidheadings[2] = {1,3,4}
pathing.avoidheadings[3] = {0,2,4}
pathing.avoidheadings[4] = {0,1,2,3}
pathing.avoidheadings[5] = {0,1,2,3}

function pathing.trydirection(heading)
    if heading == 4 then
        r = mover.up()
    elseif heading == 5 then
        r = mover.down()
    else
        r = mover.move(heading)
    end
    return r
end

function pathing.avoid(heading)
    for _,dir in ipairs(pathing.shuffle(pathing.avoidheadings[heading])) do
        while pathing.trydirection(dir) do
            if pathing.trydirection(heading) then return true end
        end
    end
    return false
end

function pathing.goto(tarx,tary,tarz)
    local goal = false
    local xpos = 0
    local ypos = 0
    local zpos = 0
    local try = false
    
    while not goal do
        xpos = tonumber(persistance.read("xpos"))
        if xpos > tarx then
            if not mover.move(1) then pathing.avoid(1) end
        elseif xpos < tarx then
            if not mover.move(3) then pathing.avoid(3) end
        else
            goal = true
        end
    end
    goal = false
    
    while not goal do
        zpos = tonumber(persistance.read("zpos")) 
        if zpos > tarz then
            if not mover.move(2) then pathing.avoid(2) end
        elseif zpos < tarz then
            if not mover.move(0) then pathing.avoid(0) end
        else
            goal = true
        end
    end
    goal = false
    
    while not goal do
        ypos = tonumber(persistance.read("ypos")) 
        if ypos > tary then
            if not mover.down() then pathing.avoid(5) end
        elseif ypos < tary then
            if not mover.up() then pathing.avoid(4) end
        else
            goal = true
        end
    end
    
    if ((not persistance.read("xpos") == tarx) or (not persistance.read("ypos") == tary) or (not persistance.read("zpos") == tarz)) then
        pathing.goto(tarx, tary, tarz)
    end
end
