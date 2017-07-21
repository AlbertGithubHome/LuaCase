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
