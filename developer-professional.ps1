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


#Run initial updates
Install-WindowsUpdate -AcceptEula

# Test env var EMGPrivateApiKey
if (Test-Path 'env:EMGPrivateApiKey') {
 throw "Enviorntment Variable 'EMGPrivateApiKey' needed";
}

# Setup dev directories
$DEVDIR = New-Item -ItemType Directory -Name "Development" -Path "C:\"
"GitHub", "EMG", "Tests", "LocalPackages", "Packages" | % { New-Item -ItemType Directory -Path $DEVDIR -Name $_ }

# Create NuGet.config for user
$nugetConfig = "<?xml version=""1.0"" encoding=""utf-8""?>
<configuration>
  <packageSources>	
	<add key=""EMG Private"" value=""https://www.myget.org/F/emgprivate/auth/%EMGPrivateApiKey%/api/v3/index.json"" protocolVersion=""3"" />
    <add key=""nuget.org"" value=""https://www.nuget.org/api/v2"" validated=""True"" trusted=""True"" />
    <add key=""EMG Public"" value=""https://www.myget.org/F/emg/api/v3/index.json"" />
	<add key=""Local"" value=""C:\Development\LocalPackages"" />
  </packageSources>
  <config>
	<add key=""globalPackagesFolder"" value=""C:\Development\Packages"" />
  </config>
</configuration>";

$nugetConfig | Out-File -FilePath $env:APPDATA\NuGet\NuGet.config

#Setup choco
$chocoCache = "$env:UserProfile\AppData\Local\ChocoCache"

New-Item -Path $chocoCache -ItemType directory -force
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
cinst PowerShell -y --cacheLocation $chocoCache
cinst dotnet4.5 -y --cacheLocation $chocoCache
cinst dotnet4.6.2 -y --cacheLocation $chocoCache
cinst dotnet4.7 -y --cacheLocation $chocoCache
cinst netfx-4.7.1-devpack -y --cacheLocation $chocoCache
cinst netfx-4.7.2-devpack -y --cacheLocation $chocoCache
cinst netfx-4.8-devpack -y --cacheLocation $chocoCache

cinst dotnetcore-sdk -y --cacheLocation $chocoCache
cinst dotnetcore -y --cacheLocation $chocoCache
cinst dotnetcore-windowshosting -y --cacheLocation $chocoCache
cinst dotnetcore-runtime.install --version 1.0.16 -my --cacheLocation $chocoCache
cinst dotnetcore-runtime.install --version 1.1.13 -my --cacheLocation $chocoCache
cinst dotnetcore-runtime.install --version 2.0.7 -my --cacheLocation $chocoCache
cinst dotnetcore-runtime.install --version 2.1.30 -my --cacheLocation $chocoCache
cinst dotnetcore-runtime.install --version 2.2.8 -my --cacheLocation $chocoCache
cinst dotnetcore-runtime.install --version 3.1.23 -my --cacheLocation $chocoCache

choco install dotnet-5.0-runtime -y --cacheLocation $chocoCache
choco install dotnet-5.0-sdk -y --cacheLocation $chocoCache

choco install dotnet-6.0-runtime -y --cacheLocation $chocoCache
choco install dotnet-6.0-sdk -y --cacheLocation $chocoCache

choco install dotnetcore-sdk

#Install dotnet CLI templates

dotnet new -i "Amazon.Lambda.Templates::*"
dotnet new -i EMG.Templates
dotnet new -i NUnit3.DotNetNew.Template
dotnet new -i "Kralizek.Lambda.Templates"

#--- Applications ---
cinst googlechrome -y --cacheLocation $chocoCache
cinst javaruntime -y --cacheLocation $chocoCache
cinst notepadplusplus.install -y --cacheLocation $chocoCache
cinst notepad3.install -y --cacheLocation $chocoCache

