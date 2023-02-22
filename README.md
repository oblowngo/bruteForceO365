# bruteFroceO365
Brute force usernames fron another tenant
<#
Explain:
	Brute force o365 tenant accounts. Similar to vrfy command
Prerequisites:
	Tenant
	Cross tenant policy block 
Modules:
	MicrosoftTeams (install-module MicrosoftTeams)
	Microsoft.Graph.Teams (install-module Microsoft.Graph.Teams)
Parameters:
	domain: Format contoso.org
	dictionary: Name of file in the same directory to bruteforce users. Format: username (without domain)
	team: Name of the team to create (not existent team)
	channel: Name of chanel for the team
History:	
20/02/2023 report to microsoft as information disclosure
21/02/2023 response from microsoft, not applicable


Author: Patricio Delclaux at oblowngo

#>
