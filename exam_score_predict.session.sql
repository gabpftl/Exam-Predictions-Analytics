/*
What specific question am I trying to answer?
- Ano-anong factors ang nakakapag bigay ng good grades and bad grades
- Ano ang pinaka effective or mas na aabsorve ng student sa method ng pag tuturo
- Correlation ba ang high grades sa gender and ano ang edad ng isang student 

Who will use this analysis?
- Ang gagamit ng rults nito ay ang mga principal or kung sino man 
ang namamahala sa isang school whether to improve facility or their way of teaching

What does success look like?
- Success nito for me is makapag build ng dashboard and makagawa ng recomendation on whats effective 
and not effective methods of teaching 
*/

----------------------------------------------------------------------------------------------------------------

SELECT *
FROM
    exams_predictions
LIMIT 5

/*
How many students are in each course?
*/
SELECT 
    course,
    COUNT(course) AS Student_Enrolled
FROM
    exams_predictions
GROUP BY
    course

/*
What percentage of students have internet access?
*/
SELECT
    COUNT(student_id) as total_students,
    SUM(CASE WHEN internet_access = 'TRUE' THEN 1 ELSE 0 END) as with_internet,
    ROUND(AVG(CASE WHEN internet_access = 'TRUE' THEN 1 ELSE 0 END) * 100, 2) as percentage_with_internet
FROM    
    exams_predictions

/*
What's the average sleep hours for students who scored above 80?
*/
SELECT
    ROUND(AVG(sleep_hours)) AS avg_sleep 
FROM
    exams_predictions
WHERE 
    exam_score >= 80

/*
Does class attendance correlate with exam scores?
*/
SELECT
    CASE
        WHEN class_attendance >= 80 THEN 'High Attendance Rate'
        WHEN class_attendance BETWEEN 50 AND 79 THEN 'Medium Attendance Rate'
        ELSE 'Low Attendance Rate'
    END AS Attendance_Rate,

    COUNT(student_id) AS num_studs,
    ROUND(AVG(exam_score),2) AS avg_scores

FROM
    exams_predictions
GROUP BY 
    Attendance_Rate

/*
How many percent of student who have high grades and their quality of sleep
*/
SELECT 
    sleep_quality,
    COUNT(student_id) AS total_students,
    COUNT(CASE WHEN exam_score >= 90 THEN 1 END) AS high_grade_students,
    ROUND(COUNT(CASE WHEN exam_score >= 90 THEN 1 END ) * 100 / COUNT(student_id), 2) AS student_highgrades
FROM
    exams_predictions
GROUP BY
    sleep_quality
HAVING
    sleep_quality = 'good'

--6619 of students who have Good sleep squality only 12% of them who scored 90 and up.

/*
What's the relationship between study hours and exam scores? (Group students into study hour brackets: 0-5, 6-10, 11-15, 16+)
*/
SELECT
    CASE
        WHEN sleep_hours IS NULL THEN 'No Recorded Data'
        WHEN sleep_hours < 5 THEN 'Low Sleep'
        WHEN sleep_hours BETWEEN 5 AND 6.9 THEN 'Medium Rest'
        ELSE 'Full Sleep'
    END AS Levels_Of_Sleep,
    COUNT(student_id) AS total_students,
    ROUND(AVG(exam_score),2) AS exam_score
FROM
    exams_predictions
GROUP BY
    Levels_Of_Sleep

ORDER BY
    exam_score

/*
What's the gender distribution in each course?
*/
SELECT 
    gender,
    course,
    COUNT(student_id)
FROM
    exams_predictions
GROUP BY 
    gender,
    course
ORDER BY
    gender,
    course

/*
How many students have low facility ratings AND less than 6 hours of sleep?
*/
SELECT
    COUNT(student_id) AS lowSleep_and_low_facility
FROM
    exams_predictions
WHERE 
    facility_rating = 'low' AND sleep_hours <= 6

