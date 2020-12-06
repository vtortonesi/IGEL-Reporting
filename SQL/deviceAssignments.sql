SELECT tc.tcname AS 'Device',
	tc.LASTBOOTTIME AS 'Last Restart',
	tc.PROTOCOL AS 'Connection Type',
                d.[name] AS 'Device Group'
		 
FROM 	igelums.thinclient tc
	JOIN igelums.THINCLIENTISINDIRECTORY tid ON tc.TCID = tid.TCID
	JOIN igelums.DIRECTORIES d ON tid.DIRID = d.DIRID

WHERE d.Name = @devicegroup 
AND tc.PROTOCOL = @protocol