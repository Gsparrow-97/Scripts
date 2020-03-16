echo "This shell will configure your computer to manage a HYPER-V Server Core 2016 or HYPER-V Server Core 2019 Machine"
echo "First We need to Make sure your WI-FI/LAN connection is set to Private"
echo "================================================================================================================"
echo "These are all you current connections"
Get-NetConnectionProfile
$Interface = Read-Host -Prompt 'Enter the Interface Index of the network you want to use to manage your HYPER-V machine'
Set-NetConnectionProfile  -InterfaceIndex $Interface -NetworkCategory Private
echo "y" | winrm quickconfig
$IP = Read-Host -Prompt 'Enter the IP address of your HYPER-V machine'
$Name = Read-Host -Prompt 'Enter the computer name your HYPER-V machine'
$Admin = Read-Host -Promp ' Enter a username to connect to Your HYPER-V Machine'
$Pass = Read-Host -Promp ' Enter the password for username used to connect to Your HYPER-V Machine'
set-item WSMan:\localhost\Client\TrustedHosts -value "$Name"
set-item WSMan:\localhost\Client\TrustedHosts -value "$IP"
Enable-WSManCredSSP -role client -DelegateComputer "$Name"
Enable-WSManCredSSP -role client -DelegateComputer "$IP"

winrm s winrm/config/client '@{TrustedHosts=$IP}'
cmdkey /add:$IP /user:$Name\$Admin /pass $Pass
echo " Now Open HYPER V Manager on you windows 10 PC, connect to your hyperv server via IT's IP Address"
Read-Host -Prompt "Press Enter to exit"
