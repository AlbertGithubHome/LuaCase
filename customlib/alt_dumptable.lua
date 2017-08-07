--[[
@action : dump table content to file
@params : obj       => table变量
@params : file_name => 导出的文件名（导出的路径在项目的根目录）
@params : depth     => table的深度（可以不填，默认为11）
@params : width     => 控制显示宽度（可以不填，默认为2）
@return : the description of executing result 
@usage  : dumptable(_G, 'GLuaJgMir.data')
]]
function dumptable(obj, file_name, depth, width)

    -- 递归打印函数
    local dump_obj;
    local end_flag = {};
    local table_flag = {};
    local dps_table = {};   -- 深度优先搜索的标记

    local function make_indent(layer, is_end)
        local subIndent = string.rep("  ", width)
        local indent = "";
        end_flag[layer] = is_end;
        local subIndent = string.rep("  ", width)
        for index = 1, layer - 1 do
            if end_flag[index] then
                indent = indent.." "..subIndent
            else
                indent = indent.."l"..subIndent
            end
        end
        
        if is_end then
            return indent.."^"..string.rep("-", width).." "
        else
            return indent.."+"..string.rep("-", width).." "
        end
    end

    local function make_quote(str)
        -- 特殊字符串
        return string.format("%q", str)
    end

    local function dump_key(key)
        if type(key) == "number" then
            return key .. "] "
        elseif type(key) == "string" then
            return tostring(key).. ": "
        else
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

    local function break_deathloop(key, value)
        -- break death loop for _G
        if tostring(key) == "_G" or 
            tostring(key) == "loaded" or
            tostring(key) == "heart-broken" then
            return {}
        end

        if type(value) == "table" and dps_table[value] == true then
            return {duplicated_flag_break_loop = tostring(value)}
        elseif type(value) == "table" and table_flag[value] then
            return {duplicated_flag_break_loop = "<"..table_flag[value]..","..tostring(value)..">"}
        else
            --table_flag[value] = tostring(key)
        end

        return value
    end

    dump_obj = function(obj, layer)
        if type(obj) ~= "table" then
            return count_elements(obj)
        end

        dps_table[obj] = true;
        layer = layer + 1
        local tokens = {}
        if layer >= depth then -- 避免太深引起死循环
            table.insert(tokens, make_indent(layer, true) .. "{ }")
        else
            local max_count = count_elements(obj)
            local cur_count = 1
            for k, v in pairs(obj) do
                local key_name = dump_key(k)
                if type(v) == "table" then
                    key_name = key_name.."\n"
                    v = break_deathloop(k, v)
                end

                table.insert(tokens, make_indent(layer, cur_count == max_count) 
                    .. key_name .. dump_val(v, layer))
                cur_count = cur_count + 1
            end

            -- 处理空table
            if max_count == 0 then
                table.insert(tokens, make_indent(layer, true) .. "{ }")
            end
        end

        dps_table[obj] = nil;
        return table.concat(tokens, "\n")
    end

    if type(obj) ~= "table" then
        return "the params you input is "..type(obj)..
        ", not a table, the value is --> "..tostring(obj)
    end

    width = width or 2
    depth = depth or 11

    if file_name == nil then
        print("root-->"..tostring(obj).."\n"..dump_obj(obj, 0))
    else
            -- 定义输出文件
        local file, error_msg = io.open(file_name,'w')
        if file == nil then
            print(error_msg)
            return error_msg
        end
        file:write("root-->"..tostring(obj).."\n"..dump_obj(obj, 0))
        file:close()
    end

    return "dump tree to file ok!"
end

--[[
@action : set value for variable(isFormatPrint)
@params : formatPrint   => 字符串类型，表示是否格式化输出
@return : none
]]
function setformat(formatPrint)
    if formatPrint == "true" then
        isFormatPrint = true;
    else
        isFormatPrint = false;
    end
end

--[[
@action : output debugging information
@params : argTable      => 参数表
@params : outputLevel   => 输出等级
@return : none
]]
function formatprint(argTable, outputLevel)

    -- 没有启用格式输出直接返回
    if not isFormatPrint or type(argTable) ~= "table" then return end

    local funcInfo = debug.getinfo(2);
    local shortSrc = "source: ..."..string.sub (funcInfo.source, -32);
    local currLine = tostring(funcInfo.currentline);
    local funcName = "funcname: "..(funcInfo.name or "c_function");
    local outputSt = "formatprint:"

    for k,v in pairs(argTable) do
        outputSt = outputSt..tostring(v).." ";
    end

    print(outputSt.."\t\t\t["..shortSrc.."(line:"..currLine..")\t"..funcName.."]");
end
