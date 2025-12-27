@echo off
REM --- odpal jako admin ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%~dpnx0' -ArgumentList '%*'"
    exit /b
)

REM --- blokowanie adobe w zaporze ---

REM 1. Adobe Crash Processor
netsh advfirewall firewall add rule name="Adobe Crash Processor (Inbound)" dir=in action=block program="%ProgramFiles%\Adobe\Adobe Creative Cloud Experience\js\node_modules\adobe-cr\build\Release\Adobe Crash Processor.exe" enable=yes
netsh advfirewall firewall add rule name="Adobe Crash Processor (Outbound)" dir=out action=block program="%ProgramFiles%\Adobe\Adobe Creative Cloud Experience\js\node_modules\adobe-cr\build\Release\Adobe Crash Processor.exe" enable=yes

REM 2. Adobe Photoshop 2025
netsh advfirewall firewall add rule name="Adobe Photoshop 2025 (Inbound)" dir=in action=block program="%ProgramFiles%\Adobe\Adobe Photoshop 2026\Photoshop.exe" enable=yes
netsh advfirewall firewall add rule name="Adobe Photoshop 2025 (Outbound)" dir=out action=block program="%ProgramFiles%\Adobe\Adobe Photoshop 2026\Photoshop.exe" enable=yes

REM 3. AdobeIPCBroker (OOBE)
netsh advfirewall firewall add rule name="AdobeIPCBroker (Inbound)" dir=in action=block program="%ProgramFiles(x86)%\Common Files\Adobe\OOBE\PDApp\IPC\AdobeIPCBroker.exe" enable=yes
netsh advfirewall firewall add rule name="AdobeIPCBroker (Outbound)" dir=out action=block program="%ProgramFiles(x86)%\Common Files\Adobe\OOBE\PDApp\IPC\AdobeIPCBroker.exe" enable=yes

REM 4. AdobeIPCBroker (Desktop Common)
netsh advfirewall firewall add rule name="AdobeIPCBroker (Inbound)" dir=in action=block program="%ProgramFiles(x86)%\Common Files\Adobe\Adobe Desktop Common\IPCBox\AdobeIPCBroker.exe" enable=yes
netsh advfirewall firewall add rule name="AdobeIPCBroker (Outbound)" dir=out action=block program="%ProgramFiles(x86)%\Common Files\Adobe\Adobe Desktop Common\IPCBox\AdobeIPCBroker.exe" enable=yes

REM 5. AdobeNode (Creative Cloud Experience)
netsh advfirewall firewall add rule name="AdobeNode (Inbound)" dir=in action=block program="%ProgramFiles%\Adobe\Adobe Creative Cloud Experience\libs\node.exe" enable=yes
netsh advfirewall firewall add rule name="AdobeNode (Outbound)" dir=out action=block program="%ProgramFiles%\Adobe\Adobe Creative Cloud Experience\libs\node.exe" enable=yes

REM 6. AdobeNode (Photoshop)
netsh advfirewall firewall add rule name="AdobeNode (Inbound)" dir=in action=block program="%ProgramFiles%\Adobe\Adobe Photoshop 2026\node.exe" enable=yes
netsh advfirewall firewall add rule name="AdobeNode (Outbound)" dir=out action=block program="%ProgramFiles%\Adobe\Adobe Photoshop 2026\node.exe" enable=yes

REM 7. AdobeCCXProcess
netsh advfirewall firewall add rule name="AdobeCCXProcess (Inbound)" dir=in action=block program="%ProgramFiles%\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" enable=yes
netsh advfirewall firewall add rule name="AdobeCCXProcess (Outbound)" dir=out action=block program="%ProgramFiles%\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" enable=yes

REM 8. AdobeCCXProcess (x86)
netsh advfirewall firewall add rule name="AdobeCCXProcess (Inbound)" dir=in action=block program="%ProgramFiles(x86)%\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" enable=yes
netsh advfirewall firewall add rule name="AdobeCCXProcess (Outbound)" dir=out action=block program="%ProgramFiles(x86)%\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" enable=yes

REM --- filmora ---
set "filmora_path=%USERPROFILE%\AppData\Local\Wondershare\Wondershare Filmora\15.0.11.16306"
powershell -Command "Add-MpPreference -ExclusionPath '%filmora_path%\FCore.dll'"
powershell -Command "Add-MpPreference -ExclusionPath '%filmora_path%\FExportView.dll'"
powershell -Command "Add-MpPreference -ExclusionPath '%filmora_path%\FFWsRegister.dll'"
powershell -Command "Add-MpPreference -ExclusionPath '%filmora_path%\FMediaLibraryView.dll'"
powershell -Command "Add-MpPreference -ExclusionPath '%filmora_path%\wsUpgrade.dll'"
