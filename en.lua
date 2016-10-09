


function function_to(str, n)
    local num = string.byte(str, n);
    if num >= 65 then
       return num - 65 + 10;
    elseif num >= 48 then
        return num - 48;
    end
end

function function_xor(num1, num2)
    local ret = 0
    for i=1,8 do
        local n1 = num1 % 2
        local n2 = num2 % 2

        local mid = 1
        --print(n1)
        --print(n2)

        if n1 == n2 then
            mid = 0;
        end

        num1 = math.floor(num1 / 2);
        num2 = math.floor(num2 / 2);

        ret = ret + mid * 2 ^ (i - 1)

    end

    return ret;
end

local t = {}

local sourcestr = "2E-16-1E-1C-03-14-03-00-17-4B-58-54"
print("\noutput capture using loop:") 

local strret = ""
for word in string.gmatch(sourcestr, "%w+") do
    --print(word)
    --print(string.format("%d",word))
    local num = function_to(word, 1) * 16 + function_to(word, 2)
    --print(num)

    table.insert(t, num)
    --strret = strret..string.format("%c", num)
end

--print(strret)

local xxx =""
local ss ="SSSSSSSSSSSSSSSSSSS"
for i=1,17 do
    ---local cc = function_to(ss, i) ^ function_to(strret, i)
   -- xxx = xxx..string.format("%c", cc)
   --print(string.byte(ss, i))
   --print(function_to(strret, i))
   --local cc = string.byte(ss, i) ^ t[i]
   --print(cc)
   --print (string.format("%d, %d",string.byte(ss, i), t[i] ))
   --xxx = xxx..string.format("%c", cc)
   --print((tonumber(string.byte(ss, i) ^ tonumber(t[i])) ))

   local n1 = tonumber(string.byte(ss, i));
   local n2 = tonumber(t[i]);

   print(function_xor(n1, n2))
   xxx = xxx..string.format("%c", function_xor(n1, n2));
end

print("\n", 99 ^ 4)
print(xxx)

print("danteng", function_xor(99, 4))



