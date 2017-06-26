-- dump table content to file
function dumptree2file(obj, file_name, depth, width)

    -- 递归打印函数
    local dump_obj;
    local end_flag = {};
    local table_flag = {};

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
            return indent.."+"..string.rep("-", width).." "
        else
            return indent.."+"..string.rep("-", width).." "
        end
        --[[
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
        ]]
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

        if type(value) == "table" and table_flag[value] == true then
            return {duplicated_flag_break_loop = tostring(value)}
        else
            --table_flag[value] = true
        end

        return value
    end

    dump_obj = function(obj, layer)
        if type(obj) ~= "table" then
            return count_elements(obj)
        end

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

        return table.concat(tokens, "\n")
    end

    if type(obj) ~= "table" then
        return "the params you input is "..type(obj)..
        ", not a table, the value is --> "..tostring(obj)
    end

    width = width or 2
    depth = depth or 11

    if file_name == nil then
        return "root-->"..tostring(obj).."\n"..dump_obj(obj, 0)
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

--print(dumptree2file(t, "test.data"))

function GLuaDumpTree(obj, file_name, depth, width)
    print(dumptree2file(obj, file_name, depth, width))
end