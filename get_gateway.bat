@echo off
echo off

set adapter="%1"

if "%adapter%"=="""" set adapter="Wireless LAN adapter 无线网络连接"
rem echo %adapter%
set adapter=%adapter:~1,-1%

setlocal enabledelayedexpansion
set find=0
set ip=""
set gw=""
for /f "delims=" %%i in ('ipconfig') do ( 
    set var=%%i

    if !find!==0 (
        if "%%i"=="%adapter%:" (set find=1)
    )else (
        rem echo "!var:~0,5!"
        if not "!var:~0,3!"=="   " (
            set find=0
            rem echo "set 0"
        )else (
            rem echo %%i
            if "!var:~0,18!"=="   Default Gateway" set gw="!var:~39!"
            if "!var:~0,14!"=="   Subnet Mask" set ip="!var:~39!"
            if "!var:~0,15!"=="   IPv4 Address" set mask="!var:~39!"
            rem echo !gw!
            rem echo !ip!
            rem echo !mask!
        )
    )
    rem echo !find!
    rem if !find!==1 echo %%i else (echo "no")

)

rem set gw="" rem This is for Debug test

if %gw%=="" (
    set ips[0]=0
    set ips[1]=0
    set ips[2]=0
    set ips[3]=0
    
    set masks[0]=0
    set masks[1]=0
    set masks[2]=0
    set masks[3]=0
    
    set gws[0]=0
    set gws[1]=0
    set gws[2]=0
    set gws[3]=0
    
    for /f "delims=.:; tokens=1,2,3,4" %%i in (%ip%) do (
        set ips[0]=%%i
        set ips[1]=%%j
        set ips[2]=%%k
        set ips[3]=%%l
    )
    for /f "delims=.:; tokens=1,2,3,4" %%i in (%mask%) do (
        set masks[0]=%%i
        set masks[1]=%%j
        set masks[2]=%%k
        set masks[3]=%%l
    )
    
    
    set /A gws[0]="(!ips[0]! & !masks[0]!)"
    set /A gws[1]="(!ips[1]! & !masks[1]!)"
    set /A gws[2]="(!ips[2]! & !masks[2]!)"
    set /A gws[3]="(!ips[3]! & !masks[3]!)"
    set /A gws[3]="(!gws[3]!+1)"
    
    rem echo !gws[0]! !gws[1]! !gws[2]! !gws[3]!
    set gw="!gws[0]!.!gws[1]!.!gws[2]!.!gws[3]!"
)
set gw=%gw:~1,-1%
echo gateway:%gw%

rem set %1=%gw%
pause
