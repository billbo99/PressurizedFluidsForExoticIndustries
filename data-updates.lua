-- multiply a number with a unit (kJ, kW etc) at the end
---@param property string
---@param mult number
---@return string|number
local function multiply_number_unit(property, mult)
    local value, unit
    value = string.match(property, "%d+")
    if string.match(property, "%d+%.%d+") then -- catch floats
        value = string.match(property, "%d+%.%d+")
    end
    unit = string.match(property, "%a+")
    if unit == nil then
        return value * mult
    else
        return ((value * mult) .. unit)
    end
end

---@param str string
---@param start string
---@return boolean
local function starts_with(str, start)
    return str:sub(1, #start) == start
end

local multiplyier = settings.startup['fluid-compression-rate'].value ---@cast multiplyier integer

for _, fluid in pairs(data.raw['fluid']) do
    if fluid.fuel_value then
        compressed_fuel_value = multiply_number_unit(fluid.fuel_value, multiplyier)
    end
end
