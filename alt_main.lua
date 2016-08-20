
-- 引入自定义函数
require("customlib/alt_type")
require("customlib/alt_class")
require("customlib/alt_dump")

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

function subClass:init()
    print("this is init of sub class")
end

local subObj = subClass.new()