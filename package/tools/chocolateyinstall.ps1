$ErrorActionPreference = 'Stop';
$PackageParameters = Get-PackageParameters

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

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
    $args = $args + " WAZUH_AGENT_GROUP=" + $PackageParameters['Group']
}

Write-Output $args

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'msi'
    url            = "https://packages.wazuh.com/3.x/windows/wazuh-agent-3.10.2-1.msi"
    checksum       = "fdd275120acb087b6127595071aa7c2ef956f2935b0680f2250251adc5de2e7267c0d353c3cee965b28f33654e69ab0600483b5438bfcc69265e8041802c6514"
    checksumType   = 'SHA512'
    url64          = "https://packages.wazuh.com/3.x/windows/wazuh-agent-3.10.2-1.msi"
    checksum64     = "fdd275120acb087b6127595071aa7c2ef956f2935b0680f2250251adc5de2e7267c0d353c3cee965b28f33654e69ab0600483b5438bfcc69265e8041802c6514"
    checksumType64 = 'SHA512'
    silentArgs     = "$($args) /q"
    ValidExitCodes = @(0, 1000, 1101)
}

Install-ChocolateyPackage @packageArgs

if ($PackageParameters.CleanStartmenu) {
    Remove-FileItem `
        -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\OSSEC"
}
