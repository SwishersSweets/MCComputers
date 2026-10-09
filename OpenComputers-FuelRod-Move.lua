local transposer = require("component").transposer

local sourceSide = 4
local targetSide = 1
local targetLabel = "Quad Fuel Rod (Depleted MOX)"

local size = transposer.getInventorySize(sourceSide)

if size then
    for slot = 1, size do
        local item = transposer.getStackInSlot(sourceSide, slot)

        if item and item.label == targetLabel then
            local moved = transposer.transferItem(
                sourceSide,
                targetSide,
                item.size,
                slot
            )

            if moved > 0 then
                print("Moved " .. moved .. "x " .. item.label)
            end
        end
    end
end