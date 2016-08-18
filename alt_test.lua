--[[
local tab = { n = 999}
function tab:haha(param)
    --print(param)
    print(self.n)
end

print(tab)
print(tab.haha("hehe"))

print(tab.n)
]]

--[[
function f_rev( ... )
    for k,v in ipairs(arg) do
        print(k,v)
    end
end

function f_rec( ... )
    f_rev(unpack(arg))
    print("\n", unpack(arg))
    print(arg.n)
     print(arg)
end

f_rec(2)

--local num = nil + 1
print(num)

--]]


-- 四层嵌套
--[[

local a1 = {x = 1}
setmetatable(a1, {__index = {}})

local a2 = {y = 2}
setmetatable(a2, {__index = a1})

local a3 = {z = 3}
setmetatable(a3, {__index = a2})

local a4 = {w = 4}
setmetatable(a4, {__index = a3})

a1.x= 888

print(a4.x)
print(a4.y)
print(a4.z)
print(a4.w)
--]]

--[[

function v1()
    local tab = {}

    function tab:v2()
        print(tab.x)
    end

    return tab
end

local t = v1()
t.x=1
t.v2()

--]]

--[[
local tab = {x = 11}

function tab:v3(param)
    print(self)

    if (self == tab) then
        print("==")
    end
end

tab:v3()
--]]