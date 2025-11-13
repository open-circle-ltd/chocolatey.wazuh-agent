$ErrorActionPreference = 'Stop';
$PackageParameters = Get-PackageParameters

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$urlPackage = 'https://packages.wazuh.com/4.x/windows/wazuh-agent-4.14.1-1.msi'
$checksumPackage = 'c1d6a3d80aa6619c8cadaab730a59631362dc6d2007862aea0dae354f537bea01cdd06e0a192f1255e4a06915271596c2a22b2241a3b7d3accd73e0ab66d9b14'

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
