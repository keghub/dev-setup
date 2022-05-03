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
 
New-Item -Path $helloPath -Name $helloKey -Force
 
New-ItemProperty -Path $helloPath\$helloKey -Name $helloName -Value $helloValue -PropertyType DWORD -Force


#Set primary DNS suffix
Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters -Name 'Domain' -Value 'stockholm.educations.com'
Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters -Name 'NV Domain' -Value 'stockholm.educations.com'


#Run initial updates
Install-WindowsUpdate -AcceptEula


# Test env var EMGPrivateApiKey
if (!(Test-Path 'env:EMGPrivateApiKey')) {
 throw "Enviorntment Variable 'EMGPrivateApiKey' needed";
}

# Setup dev directories
$DEVDIR = New-Item -ItemType Directory -Name "Development" -Path "C:\" -Force
"GitHub", "EMG", "Tests", "LocalPackages", "Packages" | % { New-Item -ItemType Directory -Path $DEVDIR -Name $_ -Force }


if (!(Test-Path $env:APPDATA\NuGet\NuGet.config)) {
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

	$nugetConfig | Out-File -FilePath $env:APPDATA\NuGet\NuGet.config -Encoding utf8
}

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
choco upgrade -y Containers -source windowsFeatures
choco upgrade -y Microsoft-Hyper-V-All -source windowsFeatures
choco upgrade -y Microsoft-Windows-Subsystem-Linux -source windowsfeatures
choco upgrade -y IIS-WebServerRole -source windowsfeatures
choco upgrade -y IIS-HttpCompressionDynamic -source windowsfeatures
choco upgrade -y IIS-ManagementScriptingTools -source windowsfeatures
choco upgrade -y IIS-WindowsAuthentication -source windowsfeatures
choco upgrade -y IIS-ASPNET -source windowsfeatures
choco upgrade -y IIS-ASPNET45 -source windowsfeatures


#--- .NET ---
choco upgrade PowerShell -y --cacheLocation $chocoCache
choco upgrade dotnet4.5 -y --cacheLocation $chocoCache
choco upgrade dotnet4.6.2 -y --cacheLocation $chocoCache
choco upgrade dotnet4.7 -y --cacheLocation $chocoCache
choco upgrade netfx-4.7.1-devpack -y --cacheLocation $chocoCache
choco upgrade netfx-4.7.2-devpack -y --cacheLocation $chocoCache
choco upgrade netfx-4.8-devpack -y --cacheLocation $chocoCache

choco upgrade dotnetcore-sdk -y --cacheLocation $chocoCache
choco upgrade dotnetcore -y --cacheLocation $chocoCache
choco upgrade dotnetcore-windowshosting -y --cacheLocation $chocoCache
choco upgrade dotnetcore-runtime.install --version 1.0.16 -my --cacheLocation $chocoCache
choco upgrade dotnetcore-runtime.install --version 1.1.13 -my --cacheLocation $chocoCache
choco upgrade dotnetcore-runtime.install --version 2.0.7 -my --cacheLocation $chocoCache
choco upgrade dotnetcore-runtime.install --version 2.1.30 -my --cacheLocation $chocoCache
choco upgrade dotnetcore-runtime.install --version 2.2.8 -my --cacheLocation $chocoCache
choco upgrade dotnetcore-runtime.install --version 3.1.23 -my --cacheLocation $chocoCache

choco upgrade dotnet-5.0-runtime -y --cacheLocation $chocoCache
choco upgrade dotnet-5.0-sdk -y --cacheLocation $chocoCache

choco upgrade dotnet-6.0-runtime -y --cacheLocation $chocoCache
choco upgrade dotnet-6.0-sdk -y --cacheLocation $chocoCache

choco install dotnetcore-sdk -y --cacheLocation $chocoCache


#Install dotnet CLI templates

dotnet new -i "Amazon.Lambda.Templates::*"
dotnet new -i EMG.Templates
dotnet new -i NUnit3.DotNetNew.Template
dotnet new -i "Kralizek.Lambda.Templates"


#--- Applications ---
choco upgrade googlechrome -y --cacheLocation $chocoCache
choco upgrade javaruntime -y --cacheLocation $chocoCache
choco upgrade notepadplusplus.install -y --cacheLocation $chocoCache
choco upgrade notepad3.install -y --cacheLocation $chocoCache
choco upgrade sharex -y --cacheLocation $chocoCache
choco upgrade ffmpeg -y --cacheLocation $chocoCache
choco upgrade 7zip -y --cacheLocation $chocoCache
choco upgrade slack -y --cacheLocation $chocoCache
choco upgrade googledrive -y --cacheLocation $chocoCache
choco upgrade google-workspace-sync -y --cacheLocation $chocoCache --ignore-checksums


