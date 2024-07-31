MERGE INTO MEETINGS AS target
USING (
    SELECT 
        ? as type,
        ? as registerDate,
        ? as meetingType,
        ? as meetingDate,
        ? as startTime,
        ? as finalTime,
        ? as score,
        ? as qualificationDatetime,
        ? as id,
        ? as leadId,
        ? as user_id,
        ? as id_empresa_exact
) AS source
ON target.id = source.id
WHEN MATCHED THEN
    UPDATE SET      
         type = source.type,
         registerDate = source.registerDate,
         meetingType = source.meetingType,
         meetingDate = source.meetingDate,
         startTime = source.startTime,
         finalTime = source.finalTime,
         score = source.score,
         qualificationDatetime = source.qualificationDatetime,
         leadId = source.leadId,
         user_id = source.user_id,
         id_empresa_exact = source.id_empresa_exact
WHEN NOT MATCHED THEN
    INSERT (type, registerDate, meetingType, meetingDate, startTime, finalTime, score, qualificationDatetime, leadId, user_id, id_empresa_exact)
    VALUES (source.type, source.registerDate, source.meetingType, source.meetingDate, source.startTime, source.finalTime, source.score, source.qualificationDatetime, source.leadId, source.user_id, source.id_empresa_exact);