print()
-- 首先查询一下初始的区域设置
print(os.setlocale(nil)) 

-- 设置成中文简体区域
print(os.setlocale("chs")) 

-- 其实这两个是无效的，就看看返回值
print(os.setlocale("En-Us")) 
print(os.setlocale("zh_CN")) 

-- 设置成英文区域
print(os.setlocale("eng")) 

-- 设置成中文繁体区域
print(os.setlocale("cht")) 
print()

-- 现在只将数字部分设置成中文简体区域
print(os.setlocale("chs","numeric")) 

-- 打印一下时间
-- 实际上现在的时间部分还是中文繁体区域
print(os.setlocale(nil,"time").."'s time format as follow:")
print(os.date("%c").."\n")

-- 现在将时间部分设置成英文区域
print(os.setlocale("eng","time")) 

-- 再打印时间对比一下
print(os.setlocale(nil,"time").."'s time format as follow:")
print(os.date("%c").."\n")


-- 最后看一下当前的区域设置
print(os.setlocale(nil)) 


print(os.setlocale("")) 
print(os.setlocale(nil)) 

--[[
|语言缩写 |   语言种类     |    语言代码 |
|:-------:|:--------------:|:-----------:|
|chs      |   简体中文     |     0804    |
|cht      |   繁体中文     |     0404    |
|jpn      |   日文         |     0011    |
|kor      |   韩文         |     0012    |
|dan      |   丹麦文       |     0006    |
|deu      |   德文         |     0007    |
|eng      |   国际英文     |     0809    |
|enu      |   英文         |     0409    |
|esp      |   西班牙文     |     000A    |
|fin      |   芬兰文       |     000B    |
|fra      |   法文（标准） |     040C    |
|frc      |   加拿大法文   |     0C0C    |
|ita      |   意大利文     |     0010    |
|nld      |   荷兰文       |     0013    |
|nor      |   挪威文       |     0014    |
|plk      |   波兰文       |     0015    |
|ptb      |   巴西葡萄牙文 |     0416    |
|ptg      |   葡萄牙文     |     0816    |
|rus      |   俄文         |     0019    |
|sve      |   瑞典文       |     001D    |
|tha      |   泰文         |     001E    |
--]]