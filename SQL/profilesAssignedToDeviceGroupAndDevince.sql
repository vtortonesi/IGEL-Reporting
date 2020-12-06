SELECT  -- pd.[NAME] as 'Profile Folder',
          p.[NAME] AS 'Profile Name', 
          ps.CLASSNAME AS 'Profile Setting',
          ps.PVALUE AS 'Profile Value'

FROM   igelums.PROFILESETTINGS ps  INNER JOIN igelums.PROFILES p ON ps.PROFILEID = p.PROFILEID 
INNER JOIN igelums.PROFILESTOREDIN prdin ON  p.PROFILEID = prdin.PROFILEID 
INNER JOIN igelums.PROFILEDIRECTORIES pd ON prdin.PDIRID = pd.PDIRID

WHERE pd.[Name] = @Profilefolder