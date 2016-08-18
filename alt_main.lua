
-- 引入自定义函数
require("customlib/alt_class")
require("customlib/alt_dump")

-- 引入测试程序
require("alt_test")

local NBaseClass = class("NBaseClass")
print(NBaseClass._classname)