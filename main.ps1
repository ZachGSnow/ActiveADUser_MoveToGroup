Define variable for OU to search for users. Alter for your need. Use Distinguished name for OU / CN.
$SearchBase = "OU=xxx,DC=company,DC=com"

#Get ADusers where the LastLogonDate AD Attribute is a date within the past 60 days, not null, and the ADUser has the AD Property 'mail' defined.
#Then for-each iterate each object and add them to the desired ADGroup. Change 'ADGROUPHERE'.
Get-ADUser -Filter {Enabled -eq $TRUE} -SearchScope OneLevel -SearchBase $SearchBase -Properties SamAccountName,mail,LastLogonDate | Where-object {($_.LastLogonDate -gt (Get-Date).AddDays(-60)) -and ($_.LastLogonDate -ne $NULL) -and ($_.mail -ne $NULL)} | Select SamAccountName | ForEach-Object{
Add-adgroupmember -identity 'ADGROUPHERE' -members $_.SamAccountName
}
