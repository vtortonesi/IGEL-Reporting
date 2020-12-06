/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
 	tc.tcname AS 'Device',
	p.[name] 'Profile Name'


FROM igelums.PROFILES p JOIN igelums.DIRECTORYHASPROFILE dp ON p.profileid = dp.profileid 
JOIN igelums.DIRECTORIES d ON dp.dirid = d.dirid

JOIN igelums.THINCLIENTISINDIRECTORY tcd ON d.DIRID = tcd.DIRID
JOIN igelums.THINCLIENT tc ON tcd.TCID = tc.TCID

WHERE d.[NAME] = @directoryname



