local oldPull = os.pullEvent;
os.pullEvent = os.pullEventRaw;
term.clear()
term.setCursorPos(1,1)
write("WARNING!!!\n")
write("This experimental station is property of kazagistar\n")
write("Unauthorized entry strictly prohibited\n")
write("Enter Password: ")
local pass = read("*")
if pass == ("athis") then
    write("Opening Door")
    redstone.setOutput("right", true )
    sleep(3)
    redstone.setOutput("right", false )
    os.shutdown()
end
write("Incorrect Password")
sleep(2)
term.clear()
term.setCursorPos(1,1)
textutils.slowPrint("Terminal Locking Down in 3... 2... 1...")
sleep(1)
os.shutdown()
