# Chocolatey Package: wazuh-agent

[![license](https://img.shields.io/github/license/mashape/apistatus.svg?style=popout-square)](licence) [![Chocolatey](https://img.shields.io/chocolatey/v/wazuh-agent?label=package%20version)](https://chocolatey.org/packages/wazuh-agent) [![Chocolatey](https://img.shields.io/chocolatey/dt/wazuh-agent?label=package%20downloads&style=flat-square)](https://chocolatey.org/packages/wazuh-agent)

## Description

Wazuh helps you to gain deeper security visibility into your infrastructure by monitoring hosts at an operating system and application level.

## Package Parameters

- `ApplicationFolder:` Sets the installation path. Default C:\Program Files (x86)\ossec-agent.
- `Manager:` Specifies the managers IP address or hostname. This option also accepts a list of IPs or hostnames separated by semicolons.
- `ManagerPort:` Specifies the managers connection port.
- `Protocol:` Sets the communication protocol between the manager and the agent. Accepts UDP and TCP. Default is UDP.
- `RegistrationServer:` Specifies the Authd IP address.
- `RegistrationPort:` Specifies the Authd connection port.
- `RegistrationPassword:` Sets the Authd password.
- `KeepAliveInterval:` Sets the time between manager checks.
- `TimeReconnect:` Sets the time in seconds until a reconnection attempt.
- `RegistrationCA:` Specifies the path of the certificate authority.
- `RegistrationCertificate:` Specifies the certificate path.
- `RegistrationKey:` Specifies the key path.
- `AgentName:` Designates the agent's name. By default will be the computer name.
- `AgentGroup:` Assigns the agent to one or more existing groups (separated by commas).

## Installation

Installation without parameters.

```ps1
 choco install wazuh-agent
```

Installation with parameters.

```ps1
 choco install wazuh-agent --params="'/Manager:192.168.1.5 /AgentName:Chocolatey'"
```

## Disclaimer

These Chocolatey packages only contain installation routines. The software itself is downloaded from the official sources of the software developer. Open Circle AG has no affilation with the software developer.

## Author

- [Simon Bärlocher](https://sbaerlocher.ch)
- [Open Circle AG](https://www.open-circle.ch)

## License

This project is under the MIT License. See the [LICENSE](licence) file for the full license text.

## Copyright

(c) 2023, Open Circle AG
