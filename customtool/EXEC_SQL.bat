@echo off
set UserName=%1%
set PassWord=%2%
set DBName=%3%
set SqlCommand=%4%
set SubSql=%SqlCommand:~1,-1%

set SqlHead="use %3%;
set SqlTail= into outfile 'f:\SqlRet.log';"
set SqlCmd=%SqlHead%%SubSql%%SqlTail%

del f:\SqlRet.log

::echo A=%UserName%
::echo B=%PassWord%
::echo C=%DBName%
::echo D=%SqlCommand%
::echo E=%SqlCmd%
::echo F=%SqlHead%
::echo G=%SqlTail%

echo DBName=%DBName%
echo SQL=%SqlCommand%
echo SqlCmd=%SqlCmd%

mysql -u%UserName% -p%PassWord% -e%SqlCmd%
pause



