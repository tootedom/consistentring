--
-- Only works with ASCII strings.
--
-- Date: 13/09/2015
--
--
--
local bit = require('bit')
local xor, band, shr = bit.bxor, bit.band,bit.rshift
local byte = string.byte


local function jenkinshash(data)
    local len = #data
    local i = 1
    local limit = len
    local hash = 0
    while i<=limit do
        local b = byte(data,i)
        hash = hash + band(b,0xFF)
        hash = hash + (hash * 2 ^ 10)
        hash = xor(hash,shr(hash,6))
        i = i + 1
    end
    hash = hash + (hash * 2 ^ 3)
    hash = xor(hash,shr(hash,11))
    hash = hash + (hash * 2 ^ 15)
    return ( ( (shr(hash,1) * 2) + band(hash,1) ) % (0xFFFFFFFF+1));
end

return jenkinshash