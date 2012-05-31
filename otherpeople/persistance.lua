local function stringSave(tbl,name)  
    assert(name:sub(1,1)~="_","Variable names cannot start with _")
    assert(not name:find("[:/\*|<>;%s]"),"Variable name contains illegal variable, you cannot use ://\*|<>;%s")
    local filePath=rawget(tbl,"_PVarPath")
    local fileName = fs.combine(filePath,name..".var")
    if not fs.exists(filePath) then
            fs.makeDir(filePath)
    end
    return fileName
end

local function stringSave

function new(tbl,pathName)
    local v={_PVarPath=pathName or "/vars/"}  
    setmetatable(v,
    {       __index=function(tbl,name)
            local vFile=getVariableFilename(tbl,name)
            local f = io.open(vFile, "r")
            if f then
                local content = textutils.unserialize(f:read())
                f:close()
                return content
            else
                return nil
            end
        end,
        __newindex=function(tbl,name,value)
            local vFile=getVariableFilename(tbl,name)
            if value then   
                local f = io.open(vFile, "w")       
                assert(f,"FAIL: could not open file")
                f:write(textutils.serialize(value))
                f:close()
            else
                fs.delete(vFile)
            end
        end
    })
    return v
end
