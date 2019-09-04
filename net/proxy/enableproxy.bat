@echo off  
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f  
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "135.88.88.88:8000" /f  
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "172.24.*;135.251.*;135.245.*;pcbsys.cn.alcatel-lucent.com;pcbdomain.cn.alcatel-lucent.com;*.nokia-sbell.*;*.nokia.*;vcenter65-0.pcb.com;localhost*;<local>" /f  
ipconfig /flushdns  
start "" "C:\Program Files\Internet Explorer\iexplore.exe"  
taskkill /f /im iexplore.exe  
