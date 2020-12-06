SELECT tc.tcname 'Device Name',
	   p.[Name] AS 'Profile',
	   COALESCE (ps.Classname, 'No Profile Setting') AS 'Profile Setting',
	   COALESCE (ps.PValue, 'No Profile Value') AS 'Profile Value'
FROM igelums.THINCLIENTHASPROFILE tcp JOIN igelums.THINCLIENT tc
ON tcp.TCID = tc.TCID
JOIN igelums.PROFILES p ON tcp.PROFILEID = p.PROFILEID

LEFT JOIN igelums.PROFILESETTINGS ps ON p.PROFILEID = ps.PROFILEID