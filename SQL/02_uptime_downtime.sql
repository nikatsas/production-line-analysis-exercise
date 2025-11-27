--question 2:
--calculation of the total uptime and downtime of the whole production floor
--we measure the sum of duration (in seconds) where status is 'ON' and where it does not

SELECT
  SUM(CASE WHEN p1.status='ON' THEN DATEDIFF(SECOND, p1.timestamp, p2.timestamp) ELSE 0 END) AS totalUptime_in_sec,  --DATEDIFF used to calculate time difference between 2 chronological events. results presented in sec using 'SECOND'
  SUM(CASE WHEN p1.status<> 'ON' THEN DATEDIFF(SECOND, p1.timestamp, p2.timestamp) ELSE 0 END) AS totalDowntime_in_sec
FROM production_line_status p1
JOIN production_line_status p2
  ON p1.production_line_id=p2.production_line_id        --we match on the same prod line
  AND p2.timestamp =(                                    --subquery used to find next timestamp for the production line just after current event timestamp (p1.timestamp)
     SELECT MIN(timestamp)
     FROM production_line_status p3
     WHERE 1=1
      AND p3.production_line_id = p1.production_line_id
      AND p3.timestamp > p1.timestamp
  )
WHERE p2.timestamp IS NOT NULL                             --filtering only events that exist (and are not null) so as to calculate duration
