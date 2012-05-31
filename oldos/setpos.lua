local tArgs = { ... }

shell.run("persistance.lua")

persistance.write("xpos", tArgs[1])
persistance.write("ypos", tArgs[2])
persistance.write("zpos", tArgs[3])
persistance.write("direction", tArgs[4])