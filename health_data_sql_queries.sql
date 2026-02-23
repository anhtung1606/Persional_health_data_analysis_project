-- Import file.csv vào Database (MySQL)
-- Cleaning data: kiểm tra data types, data format, xoá cột và giá trị Null không cần thiết 
-- Kiểm tra bảng: 
select distinct Attribute_type from health; 
describe health;
-- Lọc dữ liệu xu hướng vận động vào ngày cuối tuần:
SELECT 
    DATE(STR_TO_DATE(Attribute_startDate, '%d/%m/%y %H:%i')) AS step_date,
    SUM(Attribute_value) AS total_steps
FROM health
WHERE Attribute_type = 'HKQuantityTypeIdentifierStepCount'
  AND DAYOFWEEK(STR_TO_DATE(Attribute_startDate, '%d/%m/%y %H:%i')) IN (1, 7)
GROUP BY step_date
ORDER BY step_date;
-- Lọc ngày vận động nhiều nhất:
SELECT 
    step_date,
    total_steps
FROM (
    SELECT 
        DATE(STR_TO_DATE(Attribute_startDate, '%d/%m/%y %H:%i')) AS step_date,
        SUM(Attribute_value) AS total_steps
    FROM health
    WHERE Attribute_type = 'HKQuantityTypeIdentifierStepCount'
    GROUP BY step_date
) t
ORDER BY total_steps DESC
LIMIT 1;
-- Ngày vận động ít nhất: 
SELECT 
    step_date,
    total_steps
FROM (
    SELECT 
        DATE(STR_TO_DATE(Attribute_startDate, '%d/%m/%y %H:%i')) AS step_date,
        SUM(Attribute_value) AS total_steps
    FROM health
    WHERE Attribute_type = 'HKQuantityTypeIdentifierStepCount'
    GROUP BY step_date
) t
ORDER BY total_steps ASC
LIMIT 1;
-- Lọc hiển thị những ngày vận động nhiều (steps>8000):
SELECT 
    step_date,
    total_steps
FROM (
    SELECT 
        DATE(STR_TO_DATE(Attribute_startDate, '%d/%m/%y %H:%i')) AS step_date,
        SUM(Attribute_value) AS total_steps
    FROM health
    WHERE Attribute_type = 'HKQuantityTypeIdentifierStepCount'
    GROUP BY step_date
) t
WHERE total_steps > 8000
ORDER BY  step_date ASC;
-- Lọc và hiển thị có bao nhiêu ngày vận động ít (steps<1000):
SELECT COUNT(*) AS number_of_low_active_days
FROM (
    SELECT 
        DATE(STR_TO_DATE(Attribute_startDate, '%d/%m/%y %H:%i')) AS step_date,
        SUM(Attribute_value) AS total_steps
    FROM health
    WHERE Attribute_type = 'HKQuantityTypeIdentifierStepCount'
    GROUP BY step_date
) t
WHERE total_steps < 1000;
-- “Trong những ngày đi bộ nhiều (step > 8000), nhịp tim nghỉ trung bình (Resting Heart Rate) là bao nhiêu?”
SELECT 
    s.step_date,
    s.total_steps,
    r.avg_resting_hr
FROM (
    SELECT 
        DATE(STR_TO_DATE(Attribute_startDate, '%d/%m/%y %H:%i')) AS step_date,
        SUM(Attribute_value) AS total_steps
    FROM health
    WHERE Attribute_type = 'HKQuantityTypeIdentifierStepCount'
    GROUP BY step_date
) s
JOIN (
    SELECT 
        DATE(STR_TO_DATE(Attribute_startDate, '%d/%m/%y %H:%i')) AS hr_date,
        AVG(Attribute_value) AS avg_resting_hr
    FROM health
    WHERE Attribute_type = 'HKQuantityTypeIdentifierRestingHeartRate'
    GROUP BY hr_date
) r
ON s.step_date = r.hr_date
WHERE s.total_steps > 8000
ORDER BY s.total_steps DESC;


