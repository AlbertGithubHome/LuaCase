package.path = package.path ..';..\\?.lua';
require("customlib/alt_dump2fileorconsole")

-- example test 1
local t = {
    a = 1, 
    b = 2
}

function t.test()
    print("test subfunction test!")
end

print(t.test)
print(t.test())
print(dumptree2file(t))

-- function t.test() <==> t.test = function () 

