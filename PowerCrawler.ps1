#Get user credentials
$C = $host.UI.PromptForCredential('Your Credentials', 'Enter Credentials', '', '')

#Initialize Session
$R = Invoke-WebRequest 'https://www.website.com/login.php' -SessionVariable websitesession

#Set Login and Password
$Form = $R.Forms[0]
#Use F12 to determine appropriate form field ID
$Form.fields["user"] = $C.UserName
#Use F12 to determine appropriate form field ID
$Form.fields["pass"] = $C.GetNetworkCredential().Password
 
#Authenticate
Invoke-WebRequest -Uri ("https://www.website.com/login.php" + $Form.Action) -WebSession $websitesession -Method POST -Body $Form.Fields

#Download the pages
1262..1408 | 
ForEach-Object{
	write-output $_
	[io.file]::WriteAllText("C:\\Users\\Blah\\SiteContent\\$_.html",(Invoke-WebRequest -Uri "https://www.website.com/subdir/$_.html" -WebSession $websitesession))
}
