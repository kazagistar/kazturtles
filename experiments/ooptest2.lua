local mt; mt = {__index=function(t,k) local v=setmetatable({},mt) rawset(t,k,v) return v end; } ); function new_muldim () return setmetatable({},mt) end
