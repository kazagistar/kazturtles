function create(dimentions)
  local self = {}
  self.dimention = dimentions
  return self
end

-- this is a abuse of next, and is bad bad code, sorry
function isempty(self)
  return next(self,next(self))~=nil
end

function set(self, index, ...)
  if self.dimention == 1 then
    self[index] = arg[1]
  else
    if self[index] == nil then
      self[index] = create(self.dimention-1)
    end
    set(self[index], unpack(arg))
    if isempty(self[index]) then
      self[index] = nil
    end
  end
end

function get(self, index, ...)
  if self.dimention == 1 then
    return self[index]
  else
    if self[index] == nil then
      return nil
    else
      return get(self[index],unpack(arg))
    end
  end
end

-- Recursive deep-copy utility function
local function copy(self)
  if type(self) ~= "table" then return self end
  local new = {}
  for k,v in pairs(self) do
    new[k] = copy(v)
  end
  return new
end

-- Here is where the real magic begins... slices galore!
-- Imagine you have a 3 dimentional matrix. The parameters to this function are "slice(array, min_x, max_x, min_y, max_y, min_z, max_z)"
-- This returns a new matrix, only without everything outside the designated area
function slice(self, min, max, ...)
  if type(self) ~= "table" then return self end
  local new = {}
  for k,v in pairs(self) do
    if type(k) ~= "number" or (k >= min and k <= max) then
      new[k] = slice(v, unpack(arg))
    end
  end
  return new
end


-- Copies the values of one array onto another
function merge(destination, source)
  if source.dimention == 1 then
    for k,v in source do
      destination[k] = v
    end
  else
    for k,v in source do
      if destination[k] == nil then
        destination[k] = copy(v)
      else
        merge(destination[k], v)
      end
    end
  end
end

-- Creates a new array with every point translated by the ammount given
-- eg translate(m, 2, 0, -3) moves all the points in the array +2 in the X dimention and -3 in the Z dimention
function translate(self, offset, ...)
  if offset==nil then return self end
  local new = {}
  for k,v in pairs(self) do
    if type(k) == "string" then offset = "" end
    new[k+offset] = translate(v, unpack(arg))
  end
  return new
end
