-- Config
local interval = 2

-- Code
local probe = require("probe")
local graph = require("graph")


local nbValues = math.floor(graph.screen.width*2/3)
nbValues = nbValues - 10

local tVal = {}
for i = 1, nbValues do
    table.insert(tVal, 0)
end

while true do
    graph.clear()

    -- Get Cur Values
    local curEnergy = probe.getEnergy()
    local curEnergyStr = graph.FEPtyPrint(curEnergy)
    local maxEnergy = probe.getMaxEnergy()
    local maxEnergyStr = graph.FEPtyPrint(maxEnergy)
    local percent = probe.getPercentEnergy()

    -- Insert in tab
    table.insert(tVal, nbValues+1, curEnergy)
    table.remove(tVal, 1)

    -- draw graph
    graph.drawVLine(10, 3, graph.screen.height - 4, "0")
    graph.drawHLine(10, graph.screen.height-1 , nbValues+1, "0")
    --get min and max
    local min = tVal[1]
    local max = tVal[1]
    for k,v in pairs(tVal) do
        if v < min then
            min = v
        end 
        if v > max then
            max = v
        end
    end

    graph.writeAt(1, 3, graph.FEPtyPrint(max), colors.white)
    graph.writeAt(1, graph.screen.height-1, graph.FEPtyPrint(min), colors.white)

    graph.drawPoints(tVal, min, max, 11, nbValues, 3, graph.screen.height-2)

    -- draw right battery
    local w1 = nbValues+18
    local h1 = 10
    graph.writeAt(w1, h1, "Max ".. maxEnergyStr, colors.white)
    local greenBarNb = math.floor(percent * 10/100)
    local tmpI = 1
    for i = 1, (10-greenBarNb-1) do
        graph.writeAt(w1, h1+i*2, "----------", colors.red)
        tmpI = tmpI+1
    end
    graph.writeAt(w1, h1+tmpI*2, curEnergyStr, colors.white)
    for i = tmpI+1, 10 do
        graph.writeAt(w1, h1+i*2, "----------", colors.green)
    end
    graph.writeAt(w1, h1 + 22, "Min 0 FE", colors.white)

    -- Write current speed
    local speed = (tVal[nbValues] - tVal[nbValues-1]) / (20*(interval+3))
    local speedColor = colors.green
    local speedSign = "+"
    if speed < 0 then
        speedColor = colors.red
        speedSign = ""
    end
    graph.writeAt(nbValues+1, 2, speedSign .. graph.FEPtyPrint(speed) .. "/t", speedColor)

    
    sleep(interval)
end