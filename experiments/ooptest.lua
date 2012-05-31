Matrix = {}
local mt = {}

function Matrix:new(dimentions)
  return setmetatable({dimention=dimentions}, mt)
end

function Matrix:set(index, value)
  if rawget(self,"dimention") == 1 then
    rawset(self, index, value)
  else
    error("Cannot manually create intermediate dimentions")
  end
end
mt.__newindex = Matrix.set

function Matrix:get(index, ...)
  local target = rawget(self, index)
  print(index, type(target))
  if type(target) == "function" then
    target(self, index, unpack(arg))
  end
  
  local dim = rawget(self,"dimention")
  if dim == 1 then
    return target

  else
    if target == nil then
      target = Matrix:new(dim-1)
      rawset(self, index, target)
    end
    return target
  end
end
mt.__index = Matrix.get

function Matrix:print()
  for k,v in pairs(self) do
    print(k,v)
  end
end

m = Matrix:new(3)
m[3][4][-1] = 3
print(m[3][4][-1])
local a = m[3][5][1]
print(m.print)
