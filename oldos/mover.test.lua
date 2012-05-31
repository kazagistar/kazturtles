shell.run("mover.lua")
shell.run("persistance.lua")

bRead = true
while(bRead) do
    print("up = up, down = down, w = north, s = south, a = west, d = east, enter = quit")
    sEvent, param = os.pullEvent("key")
    if(sEvent == "key") then
        if(param == 28) then
            print("Goodbye!")
            bRead = false
        elseif(param == 200) then
            mover.up()
        elseif(param == 208) then
            mover.down()
        elseif(param == 17) then
            mover.move(mover.north)
        elseif(param == 30) then
            mover.move(mover.west)
        elseif(param == 31) then
            mover.move(mover.south)
        elseif(param == 32) then
            mover.move(mover.east)
        end
        print("x="..persistance.read("xpos").." y="..persistance.read("ypos").." z="..persistance.read("zpos"))
    end
end
