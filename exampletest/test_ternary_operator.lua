print(1)
--print({1}[1])
--print({nil}[1])
a = 1
b = false
c = 2

print((a and {b} or {c})[1])

print(({false})[1])

print(true and 1)

print(false or false)

print(type({}))
print(type(nil))
print(type(false))