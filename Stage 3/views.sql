CREATE VIEW view_transport_summary AS
SELECT
  r.ride_id,
  p.patient_name,
  r.ride_date,
  mc.mc_name AS destination,
  d.volunteer_id AS driver_id,
  v1.name AS driver_name,
  ta.volunteer_id AS assistant_id,
  v2.name AS assistant_name
FROM Ride r
JOIN Patient p ON r.patient_id = p.patient_id
JOIN Medical_Center mc ON r.destination_name = mc.mc_name AND r.destination_address = mc.mc_address
LEFT JOIN Driver d ON r.driver_id = d.volunteer_id
LEFT JOIN Volunteer v1 ON d.volunteer_id = v1.volunteer_id
LEFT JOIN Transport_Assistant ta ON r.assistant_id = ta.volunteer_id
LEFT JOIN Volunteer v2 ON ta.volunteer_id = v2.volunteer_id;


SELECT 
  assistant_id, 
  assistant_name,
  COUNT(*) AS total_rides_assisted
FROM view_transport_summary
WHERE assistant_id IS NOT NULL
GROUP BY assistant_id, assistant_name
ORDER BY total_rides_assisted DESC;