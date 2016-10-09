-- [init segment]
local username='root'

local password='admin'

local dbname='test'
-- [init segment end]


--[modify sql]
sqlcommand= "select * from ct limit 10,100"


sqlcommand=string.format("%q", sqlcommand)
os.execute("EXEC_SQL.bat "..username.." "..password.." "..dbname.." "..sqlcommand);