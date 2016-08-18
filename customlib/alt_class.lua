




function class(classname, super)
    local class_type={};

    function class_type:new(...) 
        setmetatable(class_type, {__index = super})
    end
    
end


local tab = {}
function tab.haha(param)
    print(param)
end

print(tab)
print(tab:haha("hehe"))


function f_rev( ... )
    for k,v in ipairs(arg) do
        print(k,v)
    end
end

function f_rec( ... )
    f_rev(unpack(arg))
    print("\n", unpack(arg))
    print(arg.n)
     print(arg)
end

f_rec(2)

local num = nil + 1
print(num)