#--- Visual Studio ---
cinst visualstudio2017professional -y --cacheLocation $chocoCache
cinst visualstudio2017-workload-manageddesktop -y --cacheLocation $chocoCache
cinst visualstudio2017-workload-netcoretools -y --cacheLocation $chocoCache
cinst visualstudio2017-workload-netweb -y --cacheLocation $chocoCache
cinst visualstudio2017-workload-node -y --cacheLocation $chocoCache

cinst visualstudio2019professional -y --cacheLocation $chocoCache
cinst visualstudio2019-workload-manageddesktop -y --cacheLocation $chocoCache
cinst visualstudio2019-workload-netcoretools -y --cacheLocation $chocoCache
cinst visualstudio2019-workload-netweb -y --cacheLocation $chocoCache
cinst visualstudio2019-workload-node -y --cacheLocation $chocoCache

cinst visualstudio2022professional -y --cacheLocation $chocoCache
cinst visualstudio2022-workload-manageddesktop -y --cacheLocation $chocoCache
cinst visualstudio2022-workload-netcoretools -y --cacheLocation $chocoCache
cinst visualstudio2022-workload-netweb -y --cacheLocation $chocoCache
cinst visualstudio2022-workload-node -y --cacheLocation $chocoCache

# Dotnet tools
dotnet tool update --global Emg.Aws.Sso.Tool
dotnet tool update --global Amazon.ECS.Tools

#--- Other dev ---
cinst git -y --cacheLocation $chocoCache
cinst resharper-ultimate-all -y --cacheLocation $chocoCache
cinst sql-server-management-studio -y --cacheLocation $chocoCache
cinst poshgit -y --cacheLocation $chocoCache
cinst sourcetree -y --cacheLocation $chocoCache
cinst linqpad -y --cacheLocation $chocoCache
cinst github -y --cacheLocation $chocoCache
choco upgrade docker-desktop -y --cacheLocation $chocoCache
cinst docker-kitematic -y --cacheLocation $chocoCache
cinst redis-desktop-manager -y --cacheLocation $chocoCache
cinst rdcman -y --cacheLocation $chocoCache
cinst ProcExp -y --cacheLocation $chocoCache
cinst cloudberryexplorer.s3 -y --cacheLocation $chocoCache
cinst postman -y --cacheLocation $chocoCache
cinst sysinternals -y --cacheLocation $chocoCache
cinst python -y --cacheLocation $chocoCache
cinst awstools.powershell -y --cacheLocation $chocoCache
cinst pip -y --cacheLocation $chocoCache
cinst sass -y --cacheLocation $chocoCache
choco upgrade sourcetree -y --cacheLocation $chocoCache

#--- Fix issue with dart for Sass
[Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine) + ";C:\tools\dart-sdk\bin", [EnvironmentVariableTarget]::Machine)

#--- Visual Studio Code ---
cinst visualstudiocode -y --cacheLocation $chocoCache

code --install-extension ms-vscode.csharp
code --install-extension ms-vscode.powershell
code --install-extension formulahendry.auto--cacheLocationlose-tag
code --install-extension jchannon.csharpextensions
code --install-extension cake-build.cake-vscode
code --install-extension maptz.camelcasenavigation
code --install-extension PeterJausovec.vscode-docker
code --install-extension eamodio.gitlens

#--- WSL ---
wsl --install

# Install AWS Client VPN
$clientVpnFileName = [System.IO.Path]::GetTempFileName() + '.msi';

$clientVpnUrl = 'https://d20adtppz83p9s.cloudfront.net/WPF/latest/AWS_VPN_Client.msi';

Invoke-WebRequest $clientVpnUrl -OutFile $clientVpnFileName

Start-Process msiexec.exe -Wait -ArgumentList "/I clientVpnFileName /quiet"

#Run remaining updates
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -AcceptEula

# Reenable Windos Hello
$helloValue = "1"

New-ItemProperty -Path $helloPath\$helloKey -Name $helloName -Value $helloValue -PropertyType DWORD -Force
