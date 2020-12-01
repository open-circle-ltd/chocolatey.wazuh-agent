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
    url            = "https://packages.wazuh.com/4.x/windows/wazuh-agent-4.0.3-1.msi"
    checksum       = "ac5f9337be10f80ce8c71d6b92762d7899d2661c485e4339f16d8296ebd494158008d0027fc8edf3eb672dffd1b206c96c59d2679cf40050dab4726e79e22362"
    checksumType   = 'SHA512'
    url64          = "https://packages.wazuh.com/4.x/windows/wazuh-agent-4.0.3-1.msi"
    checksum64     = "ac5f9337be10f80ce8c71d6b92762d7899d2661c485e4339f16d8296ebd494158008d0027fc8edf3eb672dffd1b206c96c59d2679cf40050dab4726e79e22362"
    checksumType64 = 'SHA512'
    silentArgs     = "$($args) /q"
    ValidExitCodes = @(0, 1000, 1101)
}

Install-ChocolateyPackage @packageArgs

if ($PackageParameters.CleanStartmenu) {
    Remove-FileItem `
        -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\OSSEC"
}
