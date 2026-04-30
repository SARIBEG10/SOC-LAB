# SOC-LAB
## Windows Events Monitoring By Splunk

## 🌟 Highlights
Logs gathered By Splunk:
- SYSMON
- POWERSHELL
- SECURITY
- ACTIVE DIRECTORY
- SERVER APPLICATION
- SYSTEM

##  ⬇️ SOC Lab Setup
**Architecture:**
``` Powershell
Windows 10 Client 1                                            Kali 2022 (Attacker)
(Splunk Enterprise)                                            IP: 192.168.198.142
IP: 192.168.198.141                                            |       
                                                               |           Tools:
                                                               |           - IMPACKET
                                                               |           - CRACKMAPEXEC
                                                               |         
Ports:                                                         | 
- 8000 Web                                                     |  
- 9997 Receiver                                                |
- 8089 Management                                              |
                                                               | 
        ↑ logs                     - - - - - - - - - - - - - - |      
        │                         |                            
 ┌───────────────┬────────────────┐
 │                                │
 │                                |
Windows 10 Client 2         Windows Server 2019(my.domain.local)
IP: 192.168.198.143         IP: 192.168.198.135
Universal Forwarder         Universal Forwarder
Security/System Logs        Security/System Logs

- Windows 10 Client1 (SPLUNK Enterprise Standalone )
- Windows Server 2019(Universal Forwarder) (AD DS)
- Windows 10 Client 2 (Universal Forwarder) (Join To Domain)
```

## ℹ️ Overview

Event IDs:
> [!NOTE]
> **Dashboard Created for each of these**
- Failed Logon 4625
- PreAuth Failed(GoldenTicket) 4771
- 4104 Windows Powershell Blocking Script
- 4103 Windows Powershell Module Logging
- 4769 (TGS Request Kerberoasting)
- Kerberoasting Encryption 0x17
- Check And research on TGT and TGS

  
# ⬇️ Installation

## Windows 10 Client 1 :
1. **Download and Install Splunk Enterprise:**  [SPLUNK Installation on Windows](https://docs.splunk.com/Documentation/Splunk/9.4.2/Installation/InstallonWindows)

2. **Open Splunk Log Recieving Port On Server:**
  > In PowerShell 
```
New-NetFirewallRule -DisplayName "Splunk 9997" -Direction Inbound -Protocol TCP -LocalPort 9997 -Action Allow
```

3. **Create Indexes:**
   ```  Powershell
   Splunk Installed Path Example : E:\Program Files\Splunk + Index Config SubDir: \etc\system\local\indexes.conf

   indexes.conf Example:
   
   [windows_lab] -> Index name
   homePath = D:\SplunkData\windows_lab\db -> bucket path
   coldPath = D:\SplunkData\windows_lab\colddb
   thawedPath = D:\SplunkData\windows_lab\thaweddb

   ON WEB UI:
   Settings -> Indexes
   Add Indexes Created Manually in indexes.conf

   CMD: Run As Admin
    - cd C:\ProgramFile\Splunk\bin
    - splunk.exe restart

   ```
## Windows 10 Client 2 & Windows Server 2019:
1.  **Install Universal Forwarder**
     - [Installation Guide](https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://help.splunk.com/en/splunk-cloud-platform/forward-and-process-data/universal-forwarder-manual/9.0/install-the-universal-forwarder/install-a-windows-universal-forwarder&ved=2ahUKEwiortaYjJWUAxULhv0HHf1WJMkQFnoECBwQAQ&usg=AOvVaw20cBCp6NDQbdT2y157HDDS)
2. **Install Sysmon**
     - [Sysmon Installation](https://www.blumira.com/blog/enable-sysmon)
3. **ENABLE LOGS:**
   ```  Powershell
     Windows Server 2019:
      1 - Login As Local Administrator
      2 - Win+ R
      3 - gpmc.msc
           Forest
             └── Domains
                  └── (your Domain)
                         └── Domain Controllers
       - Right Click And Select Edit On:
             Default Domain Controllers Policy

       - Navigate To:
             Computer Configuration
                   └── Policies
                              └── Windows Settings
                                         └── Security Settings
       - Choose:
           Advanced Audit Policy Configuration

       - Account Logon
            Audit Kerberos Authentication Service → Success + Failure
            Audit Kerberos Service Ticket Operations → Success + Failure
       - Logon/Logoff
           Audit Logon → Success + Failure

       4 - In PowerShell Run: 
                gpupdate /force

       Windows 10 Client 2:
        1- Win + R
        2- gpedit.msc
        - Navigate To:
            Computer Configuration
                 └── Administrative Templates
                        └── Windows Components
                                 └── Windows PowerShell
         - Turn On PowerShell Module Logging => Add * For All Modules
         - Turn On PowerShell Script Block Logging
         - Turn on PowerShell Transcription => Set output directory (example): C:\PS_Logs

         3- In PowerShell Run: 
                gpupdate /force

   ```

4. **Open Splunk Log Sending Port On Both:**
      > In PowerShell:
      ```
        New-NetFirewallRule -DisplayName "Splunk 9997" -Direction Outbound -Protocol TCP -LocalPort 9997 -Action Allow

      ```
5. **Create Inputs.conf:**
  >[!NOTE]
  > **Windows Event Listener And Log Forwarding Configuration file**
``` Powershell
1-Universal Forwarder Installed Path Example : C:\ProgramFile\SplunkUniversalForwarder + Inputs conf SubDir: \etc\system\local
2-Create inputs.conf (you should Create Manually)

3- inputs.conf Example:
    [WinEventLog://Microsoft-Windows-PowerShell/Operational]
    disabled = 0
    index = windows_lab
4- CMD: Run As Admin
    - cd C:\ProgramFile\SplunkUniversalForwarder\bin
    - splunk.exe restart
```
>[!TIP]
>For More Info and Examples: **[Inputs.conf Documentation](https://help.splunk.com/en/splunk-cloud-platform/forward-and-process-data/forwarding-and-receiving-data/10.1.2507/configure-forwarders/configure-the-universal-forwarder-using-configuration-files)**
 
   




