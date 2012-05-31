shell.run("persistance.lua")
persistance.write("testvar", 100)
if 100 ~= persistance.delete("testvar") then
    print("persistance.write test passed")
else
    print("persistance.write test FAILED")
end
persistance.delete("testvar")
if nil == persistance.delete("testvar") then
    print("persistance.delete test passed")
else
    print("persistance.delete test FAILED")
end
