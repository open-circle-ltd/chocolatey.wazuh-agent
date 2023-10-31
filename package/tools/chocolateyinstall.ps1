$ErrorActionPreference = 'Stop';
$PackageParameters = Get-PackageParameters

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$urlPackage = 'https://packages.wazuh.com/4.x/windows/wazuh-agent-4.6.0-1.msi'
$checksumPackage = '67ba49cb437187ede2788024ac04429850aec484bde811b763dda9969741abc9549e3aae2b383a455b7587b2c09103e143990feee36ac44236df1d952ef3e22e'

Import-Module -Name "$($toolsDir)\helpers.ps1"

$args = ""

if ($PackageParameters['ApplicationFolder']) {
    $args = $args + " APPLICATIONFOLDER=" + $PackageParameters['ApplicationFolder']
}

if ($PackageParameters['Manager']) {
    $args = $args + " WAZUH_MANAGER=" + $PackageParameters['Manager']
}

if ($PackageParameters['ManagerPort']) {
    $args = $args + " WAZUH_MANAGER_PORT=" + $PackageParameters['ManagerPort']
}

if ($PackageParameters['Protocol']) {
    $args = $args + " WAZUH_PROTOCOL=" + $PackageParameters['Protocol']
}

if ($PackageParameters['RegistrationServer']) {
    $args = $args + " WAZUH_REGISTRATION_SERVER=" + $PackageParameters['RegistrationServer']
}

if ($PackageParameters['RegistrationPort']) {
    $args = $args + " WAZUH_REGISTRATION_SERVER=" + $PackageParameters['RegistrationPort']
}

if ($PackageParameters['RegistrationPassword']) {
    $args = $args + " WAZUH_REGISTRATION_PASSWORD=" + $PackageParameters['RegistrationPassword']
}

if ($PackageParameters['KeepAliveInterval']) {
    $args = $args + " WAZUH_KEEP_ALIVE_INTERVAL=" + $PackageParameters['KeepAliveInterval']
}

if ($PackageParameters['TimeReconnect']) {
    $args = $args + " WAZUH_TIME_RECONNECT=" + $PackageParameters['TimeReconnect']
}

if ($PackageParameters['RegistrationCA']) {
    $args = $args + " WAZUH_REGISTRATION_CA=" + $PackageParameters['RegistrationCA']
}

if ($PackageParameters['RegistrationCertificate']) {
    $args = $args + " WAZUH_REGISTRATION_CERTIFICATE=" + $PackageParameters['RegistrationCertificate']
}

if ($PackageParameters['RegistrationKey']) {
    $args = $args + " WAZUH_REGISTRATION_KEY=" + $PackageParameters['RegistrationKey']
}

if ($PackageParameters['AgentName']) {
    $args = $args + " WAZUH_AGENT_NAME=" + $PackageParameters['AgentName']
}

if ($PackageParameters['AgentGroup']) {
    $args = $args + " WAZUH_AGENT_GROUP=" + $PackageParameters['AgentGroup']
}

Write-Output $args

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'msi'
    url            = $urlPackage
    checksum       = $checksumPackage
    checksumType   = 'SHA512'
    url64          = $urlPackage
    checksum64     = $checksumPackage
    checksumType64 = 'SHA512'
    silentArgs     = "$($args) /q"
    ValidExitCodes = @(0, 1000, 1101)
}

Install-ChocolateyPackage @packageArgs

if ($PackageParameters.CleanStartmenu) {
    Remove-FileItem `
        -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\OSSEC"
}
