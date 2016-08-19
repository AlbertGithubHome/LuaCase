--[[
@action : judge the type of t
@params : the object need to judge
@return : judge the type of t is type whether you want to be
]]

function isnil(t)
    return type(t) == "nil"
end

function isnumber(t)
    return type(t) == "number"
end

function isstring(t)
    return type(t) == "string"
end

function isbool(t)
    return type(t) == "boolean"
end

function istable(t)
    return type(t) == "table"
end

function isthread(t)
    return type(t) == "function"
end

function istable(t)
    return type(t) == "thread"
end

function isuserdata(t)
    return type(t) == "userdata"
end

--[[
local t = nil
print(type(t), isnil(t))

local t = 1
print(type(t), isnumber(t))

local t = "dd"
print(type(t), isstring(t))

local t = true
print(type(t), isbool(t))

local t = {}
print(type(t), istable(t))

local t = function() end
print(type(t), isfunction(t))

--]]