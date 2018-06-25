New-Item -Path $env:UserProfile\AppData\Local\ChocoCache -ItemType directory -force
Disable-UAC

#--- Initial Windows Config ---
Update-ExecutionPolicy Unrestricted
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowFullPathInTitleBar -DisableOpenFileExplorerToQuickAccess

Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

#--- Windows features ---
cinst -y Containers -source windowsFeatures
cinst -y Microsoft-Hyper-V-All -source windowsFeatures
cinst -y Microsoft-Windows-Subsystem-Linux -source windowsfeatures
cinst -y IIS-WebServerRole -source windowsfeatures
cinst -y IIS-HttpCompressionDynamic -source windowsfeatures
cinst -y IIS-ManagementScriptingTools -source windowsfeatures
cinst -y IIS-WindowsAuthentication -source windowsfeatures

#--- .NET ---
cinst PowerShell -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst dotnet4.5 -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst dotnet4.6.2 -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst dotnet4.7 -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst netfx-4.7.1-devpack -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"

cinst dotnetcore-sdk -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst dotnetcore -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst dotnetcore-windowshosting -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst dotnetcore-runtime.install --version 1.0.10 -my --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst dotnetcore-runtime.install --version 1.1.7 -my --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst dotnetcore-runtime.install --version 2.0.7 -my --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst dotnetcore-runtime.install --version 2.1.0 -my --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"

#--- Applications ---
cinst googlechrome -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst javaruntime -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst notepadplusplus.install -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst notepad3.install -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"

#--- Visual Studio ---
cinst visualstudio2015enterprise -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"

cinst visualstudio2017enterprise -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst visualstudio2017-workload-manageddesktop -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst visualstudio2017-workload-netcoretools -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst visualstudio2017-workload-netweb -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst visualstudio2017-workload-node -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"

#--- Other dev ---
cinst git -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst resharper-ultimate-all -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst sql-server-management-studio -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst poshgit -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst sourcetree -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst linqpad -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst github -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst docker-for-windows -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst docker-kitematic -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst redis-desktop-manager -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst rdcman -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst ProcExp -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst cloudberryexplorer.s3 -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst postman -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst sysinternals -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst python -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst awstools.powershell -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"
cinst pip -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"

#--- Visual Studio Code ---
cinst visualstudiocode -y --cacheInstaller "%UserProfile%\AppData\Local\ChocoCache"

code --install-extension ms-vscode.csharp
code --install-extension ms-vscode.powershell
code --install-extension formulahendry.auto--cacheInstallerlose-tag
code --install-extension jchannon.csharpextensions
code --install-extension cake-build.cake-vscode
code --install-extension maptz.camelcasenavigation
code --install-extension PeterJausovec.vscode-docker
code --install-extension eamodio.gitlens

#--- Ubuntu ---
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile ~/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Ubuntu.appx

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -AcceptEula
