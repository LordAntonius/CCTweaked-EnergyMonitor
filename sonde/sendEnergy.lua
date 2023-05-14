-- Config
 
local sideInduction = "back"
local interval = 1
local recChan = 15
local sendChan = 16
 
-- Code
local mymath = require("mymath")
local modem = peripheral.find("modem") or error("No Modem attached", 0)local interface = peripheral.wrap(sideInduction)
 
print("Send chan : " .. sendChan)
print("Recv chan : " .. recChan)
print("{energy,maxenergy,percent}")
 
modem.open(recChan)
 
while true do
 
    local event,side, chan, repChan, msg, dist
    repeat
        event, side, chan, repChan, msg, dist = os.pullEvent("modem_message")
    until chan == recChan
 
 
    if msg == "energy" then
        modem.transmit(sendChan, recChan, interface.getEnergy()/2.5)
    elseif msg == "maxenergy" then
        modem.transmit(sendChan, recChan, interface.getMaxEnergy()/2.5)
    elseif msg == "percent" then
        local percent = 100*interface.getEnergy()/interface.getMaxEnergy()
        percent = mymath.round(percent,5)
        modem.transmit(sendChan, recChan, percent)
    else
        print("Unknown command")
        modem.transmit(sendChan, recChan, nil)
    end
    -- sleep(interval)
end