#--- Visual Studio ---
choco upgrade visualstudio2017professional -y --cacheLocation $chocoCache
choco upgrade visualstudio2017-workload-manageddesktop -y --cacheLocation $chocoCache
choco upgrade visualstudio2017-workload-netcoretools -y --cacheLocation $chocoCache
choco upgrade visualstudio2017-workload-netweb -y --cacheLocation $chocoCache --package-parameters "--includeOptional"
choco upgrade visualstudio2017-workload-node -y --cacheLocation $chocoCache

choco upgrade visualstudio2019professional -y --cacheLocation $chocoCache
choco upgrade visualstudio2019-workload-manageddesktop -y --cacheLocation $chocoCache
choco upgrade visualstudio2019-workload-netcoretools -y --cacheLocation $chocoCache
choco upgrade visualstudio2019-workload-netweb -y --cacheLocation $chocoCache --package-parameters "--includeOptional"
choco upgrade visualstudio2019-workload-node -y --cacheLocation $chocoCache

choco upgrade visualstudio2022professional -y --cacheLocation $chocoCache
choco upgrade visualstudio2022-workload-manageddesktop -y --cacheLocation $chocoCache
choco upgrade visualstudio2022-workload-netcoretools -y --cacheLocation $chocoCache
choco upgrade visualstudio2022-workload-netweb -y --cacheLocation $chocoCache --package-parameters "--includeOptional"
choco upgrade visualstudio2022-workload-node -y --cacheLocation $chocoCache


# Dotnet tools
dotnet tool update --global Emg.Aws.Sso.Tool --version 0.0.24
dotnet tool update --global Amazon.ECS.Tools


#--- Other dev ---
choco upgrade git -y --cacheLocation $chocoCache
choco upgrade resharper-ultimate-all -y --cacheLocation $chocoCache
choco upgrade sql-server-management-studio -y --cacheLocation $chocoCache
choco upgrade poshgit -y --cacheLocation $chocoCache
choco upgrade linqpad5 -y --cacheLocation $chocoCache
choco upgrade linqpad6 -y --cacheLocation $chocoCache
choco upgrade linqpad7 -y --cacheLocation $chocoCache
choco upgrade github -y --cacheLocation $chocoCache
choco upgrade docker-desktop -y --cacheLocation $chocoCache
choco upgrade redis-desktop-manager -y --cacheLocation $chocoCache
choco upgrade rdcman -y --cacheLocation $chocoCache
choco upgrade ProcExp -y --cacheLocation $chocoCache
choco upgrade cloudberryexplorer.s3 -y --cacheLocation $chocoCache
choco upgrade postman -y --cacheLocation $chocoCache
choco upgrade sysinternals -y --cacheLocation $chocoCache
choco upgrade python -y --cacheLocation $chocoCache
choco upgrade awstools.powershell -y --cacheLocation $chocoCache
choco upgrade pip -y --cacheLocation $chocoCache
choco upgrade sass -y --cacheLocation $chocoCache
choco upgrade sourcetree -y --cacheLocation $chocoCache
choco upgrade awscli -y --cacheLocation $chocoCache
choco upgrade ngrok -y --cacheLocation $chocoCache
choco upgrade nodejs.install -y --cacheLocation $chocoCache
choco upgrade putty -y --cacheLocation $chocoCache


#--- Fix issue with dart for Sass
[Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine) + ";C:\tools\dart-sdk\bin", [EnvironmentVariableTarget]::Machine)


#--- Visual Studio Code ---
choco upgrade visualstudiocode -y --cacheLocation $chocoCache

code --install-extension ms-dotnettools.csharp
code --install-extension ms-vscode.powershell
code --install-extension jchannon.csharpextensions
code --install-extension cake-build.cake-vscode
code --install-extension maptz.camelcasenavigation
code --install-extension eamodio.gitlens
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode-remote.remote-containers
code --install-extension glenn2223.live-sass
code --install-extension ms-vscode.vscode-typescript-tslint-plugin
code --install-extension stylelint.vscode-stylelint


#--- WSL ---
wsl --install -d Ubuntu


# Install AWS Client VPN
$clientVpnFileName = [System.IO.Path]::GetTempFileName() + '.msi';

$clientVpnUrl = 'https://d20adtppz83p9s.cloudfront.net/WPF/latest/AWS_VPN_Client.msi';

Invoke-WebRequest $clientVpnUrl -OutFile $clientVpnFileName

Start-Process msiexec.exe -Wait -ArgumentList "/I $clientVpnFileName /quiet"


#Run remaining updates
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -AcceptEula


# Reenable Windos Hello

New-ItemProperty -Path $helloPath\$helloKey -Name $helloName -Value 1 -PropertyType DWORD -Force
