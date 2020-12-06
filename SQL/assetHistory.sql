SELECT tc.tcname 'Device Name', 
	   ai.Connector 'Connector Type', 
	   ai.Vendor 'Asset Vendor', 
	   ai.Device_Name 'Asset Deivce Name', 
	   ah.event_Timestamp 'Event Timestamp', 
	   ah.Event_Type ' Event Type'

FROM igelums.thinclient tc
JOIN igelums.asset_history ah
ON tc.unit_id = ah.unit_id
JOIN igelums.asset_info ai ON ah.asset_id = ai.asset_id

WHERE ah.EVENT_TIMESTAMP BETWEEN (@startTime) AND (@endtime)