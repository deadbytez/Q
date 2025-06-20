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
netsh advfirewall firewall add rule name="Adobe Photoshop 2025 (Inbound)" dir=in action=block program="%ProgramFiles%\Adobe\Adobe Photoshop 2025\Photoshop.exe" enable=yes
netsh advfirewall firewall add rule name="Adobe Photoshop 2025 (Outbound)" dir=out action=block program="%ProgramFiles%\Adobe\Adobe Photoshop 2025\Photoshop.exe" enable=yes

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
netsh advfirewall firewall add rule name="AdobeNode (Inbound)" dir=in action=block program="%ProgramFiles%\Adobe\Adobe Photoshop 2025\node.exe" enable=yes
netsh advfirewall firewall add rule name="AdobeNode (Outbound)" dir=out action=block program="%ProgramFiles%\Adobe\Adobe Photoshop 2025\node.exe" enable=yes

REM 7. AdobeCCXProcess
netsh advfirewall firewall add rule name="AdobeCCXProcess (Inbound)" dir=in action=block program="%ProgramFiles%\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" enable=yes
netsh advfirewall firewall add rule name="AdobeCCXProcess (Outbound)" dir=out action=block program="%ProgramFiles%\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" enable=yes

REM 8. AdobeCCXProcess (x86)
netsh advfirewall firewall add rule name="AdobeCCXProcess (Inbound)" dir=in action=block program="%ProgramFiles(x86)%\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" enable=yes
netsh advfirewall firewall add rule name="AdobeCCXProcess (Outbound)" dir=out action=block program="%ProgramFiles(x86)%\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" enable=yes

REM --- filmora ---
set "filmora_path=%USERPROFILE%\AppData\Local\Wondershare\Wondershare Filmora\14.3.2.11147"
powershell -Command "Add-MpPreference -ExclusionPath '%filmora_path%\FCore.dll'"
powershell -Command "Add-MpPreference -ExclusionPath '%filmora_path%\FExportView.dll'"
powershell -Command "Add-MpPreference -ExclusionPath '%filmora_path%\FFWsRegister.dll'"
powershell -Command "Add-MpPreference -ExclusionPath '%filmora_path%\FMediaLibraryView.dll'"
powershell -Command "Add-MpPreference -ExclusionPath '%filmora_path%\wsUpgrade.dll'"

REM --- winget ---
REM winget pin add --id=Discord.Discord --blocking && winget pin add --id=OpenWhisperSystems.Signal --blocking && winget pin add --id=Spotify.Spotify --blocking && winget pin add--id=Wondershare.Filmora --blocking
REM  "telemetry": {
REM      "disable": true
REM }
echo skonfiguruj winget
pause
winget install 7zip.7zip ShareX.ShareX Audacity.Audacity CrystalDewWorld.CrystalDiskInfo CrystalDewWorld.CrystalDiskMark Git.Git IrfanSkiljan.IrfanView Notepad++.Notepad++ VideoLAN.VLC RARLab.WinRAR AntibodySoftware.WizTree EclipseAdoptium.Temurin.17.JRE WireGuard.WireGuard EclipseAdoptium.Temurin.21.JRE Microsoft.VCRedist.2008.x64 Microsoft.VCRedist.2010.x64 voidtools.Everything Microsoft.VCRedist.2005.x64 Brave.Brave Orwell.Dev-C++ Valve.Steam RamenSoftware.Windhawk Microsoft.VCRedist.2013.x64 Microsoft.VCRedist.2015+.x86 Microsoft.VCRedist.2012.x86 Microsoft.VCRedist.2005.x86 Microsoft.VCRedist.2008.x86 Microsoft.VCRedist.2013.x86 Microsoft.XNARedist Microsoft.VCRedist.2010.x86 Microsoft.VCRedist.2012.x64 Microsoft.VCRedist.2015+.x64 Bitwarden.Bitwarden HeroicGamesLauncher.HeroicGamesLauncher OpenWhisperSystems.Signal Discord.Discord PrismLauncher.PrismLauncher LocalSend.LocalSend VSCodium.VSCodium MartiCliment.UniGetUI

echo.
echo готово
timeout 3
