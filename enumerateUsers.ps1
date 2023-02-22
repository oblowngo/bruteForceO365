Param([Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)]$domain
,[Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=1)]$dictionary,
[Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=2)]$team,
[Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=3)]$channel)

$file_dict = Get-Content .\$dictionary


Import-Module MicrosoftTeams
Import-Module Microsoft.Graph.Teams


Connect-MicrosoftTeams
Connect-MgGraph -Scopes "ChannelMember.ReadWrite.All"

$group = New-Team -MailNickname $team -displayname $team -Visibility "private"
New-TeamChannel -GroupId $group.GroupId -DisplayName $channel -MembershipType "Shared"
$channelId=Get-TeamChannel -GroupId $group.GroupId -MembershipType Shared | Select Id -ExpandProperty Id
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