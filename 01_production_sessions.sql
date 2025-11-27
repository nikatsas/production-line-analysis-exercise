--question 1:
--outcome is the production process phases only for the production line 'gr-np-47'
--Attention! Take into consideration that termination status is STOP -and not END as mentioned in email's exercise.

SELECT
  start.production_line_id AS production_line_id,
  start.timestamp AS start_timestamp,
  MIN(stop.timestamp) AS stop_timestamp,              --smallest timestamp after start
  DATEDIFF(SECOND, start.timestamp, MIN(stop.timestamp)) AS duration_in_sec  --session's duration (calculated in seconds)
FROM production_line_status start
JOIN production_line_status stop
  ON start.production_line_id = stop.production_line_id    --we match on the same prod line
  AND stop.timestamp > start.timestamp                     --make sure that STOP time is after START time
WHERE 1=1
AND start.production_line_id = 'gr-np-47'                  --filtering for specific production line as mentioned
AND start.status = 'START'                                 
AND stop.status = 'STOP'                                 
GROUP BY start.production_line_id, start.timestamp         --group by start event so as to pair with stop
ORDER BY start.timestamp                                   
