/*
What specific question am I trying to answer?
- Ano-anong factors ang nakakapag bigay ng good grades and bad grades
- Ano ang pinaka effective or mas na aabsorve ng student sa method ng pag tuturo
- May orrelation ba ang gender at edad sa result ng grades

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
LIMIT 50

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

--------------------------------------------------------------------------

SELECT *
FROM
    exams_predictions
    
/*
There are 20,000 students total in the data 
*/
SELECT
    COUNT(student_id) as total_students
FROM 
    exams_predictions

/*
There are 6,579 female students 
There are 6,726 who did not specify their gender
There are 6,695 male students 
*/
SELECT
    gender,
    count(student_id) as total_students
FROM
    exams_predictions
GROUP BY
    gender

/*
ba 2,896 female = 983 , male = 954 , other = 959
bba 2,836 female = 891, male = 969 , other = 976
b.com 2,864 female = 974 , male = 978 , other = 912
bca 2,902 female = 928 , male = 969 , other = 1005
b.tech 2,798 female = 975 , male = 897 , other 926
b.sc 2,878 female = 898, male = 1012 , other = 968
diploma 2,826 female = 930 , male = 916 , other = 980
*/
SELECT
    gender,
    course,
    count(student_id) as total_students
FROM
    exams_predictions
GROUP BY
    course,
    gender
ORDER BY
    gender,
    course

/*
STUDY METHOD
1. The most effective of teaching that has biggerst return is COACHING,
averaging 68.55% percent 

2. Mixed 64.24%

3. Group study 60.97%

4. Online Videos 60.15%

5. Self-Study 58.73%
*/
SELECT 
    study_method,
    ROUND(AVG(exam_score),2) AS avg_scores
FROM
    exams_predictions
GROUP BY
    study_method


/*
Exam Difficulty is NOT a key factor for grades 
*/
SELECT
    exam_difficulty, 
    ROUND(AVG(exam_score),2) as avg_score
FROM 
    exams_predictions
GROUP BY 
    exam_difficulty

/*
Gender is NOT a KEY factor
*/
SELECT 
    gender,
    ROUND(AVG(exam_score)) as avg_score
FROM
exams_predictions
GROUP BY 
    gender


SELECT 
    internet_access,
    COUNT(internet_access)
FROM
exams_predictions
GROUP BY 
    internet_access 

/*
Definitely the Facilty rating is one of the KEY factors of better results in students
*/
SELECT 
    count(student_id) as total_students,
    facility_rating,
    ROUND(AVG(exam_score),2)
FROM 
    exams_predictions
GROUP BY 
    facility_rating


SELECT
    CASE 
        WHEN study_hours > 4 THEN 'Low Study Hours' 
        WHEN study_hours BETWEEN 4 AND 7 THEN 'Medium Study Hours'
        ELSE 'Long Study Hours'
    END AS study_hourss,
    ROUND(AVG(exam_score),2) AS avg_score,
    MODE(facility_rating),
    MODE(study_method)
FROM
    exams_predictions
WITHIN GROUP
    study_hourss

