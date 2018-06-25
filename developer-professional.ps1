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
cinst PowerShell -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnet4.5 -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnet4.6.2 -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnet4.7 -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst netfx-4.7.1-devpack -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"

cinst dotnetcore-sdk -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnetcore -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnetcore-windowshosting -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnetcore-runtime.install --version 1.0.10 -my --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnetcore-runtime.install --version 1.1.7 -my --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnetcore-runtime.install --version 2.0.7 -my --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnetcore-runtime.install --version 2.1.0 -my --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"

#--- Applications ---
cinst googlechrome -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst javaruntime -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst notepadplusplus.install -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst notepad3.install -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"

#--- Visual Studio ---
cinst visualstudio2015professional -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"

cinst visualstudio2017professional -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst visualstudio2017-workload-manageddesktop -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst visualstudio2017-workload-netcoretools -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst visualstudio2017-workload-netweb -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst visualstudio2017-workload-node -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"

#--- Other dev ---
cinst git -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst resharper-ultimate-all -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst sql-server-management-studio -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst poshgit -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst sourcetree -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst linqpad -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst github -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst docker-for-windows -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst docker-kitematic -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst redis-desktop-manager -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst rdcman -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst ProcExp -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst cloudberryexplorer.s3 -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst postman -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst sysinternals -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst python -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst awstools.powershell -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"
cinst pip -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"

#--- Visual Studio Code ---
cinst visualstudiocode -y --cacheInstaller "$env:UserProfile\AppData\Local\ChocoCache"

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
