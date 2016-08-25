
-- 引入自定义函数
require("customlib/alt_type")
require("customlib/alt_class")
require("customlib/alt_dump")
require("customlib/alt_unionfunc")
require("customlib/alt_common")

-- 引入测试程序
require("alt_test")

local NBaseClass = class("NBaseClass")
print(NBaseClass._classname)

function NBaseClass:ctor()
    print("this is a base class")
end

function NBaseClass:init()
    print("this is init of base class")
end


--print(NBaseClass.ctor)

--local NObj = NBaseClass.new()

--print(NObj.ctor)

local subClass = class("subClass", NBaseClass)
print(subClass._classname)
function subClass:ctor()
    print("this is a sub class")
end

function subClass:init(x, y)
    print("this is init of sub class")
    self.x = x;
    self.y = y;
end

local subObj = subClass.new(2,3)

print(subObj.x)
print(subObj.y)

local subObj2 = subClass.new(999,"what")

print(subObj2.x)
print(subObj2.y)

function union_test()
    print("this is a primary union test")
end

local function sec_func()
    print("this is second function")
end

unionfunc("union_test", sec_func)

-- run to test
union_test()

show_mem_utilization()

print(altfunc.dumptree(subObj2, 2)) 