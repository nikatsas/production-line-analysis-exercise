--question 3:
--returns production line with the most downtime and how much that was
--status that is not 'ON' will be considered as downtime

SELECT TOP 1
  p1.production_line_id AS production_line_id,
  SUM(DATEDIFF(SECOND, p1.timestamp, p2.timestamp)) AS totalDowntime_in_sec
FROM production_line_status p1
JOIN production_line_status p2 
  ON p1.production_line_id = p2.production_line_id       --we match on the same prod line
 AND p2.timestamp= (                                     --using subquery as in exerc2
     SELECT MIN(timestamp)
     FROM production_line_status p3
     WHERE 1=1
      AND p3.production_line_id=p1.production_line_id
      AND p3.timestamp> p1.timestamp
 )
WHERE p1.status<>'ON'                          --filtering only downtime status
GROUP BY p1.production_line_id                 --grouped downtimes per prod line
ORDER BY totalDowntime_in_sec DESC             --returns totalDowntimes desc sorted. through select top 1 at the beggining, we keep only the greatest value
