persistance = {}
persistance.path = "/persistance/"
if fs.exists(persistance.path) == false then
    fs.makeDir(persistance.path)
end

function persistance.write(name, value)
    local file = io.open(persistance.path..name, "w")
    file:write(value)
    file:close()
end

function persistance.delete(name)
    fs.delete(persistance.path..name)
end

function persistance.read(name)
    local file = io.open(persistance.path..name, "r")
    if file then
        local value = file:read()
        file:close()
        return value
    else
        return nil
    end
end
