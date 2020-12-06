SELECT 
	d.[Name] AS 'Device Group',
	tc.tcname AS 'Device Name', 
	tc.LastKnownIP AS 'Last Known IP Address', 
	tc.LastBootTime AS 'Last Boot Time', 
	COALESCE(tc.UMS_Structure_Tag, 'No Structure Tag') AS 'Structure Tag',
	COALESCE(tc.tccomment, 'No Comment') AS 'Device Comment',
	ai.Connector AS 'Connector Type',
	ai.Vendor AS 'Device Vendor',
	ai.Device_Name AS 'Asset Name'

FROM igelums.THINCLIENT tc
	 JOIN igelums.ASSET_TO_TC atc ON tc.TCID = atc.TCID
	 JOIN igelums.ASSET_INFO ai ON atc.ASSET_ID = ai.ASSET_ID
	 JOIN igelums.THINCLIENTISINDIRECTORY tcd  ON tc.TCID = tcd.TCID
                 JOIN igelums.DIRECTORIES D ON tcd.DIRID = d.DIRID

WHERE d.[Name] = @deviceGroup
