
--[[
@action : show the memory utilization of lua
@params : none
@return : none
]]
function show_mem_utilization()
    local use_memory = collectgarbage("count")
    --local threshold = gcinfo();
    --local show_info = string.format("memory utilization (used KB//threshold KB) : %8d", threshold)
    local show_info = string.format("[Lua]>>>>>>>>memory utilization (used KB) : %5d KB", use_memory)
    print(show_info)
end
