-- 生成消息分发类定义
ClassMessageDispatchMgr=class("ClassMessageDispatchMgr");

-- 构造函数
function ClassMessageDispatchMgr:ctor(object_name)
    self.objectname = object_name;
    self.observerlist = {};

    --[[
        observerlist data organization structure
        observerlist = 
        {
            [message_type_1] = 
            {
                [obj_1] = true  -- 用来表明当前已经注册过
                [obj_2] = true
                [obj_3] = true
                ...
                [obj_n] = true

                observers = 
                {
                    -- weight表示权重，权重越高排序越靠前
                    [1] = {observer = obj_1, weight = 99}
                    [2] = {observer = obj_3, weight = 99}
                    [3] = {observer = obj_2, weight = 50}
                    ...
                    [n] = {observer = obj_n, weight = 10}
                }
            };
            ...
            ...
            [message_type_n] = 
            {
                ...
            };
        }
    --]]
end

-- 初始化函数
function ClassMessageDispatchMgr:init()
    -- virtual_XXX  要求子类实现的函数
    -- public_XXX   可以公共调用的函数
    -- private_XXX  要能自己调用的函数
end

-- 获取观察者列表
function ClassMessageDispatchMgr:virtual_get_observerlist(classname)
    return self.observerlist;
end

-- 根据权重添加观察者
function ClassMessageDispatchMgr:private_add_observer_by_weight(observers, new_observer)

    local insert_middle = false;
    for key, observer in ipairs(observers) do
        if observer.weight < new_observer.weight then
            insert_middle = true;
            break;
        end
    end

    if insert_middle == false then
        table.insert(observers, new_observer);
    end
end

-- 查看已经注册过的消息
function ClassMessageDispatchMgr:public_lookover(classname)
    print("observerlist by classname begin :", classname)
    local observerlist = self:virtual_get_observerlist(classname);

    for message_type,value in pairs(observerlist) do
        if value then
            for k,observer_unit in pairs(value.observers) do
                if observer_unit.observer and observer_unit.observer.__classname  and 
                    (classname == nil or observer_unit.observer.__classname == classname) then
                    -- 打印对象的类名，消息类型，权重
                    print(observer_1.observer.__classname, message_type, observer_unit.weight);
                end
            end
        end
    end
    print("observerlist by classname end");
end

-- 按消息类型添加观察者
function ClassMessageDispatchMgr:public_add_observer_by_message_type(obj, message_type, classname)
    local observerlist = self:virtual_get_observerlist(classname);
    if obj then
        observerlist[message_type] = observerlist[message_type] or {};
        -- 已经注册过就不再注册
        if observerlist[message_type][obj] == nil then
            local newweight = obj.message_weight_list and obj.message_weight_list[message_type] or 0;
            observerlist[message_type][obj] = true;
            observerlist[message_type].observers = observerlist[message_type].observers or {};
            self:private_add_observer_by_weight(observerlist[message_type].observers, {observer = obj, weight = newweight});
        end
    end
end

-- 根据事件广播消息
function ClassMessageDispatchMgr:public_broadcast_message(message_type, broadcast_param, classname)

    local observerlist = self:virtual_get_observerlist(classname);
    if observerlist[message_type] then
        for key, observer_unit in ipairs(observerlist[message_type].observers) do
            local observer = observer_unit.observer;
            if observer[message_type] then
               observer[message_type](observer, broadcast_param);
            end
        end
    end
end

MessageDispatchObject = ClassMessageDispatchMgr.new();

