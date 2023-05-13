local monitor = peripheral.find("monitor")
monitor.setTextScale(0.5)

local width, height = monitor.getSize()
local screen =
{
    width = width,
    height = height
}


monitor.clear()

local function drawVLine(w0, h0, size, color)
    for i = h0 , h0 + size do
        monitor.setCursorPos(w0, i)
        monitor.blit(" ", "f", color)
    end
end

local function drawHLine(w0, h0, size, color)
    for i = w0 , w0 + size do
        monitor.setCursorPos(i, h0)
        monitor.blit(" ", "f", color)
    end
end

local function FEPtyPrint(value)
    local unit = 1
    local tmp = value
    local units = {" FE", " kFE", " MFE", " GFE", " TFE", " EFE", " ZFE", " YFE"}

    while tmp > 1000 do
        tmp = tmp / 1000
        unit = unit + 1
    end

    tmp = value / math.pow(10, (unit - 1)*3)
    tmp = math.floor(tmp* 10 + 0.5) / 10

    return tmp .. units[unit]
end

local function writeAt(x,y, value, colour)
    tmpColour = monitor.getTextColour()
    monitor.setTextColour(colour)
    monitor.setCursorPos(x,y)
    monitor.write(value)
    monitor.setTextColour(tmpColour)
end

local function drawPoints(t, min, max, x0, x1, y0, y1)

end

return { screen = screen, drawVLine = drawVLine, drawHLine = drawHLine, FEPtyPrint = FEPtyPrint, writeAt = writeAt, drawPoints = drawPoints}