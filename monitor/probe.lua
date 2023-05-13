-- Config

local sendChan = 15
local recChan = 16

-- Code
local modem = peripheral.find("modem") or error("No Modem attached", 0)
modem.open(recChan)

local function getValue(cmd)
    modem.transmit(sendChan, recChan, cmd)

    local event,side, chan, repChan, msg, dist
    repeat
        event, side, chan, repChan, msg, dist = os.pullEvent("modem_message")
    until chan == recChan

    sleep(1)
    return msg
end

local function getEnergy()
    return getValue("energy")
end

local function getMaxEnergy()
    return getValue("maxenergy")
end

local function getPercentEnergy()
    return getValue("percent")
end

return { getEnergy = getEnergy, getMaxEnergy = getMaxEnergy, getPercentEnergy = getPercentEnergy}