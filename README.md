# SOC-LAB
- Windows Events Monitoring By Splunk

SOC Lab Setup:
- Windows 10 Client(1 node)
- Windows Server 2019(1 node)
- SPLUNK Standalone (installed on windows)
- Install SYSMON on server and client
- Configure SPLUNK UNIVERSAL FORWARDER on server and client

Send Logs to Splunk:
- SYSMON
- POWERSHELL
- SECURITY
- ACTIVE DIRECTORY
- SERVER APPLICATION
-  SYSTEM

Implement attacks using tools:
- IMPACKET
- CRACKMAPEXEC
- KERBEROASTING

Check the following Event IDs and create a Dashboard for each:
- Failed Logon 4625
- PreAuth Failed(GoldenTicket) 4771
- 4104 Windows Powershell Blocking Script
- 4103 Windows Powershell Module Logging
- 4769 (TGS Request Kerberoasting)
- Kerberoasting Encryption 0x17
- Check And research on TGT and TGS
