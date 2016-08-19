-- 为了避免复杂的结构，这里只实现单一继承
function class(classname, super)

    -- 子类继承
    local function inherit_calss(sub, super)
        
        if (sub._is_class) or     -- 当前已经是一个类
            (sub == super) or     -- 不能指定自己为父类
            (super and not super._is_class) then    -- 指定的父类不是类
            return false
        end

        -- 父子类关系赋值
        sub._super = super;
        sub._is_class = true;

        -- 设置元表来表现继承关系
        setmetatable(sub, {__index = super})

        return true
    end

    local function recursive_exec(sub, obj, funcname, ...)
        if sub._super then
            recursive_exec(sub._super, obj, funcname, unpack(arg));
        end

        local func = rawget(sub, funcname);
        if func then
            func(obj, unpack(arg));
        end

    end

    local class_type={};
    function class_type.new(...)    -- 此处声明成class_type.new指的斟酌一下，class_type:new也可以，需要考虑调用方便
        local obj = {}
        setmetatable(obj, {__index = class_type})
        -- 执行递归函数
        do
            recursive_exec(class_type, obj, "ctor", unpack(arg));     --构造函数
            recursive_exec(class_type, obj, "init", unpack(arg));     --初始化函数
        end
        return obj
    end

    class_type._classname = classname;
    -- 生成子类
    inherit_calss(class_type, super);
    -- 返回子类类型
    return class_type
end

-- 测试class
--[[
local baseclass = class("base_c")
print(baseclass._classname)
]]