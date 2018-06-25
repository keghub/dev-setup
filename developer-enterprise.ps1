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
cinst PowerShell -y
cinst dotnet4.5 -y
cinst dotnet4.6.2 -y
cinst dotnet4.7 -y
cinst netfx-4.7.1-devpack -y

cinst dotnetcore-sdk -y
cinst dotnetcore -y
cinst dotnetcore-windowshosting -y
cinst dotnetcore-runtime.install --version 1.0.10 -my
cinst dotnetcore-runtime.install --version 1.1.7 -my
cinst dotnetcore-runtime.install --version 2.0.7 -my
cinst dotnetcore-runtime.install --version 2.1.0 -my

#--- Applications ---
cinst googlechrome -y
cinst javaruntime -y
cinst notepadplusplus.install -y
cinst notepad3.install -y

#--- Visual Studio ---
cinst visualstudio2015enterprise -y

cinst visualstudio2017enterprise -y
cinst visualstudio2017-workload-manageddesktop -y
cinst visualstudio2017-workload-netcoretools -y
cinst visualstudio2017-workload-netweb -y
cinst visualstudio2017-workload-node -y

#--- Other dev ---
cinst git -y
cinst resharper-ultimate-all -y
cinst sql-server-management-studio -y
cinst poshgit -y
cinst sourcetree -y
cinst linqpad -y
cinst github -y
cinst docker-for-windows -y
cinst docker-kitematic -y
cinst redis-desktop-manager -y
cinst rdcman -y
cinst ProcExp -y
cinst cloudberryexplorer.s3 -y
cinst postman -y
cinst sysinternals -y
cinst python -y
cinst awstools.powershell -y
cinst pip -y

#--- Visual Studio Code ---
cinst visualstudiocode -y

code --install-extension ms-vscode.csharp
code --install-extension ms-vscode.powershell
code --install-extension formulahendry.auto-close-tag
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
