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
cinst -y IIS-ASPNET -source windowsfeatures
cinst -y IIS-ASPNET45 -source windowsfeatures

#--- .NET ---
cinst PowerShell -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnet4.5 -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnet4.6.2 -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnet4.7 -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst netfx-4.7.1-devpack -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"

cinst dotnetcore-sdk -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnetcore -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnetcore-windowshosting -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnetcore-runtime.install --version 1.0.10 -my --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnetcore-runtime.install --version 1.1.7 -my --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnetcore-runtime.install --version 2.0.7 -my --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst dotnetcore-runtime.install --version 2.1.0 -my --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"

#--- Applications ---
cinst googlechrome -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst javaruntime -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst notepadplusplus.install -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst notepad3.install -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"

#--- Visual Studio ---
# Visual studio currently does not work when in the installation procees, it tends to hang
# cinst visualstudio2015enterprise -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"

# cinst visualstudio2017enterprise -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
# cinst visualstudio2017-workload-manageddesktop -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
# cinst visualstudio2017-workload-netcoretools -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
# cinst visualstudio2017-workload-netweb -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
# cinst visualstudio2017-workload-node -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"

#--- Other dev ---
cinst git -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst resharper-ultimate-all -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst sql-server-management-studio -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst poshgit -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst sourcetree -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst linqpad -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst github -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst docker-for-windows -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst docker-kitematic -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst redis-desktop-manager -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst rdcman -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst ProcExp -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst cloudberryexplorer.s3 -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst postman -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst sysinternals -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst python -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst awstools.powershell -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst pip -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"

#--- Visual Studio Code ---
cinst visualstudiocode -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"

code --install-extension ms-vscode.csharp
code --install-extension ms-vscode.powershell
code --install-extension formulahendry.auto--cacheLocationlose-tag
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
