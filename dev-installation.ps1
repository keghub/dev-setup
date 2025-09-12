# Test env var EMGPrivateApiKey
if (!(Test-Path 'env:EMGPrivateApiKey')) {
 throw "Enviorntment Variable 'EMGPrivateApiKey' needed";
}

# Set explorer options
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

# Setup dev directories
if (!(Test-Path D:\Development)) {
	Try
	{
		$DEVDIR = New-Item -ItemType Directory -Name "Development" -Path "D:\" -Force
			"GitHub", "EMG", "Tests", "LocalPackages", "Packages" | % { New-Item -ItemType Directory -Path $DEVDIR -Name $_ -Force }
	}
	Catch
	{
		Write-Host 'Couldnt create dev directories'
	}
}


if (!(Test-Path $env:APPDATA\NuGet\NuGet.config)) {
	# Create NuGet.config for user
	$nugetConfig = "<?xml version=""1.0"" encoding=""utf-8""?>
	<configuration>
	  <packageSources>
		<add key=""EMG Private"" value=""https://www.myget.org/F/emgprivate/auth/%EMGPrivateApiKey%/api/v3/index.json"" protocolVersion=""3"" />
		<add key=""nuget.org"" value=""https://api.nuget.org/v3/index.json"" validated=""True"" trusted=""True"" />
		<add key=""EMG Public"" value=""https://www.myget.org/F/emg/api/v3/index.json"" />
		<add key=""Local"" value=""D:\Development\LocalPackages"" />
	  </packageSources>
	  <config>
		<add key=""globalPackagesFolder"" value=""D:\Development\Packages"" />
	  </config>
	</configuration>";

	$nugetConfig | Out-File -FilePath (New-Item -Path $env:APPDATA\NuGet\NuGet.config -Force) -Encoding utf8
}

#Setup choco
$chocoCache = "$env:UserProfile\AppData\Local\ChocoCache"

New-Item -Path $chocoCache -ItemType directory -force

#--- Windows features ---
choco install -y Containers -source windowsFeatures
choco install -y Microsoft-Hyper-V-All -source windowsFeatures
choco install -y Microsoft-Windows-Subsystem-Linux -source windowsfeatures
choco install -y IIS-WebServerRole -source windowsfeatures
choco install -y IIS-HttpCompressionDynamic -source windowsfeatures
choco install -y IIS-ManagementScriptingTools -source windowsfeatures
choco install -y IIS-WindowsAuthentication -source windowsfeatures
choco install -y IIS-ASPNET -source windowsfeatures
choco install -y IIS-ASPNET45 -source windowsfeatures

#--- .NET ---
choco upgrade PowerShell -y --cacheLocation $chocoCache
choco upgrade dotnet4.6.2 -y --cacheLocation $chocoCache
choco upgrade dotnet4.7 -y --cacheLocation $chocoCache
choco upgrade netfx-4.6.2-devpack -y --cacheLocation $chocoCache
choco upgrade netfx-4.7-devpack -y --cacheLocation $chocoCache
choco upgrade netfx-4.7.1-devpack -y --cacheLocation $chocoCache
choco upgrade netfx-4.7.2-devpack -y --cacheLocation $chocoCache
choco upgrade netfx-4.8-devpack -y --cacheLocation $chocoCache

choco upgrade dotnet-8.0-runtime -y --cacheLocation $chocoCache
choco upgrade dotnet-8.0-aspnetruntime -y --force
choco upgrade dotnet-8.0-sdk -y --cacheLocation $chocoCache

choco upgrade dotnet-aspnetcoremodule-v1 -y --cacheLocation $chocoCache
choco upgrade dotnet-aspnetcoremodule-v2 -y --cacheLocation $chocoCache

refreshenv

#Install dotnet CLI templates

dotnet new install "Amazon.Lambda.Templates::*"
dotnet new install EMG.Templates
dotnet new install NUnit3.DotNetNew.Template

#--- Applications ---
choco upgrade javaruntime -y --cacheLocation $chocoCache
choco upgrade notepadplusplus.install -y --cacheLocation $chocoCache
choco upgrade notepad3.install -y --cacheLocation $chocoCache

#--- Visual Studio ---
choco upgrade visualstudio2022professional -y --cacheLocation $chocoCache
refreshenv
choco upgrade visualstudio2022-workload-manageddesktop -y --cacheLocation $chocoCache
choco upgrade visualstudio2022-workload-netcoretools -y --cacheLocation $chocoCache
choco upgrade visualstudio2022-workload-netweb -y --cacheLocation $chocoCache --package-parameters "--includeOptional --add Microsoft.VisualStudio.Web.Mvc4.ComponentGroup"
choco upgrade visualstudio2022-workload-node -y --cacheLocation $chocoCache

# Dotnet tools
dotnet tool update --global Emg.Aws.Sso.Tool
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
choco upgrade postman -y --cacheLocation $chocoCache
choco upgrade sysinternals -y --cacheLocation $chocoCache
choco upgrade python -y --cacheLocation $chocoCache
choco upgrade awstools.powershell -y --cacheLocation $chocoCache
choco upgrade pip -y --cacheLocation $chocoCache
choco upgrade sourcetree -y --cacheLocation $chocoCache
choco upgrade awscli -y --cacheLocation $chocoCache
choco upgrade ngrok -y --cacheLocation $chocoCache
choco upgrade nodejs-lts -y --cacheLocation $chocoCache
choco upgrade putty -y --cacheLocation $chocoCache
choco upgrade tortoisegit -y --cacheLocation $chocoCache
choco upgrade windirstat -y --cacheLocation $chocoCache
choco upgrade whysoslow -y --cacheLocation $chocoCache
choco upgrade sql-server-2022 -y --cacheLocation $chocoCache

#--- Visual Studio Code ---
choco upgrade visualstudiocode -y --cacheLocation $chocoCache

Try
{
    refreshenv
    
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
}
Catch 
{
    Write-Host 'Error installing code extensions'
}

#--- WSL ---
wsl --install -d Ubuntu

# Install containers
refreshenv
docker create --name rabbitmq -p 4369:4369 -p 15672:15672 -p 5672:5672 rabbitmq:management
