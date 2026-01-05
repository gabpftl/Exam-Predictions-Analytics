### Exam Predictions Analysis

Project Progress

✅ Analysis

❌ Visualization / Power BI

Tools Used for this analysis

- LLM: Such as Claude AI, Comet Browser(LLM Integrated Browser)
-       1. Do not hand me codes, rather i want you to help me understand how am i going to code (Do not give codes)
        2. I am currently learning so as much as possible explain why(Why are these the codes that may be useful to the problem) and how (How am i actually going to implement this)
        3. Help me think Critically how am going to implement the codes and what kind of codes would best fit for the problems (Still Give hints how to code, not just logic and architecture)
        4. Always remind of the basic/fundamentals so that i get to practice the basic and master it
- VSCode
- PostgreSQL

Knowledge Used:

Basic Stats

Basic Maths

Analysis Objectives:

1. Identify how many students ✅
2. Identify numbers of genders ✅
3. Identify how many students per college ✅ 
4. Identify key factors of Good and Bad Grades ✅ 
5. Is there a correlation between grades and gender ✅
6. What is the most optimal sleep hours and study hours that would give a passing grade ❌
7. Identify whether the difficulty of exam has some effects to the results of exam scores of students ✅

Analysis Results (Not Yet Fully Finished)

## How many students are in each course?

```sql
SELECT 
    course,
    COUNT(course) AS Student_Enrolled
FROM
    exams_predictions
GROUP BY
    course
```

There are 20,000 Students in this analysis

## How many numbers of Genders in this university

```sql
SELECT
    gender,
    count(student_id) as total_students
FROM
    exams_predictions
GROUP BY
    gender
```

There are 6,579 female students
There are 6,726 who did not specify their gender
There are 6,695 male students

## Which Study Method have the best result

```sql
SELECT 
    study_method,
    ROUND(AVG(exam_score),2) AS avg_scores
FROM
    exams_predictions
GROUP BY
    study_method
```

STUDY METHOD 

1. The most effective of teaching that has biggerst return is COACHING, averaging 68.55% percent 

2. Mixed 64.24% 

3. Group study 60.97% 

4. Online Videos 60.15% 

5. Self-Study 58.73%
