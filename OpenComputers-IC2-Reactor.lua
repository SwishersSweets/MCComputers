-- requires OpenSecurity for the alarm stuff
-- tested on The Lost Era Modpack (1.7.10) with OC 1.8.3

local c = require("component")
local sides = require("sides")
local rs = c.redstone
local reactor = c.reactor_chamber
local alarm = c.os_alarm
-- Initial Setup
alarm.setAlarm("klaxon1")
alarm.setRange(150)
alarm.deactivate()
rs.setOutput(2,15) -- 2 means back

--print(reactor.producesEnergy())
--print(reactor.getReactorEnergyOutput())

function oofCheck()
  if reactor.producesEnergy() == true then
   if reactor.getReactorEnergyOutput() == 0.0 then
    rs.setOutput(2,0)
    print("OUT OF FUEL")
    error("OUT OF FUEL")
    else
      return 0
    end
  else 
  return 0
  end
end

function heatMath()
  if reactor.getHeat() <= (reactor.getMaxHeat() / 2) then
    return false -- safe
  else
    return true -- DANGER ZONE 
  end
end

function danger()
  alarm.activate()
  rs.setOutput(2,0)
  os.exit()
end

while (true) do 
  if heatMath() == false then
    os.sleep(5)
  oofCheck()
  else
    print("Danger Reactor over heating")
    print(reactor.getHeat())
    danger()  
  end
end
