-- alt_dump.lua 


-- 全局函数表
altfunc = altfunc or {}

--[[
@action : dump对象
@params : the obj need to print
@return : return a ret of string
]]

function altfunc.dump(obj)

    -- 递归打印函数
    local dump_obj;

    local function make_indent(layer)
        return string.rep("\t", layer)
    end

    local function make_quote(str)
        str = string.gsub(str, "\\","\\\\")
        return string.format("%q", str)
    end

    local function dump_key(key)
        if type(key) == "number" then
            return "[" .. key .. "]"
        elseif type(key) == "string" then
            return "[" .. make_quote(key) .. "]"
        else
            return "[" .. tostring(key) .. "]"
        end
    end

    local function dump_val(val, layer)
        if type(val) == "table" then
            return dump_obj(val, layer)
        elseif type(val) == "string" then
            return make_quote(val)
        else
            return tostring(val)
        end
    end

    local function is_array(obj)
        local count = 0
        for k, v in pairs(obj) do
            count = count + 1
        end
        for i = 1, count do
            if obj[i] == nil then
                return false
            end
        end
        return true, count
    end

    dump_obj = function(obj, layer)
        if type(obj) ~= "table" then
            return dump_val(obj)
        end

        layer = layer + 1
        local tokens = {}
        tokens[#tokens + 1] = "{"
        local ret, count = is_array(obj)
        if ret then
            for i = 1, count do
                tokens[#tokens + 1] = make_indent(layer) .. dump_val(obj[i], layer) .. ","
            end  
        else
            for k, v in pairs(obj) do
                tokens[#tokens + 1] = make_indent(layer) .. dump_key(k) .. " = " .. dump_val(v, layer) .. ","
            end
        end
        tokens[#tokens + 1] = make_indent(layer - 1) .. "}"  
        return table.concat(tokens, "\n")
    end

    return dump_obj(obj, 0)
end

-- 测试
--[[
local obj = {
    string1 = "Hi! My name is LiXianlin",
    string2 = "2016/8/18 15:50",
    int = 0818,
    float = 3.1415,
    bool = true,
    array = {
        1, 2,
        {  
            a = 21,
            b = 22,
            c = {true, false}
        },  
    },  
    table = {
        x = 100,
        y = 200,
        z = 400,
    },  
    [88] = 88888,
    [9.7] = 22222,
    func = function()
        print("this is a function")
    end,
    ["key"] = "value",

}  
print(altfunc.dump(obj)) 

--]]

local t = {
    a = 1,
    b = 2,
    [1] = 1,
    ["1"] =2,
    pos = {
        x = 100,
        y = 200,
        z = 400,
        target = {
            x = 666,
            y = 777,
            src = "name"
        }
    },  
    [88] = 88888,
    [9.7] = 22222,
    func = function()
        print("this is a function")
    end,
    ["key"] = "value",
}


--[[

┌─┬─┐
├─┼─┤
└─┴─┘

]]

function altfunc.dumptree(obj, width)

    -- 递归打印函数
    local dump_obj;
    local end_flag = {};

    local function make_indent(layer, is_end)
        --local subIndent = string.rep("  ", width)
        --local indent = string.rep("│"..subIndent, layer - 1)

        local subIndent = string.rep("  ", width)
        local indent = "";
        end_flag[layer] = is_end;
        local subIndent = string.rep("  ", width)
        for index = 1, layer - 1 do
            if end_flag[index] then
                indent = indent.." "..subIndent
            else
                indent = indent.."|"..subIndent
            end
        end
        
        if is_end then
            return indent.."└"..string.rep("─", width).." "
        else
            return indent.."├"..string.rep("─", width).." "
        end
    end

    local function make_quote(str)
        str = string.gsub(str, "\\","\\\\")
        return string.format("%q", str)
    end

    local function dump_key(key)
        if type(key) == "number" then
            return key .. ") "
        elseif type(key) == "string" then
            return tostring(key).. ": "
        end
    end

    local function dump_val(val, layer)
        if type(val) == "table" then
            return dump_obj(val, layer)
        elseif type(val) == "string" then
            return make_quote(val)
        else
            return tostring(val)
        end
    end

    local function count_elements(obj)
        local count = 0
        for k, v in pairs(obj) do
            count = count + 1
        end
        return count
    end

    dump_obj = function(obj, layer)
        if type(obj) ~= "table" then
            return count_elements(obj)
        end

        layer = layer + 1
        local tokens = {}
        local max_count = count_elements(obj)
        local cur_count = 1
        for k, v in pairs(obj) do
            local key_name = dump_key(k)
            if type(v) == "table" then
                key_name = string.sub(key_name, 1, -3);
                key_name = key_name.."\n"
            end
            tokens[#tokens + 1] = make_indent(layer, cur_count == max_count) .. key_name .. dump_val(v, layer)
            cur_count = cur_count + 1
        end

        return table.concat(tokens, "\n")
    end

    if type(obj) ~= "table" then
        return "the params you input is "..type(obj)..", not a table, the value is --> "..tostring(obj)
    end
    print("root-->"..tostring(obj))
	print("│")
    width = width or 2

    return dump_obj(obj, 0)
end

print(altfunc.dumptree(t, 2)) 
--print(altfunc.dumptree(obj, 2)) 
--print(altfunc.dump(t)) 

--print(altfunc.dumptree(t)) 

