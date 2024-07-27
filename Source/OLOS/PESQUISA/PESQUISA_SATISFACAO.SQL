SELECT 
a.id,
a.CallidTelecom,
a.Campaignld,
a.Instant,
a.MilesStoneCount,
a.MileStoneDescription,
CASE
        WHEN PATINDEX('%[0-9]%', REVERSE(a.MileStoneDescription)) > 0 
        THEN REVERSE(SUBSTRING(REVERSE(a.MileStoneDescription), 1, PATINDEX('%[^0-9]%', REVERSE(a.MileStoneDescription) + 't') - 1))
        ELSE ''
    END AS Nota,
b.Description,
c.Customerld,
c.OriginalPhoneNumber
 FROM milestonerawdata A with (nolock)
 LEFT JOIN Campaign B with (nolock) on a.Campaignld = b.Campaignld
 LEFT JOIN AttemptsRawData c WITH (nolock) on a.CallidTelecom = c.CallIdTelecom