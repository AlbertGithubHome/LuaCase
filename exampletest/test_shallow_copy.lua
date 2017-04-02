-- example test 1
local t = {
    a = 1, 
    b = 2
}

print(t)

local t2 = t

t.a =100
print(t)
print(t2)
print(t2.a)

t.c = 100

-- example test 2
function print_val(myt)
    myt.a = 1
    t.d = 100
end

function start()
    local mytable = {}
    print_val(mytable)
    print(mytable.a)
end

start()