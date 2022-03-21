New-Item -Path $env:UserProfile\AppData\Local\ChocoCache -ItemType directory -force
Disable-UAC

####################################################################################
#
# Ian Waters
#
# www.slashadmin.co.uk
#
# Prevents Windows 10 prompting to setup a pin after being added to Azure AD
#
# Designed for use with Office 365 Business Premium subscriptions
#
####################################################################################
 
#Disable pin requirement
$helloPath = "HKLM:\SOFTWARE\Policies\Microsoft"
$helloKey = "PassportForWork"
$helloName = "Enabled"
$helloValue = "0"
 
New-Item -Path $helloPath -Name $helloKey –Force
 
New-ItemProperty -Path $helloPath\$helloKey -Name $helloName -Value $helloValue -PropertyType DWORD -Force


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
cinst netfx-4.7.2-devpack -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst netfx-4.8-devpack -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"

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
cinst visualstudio2017professional -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst visualstudio2017-workload-manageddesktop -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst visualstudio2017-workload-netcoretools -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst visualstudio2017-workload-netweb -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst visualstudio2017-workload-node -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"

cinst visualstudio2019professional -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst visualstudio2019-workload-manageddesktop -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst visualstudio2019-workload-netcoretools -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst visualstudio2019-workload-netweb -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
cinst visualstudio2019-workload-node -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"

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
cinst sass -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"

#--- Fix issue with dart for Sass
[Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine) + ";C:\tools\dart-sdk\bin", [EnvironmentVariableTarget]::Machine)

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

$helloValue = "1"

New-ItemProperty -Path $helloPath\$helloKey -Name $helloName -Value $helloValue -PropertyType DWORD -Force
