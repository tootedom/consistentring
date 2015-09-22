--
-- Date: 13/09/2015
--
local jenkins = require("org/greencheek/hashing/jenkins")
local floor = math.floor

continuum = {}

local function selectionsort(x,n,f)
    local i=1
    while i<=n do
        local m,j=i,i+1
        while j<=n do
            if f(x[j],x[m]) then m=j end
            j=j+1
        end
        x[i],x[m]=x[m],x[i]			-- swap x[i] and x[m]
        i=i+1
    end
end

local function createring(data,table)

    local numberofoptions = 0
    for _ in pairs(data) do numberofoptions = numberofoptions + 1 end
    local arrayofhashes = {}
    local options = {}
    local optionposition = 0
    for key,value in pairs(data) do
        local pointsPerServer = floor((((value/100) * (160 / 4)) * numberofoptions) + 0.0000000001)*4
        local position = 1
        while position<=pointsPerServer do
            local hash = jenkins(key .. "-" .. position)
            table[hash] = key
            arrayofhashes[position+optionposition] = hash
            position = position + 1
        end
        optionposition = position - 1
    end

    local numberofkeys = #arrayofhashes
    selectionsort(arrayofhashes,numberofkeys,function(a,b) return a < b end)
    local position = 1
    while position<=numberofkeys do
        options[position] = table[arrayofhashes[position]]
        position = position +1
    end

    table["sortedkeys"] = arrayofhashes
    table["numberofsortedkeys"] = #arrayofhashes
    table["sortedoptions"] = options

end



function continuum:new(data)
    local o = {}
    setmetatable(o,self)
    self.__index = self
    createring(data,o)
    return o
end

local function getindex(hashVal, sortedNodePositions ,arraylength)
    local low = 1;
    local high = arraylength;
    -- Check for edge cases
    if hashVal > sortedNodePositions[high] then
        return 1;
    end
    if hashVal <= sortedNodePositions[low] then
        return 1;
    end

    while true do
        -- div by two
        local mid = floor((low+high)/2)
        if mid <= 0 then mid = 1 end
        local midVal = sortedNodePositions[mid];
        if midVal == hashVal then
            return mid;
        elseif midVal < hashVal then
            low = mid + 1;
            if (sortedNodePositions[low] >= hashVal) then
                return low;
            end
        else
            high = mid - 1;
            if (sortedNodePositions[high] < hashVal) then
                return mid;
            end
        end
    end
end

function continuum:get(string)
    local index = getindex(jenkins(string),self["sortedkeys"],self["numberofsortedkeys"])
    return self["sortedoptions"][index]
end


