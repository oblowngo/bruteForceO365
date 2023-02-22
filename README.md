# bruteFroceO365
Brute force usernames fron another tenant
</br><pre>
Explain:
	&emsp;&emsp;&emsp;&emsp;Brute force o365 tenant accounts (username). Similar to vrfy command
Prerequisites:
	&emsp;&emsp;&emsp;&emsp;Own a Tenant
	&emsp;&emsp;&emsp;&emsp;Cross tenant policy block 
Modules:
	&emsp;&emsp;&emsp;&emsp;MicrosoftTeams (install-module MicrosoftTeams)
	&emsp;&emsp;&emsp;&emsp;Microsoft.Graph.Teams (install-module Microsoft.Graph.Teams)
Parameters:
	&emsp;&emsp;&emsp;&emsp;domain: Format contoso.org
	&emsp;&emsp;&emsp;&emsp;dictionary: Name of file in the same directory to bruteforce users. Format: username (without domain)
	&emsp;&emsp;&emsp;&emsp;team: Name of the team to create (not existent team)
	&emsp;&emsp;&emsp;&emsp;channel: Name of chanel for the team
History:	
&emsp;&emsp;&emsp;&emsp;20/02/2023 report to microsoft as information disclosure
&emsp;&emsp;&emsp;&emsp;21/02/2023 response from microsoft, not applicable
</pre>

Author: Patricio Delclaux at oblowngo


