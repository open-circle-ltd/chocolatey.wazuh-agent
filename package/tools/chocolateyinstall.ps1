$ErrorActionPreference = 'Stop';
$PackageParameters = Get-PackageParameters

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$urlPackage = 'https://packages.wazuh.com/4.x/windows/wazuh-agent-4.7.3-1.msi'
$checksumPackage = 'feb366cf9c06e8aa1bd7db0715a31e017366eee0a594a8363c94da4b4c3e880d191a9c738acbfbaac74a99b253c297b2f05fb66ab6c9cdf37d0781d6cc288d92'

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
