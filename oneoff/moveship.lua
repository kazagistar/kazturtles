DELAY = 1/5 -- This is about how long it takes for minecraft to react to redstone changes
function setout(color)
  redstone.setBundledOutput("bottom", color)
  os.sleep(DELAY)
end
setout(0)
while true do
  setout(colors.yellow)
  setout(colors.green)
  setout(colors.yellow)
  setout(colors.red)
  setout(colors.yellow)
  setout(colors.blue)
  os.sleep(0.7)
end
