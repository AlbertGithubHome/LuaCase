--[[
@action : union functions
@param1 : the final name of function
@param2 : the new function
@param3 : true-> run new function after old function, false-> run old function after new function
@return : none
]]

function unionfunc(func_name, new_func, new_after_old)
    -- 先取得原有函数
    local old_func = _G[func_name] or function() end;

    -- 然后根据传入顺序组合新老函数
    if old_after_new then
        _G[func_name] = function(...)
            old_func(unpack(arg));
            new_func(unpack(arg));
        end
    else
        _G[func_name] = function(...)
            new_func(unpack(arg));
            old_func(unpack(arg));
        end
    end 
end